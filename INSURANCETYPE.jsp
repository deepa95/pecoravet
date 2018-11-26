<%-- 
    Document   : INSURANCETYPE
    Created on : 18 Nov, 2018, 2:30:57 PM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
  String iname="";
  String pamt="";
  String eid="";
  String pid="";
  String id="";
  String ldate="";
  if(request.getParameter("btnsubmit")!=null)
  {
      iname=request.getParameter("txtiname");
      pamt=request.getParameter("selcat");
      ldate=request.getParameter("txtldate");
      if(request.getParameter("hideeditid")!="")
      {
          String h=request.getParameter("hideeditid");
          String edit="update tbl_insurancetype set insurancetype_name='"+iname+"', premium_id='"+pamt+"',last_dateto_apply='"+ldate+"' where insurancetype_id='"+h+"'";
          if(con.executeCommand(edit))
          {
              out.println("Update Successfull");
          }
          else
          {
              out.println("Unsuccessful");
          }
      }
      else
      {
      String ins="insert into tbl_insurancetype(insurancetype_name,premium_id,last_dateto_apply) values('"+iname+"','"+pamt+"','"+ldate+"')";
      if(con.executeCommand(ins))
      {
          out.println("Inserted Successfully");
      }
      else
      {
          out.println("Unsuccessful insertion"+ins);
      }
     }
  }
      
  if(request.getParameter("editid")!=null)
  {
      eid=request.getParameter("editid");
      String sel="select * from tbl_insurancetype it inner join tbl_premium p on it.premium_id=p.premium_id where insurancetype_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
          id=res.getString("insurancetype_id");
          iname=res.getString("insurancetype_name");
          pamt=res.getString("premium_id");
          ldate=res.getString("last_dateto_apply");
          
          
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_insurancetype where insurancetype_id='"+did+"'";
      if(con.executeCommand(del))
      {
          out.println("Delete Succesfull");
      }
      else
      {
          out.println("Unsuccessful");
      }
  }
      
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insurance type form</title>
    </head>
    <body>
        <center>
             <h1>INSURANCE TYPE</h1>
            <form>
                <table
                    
                    <tr>
                        <td>Insurance Name:</td>
                        <td><input type="text" name="txtiname" value="<%=iname%>" required=""></td>
                        <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
                    </tr>
                    <tr>
                        <td>Premium Amount:</td>
                                <td>
                            <select name="selcat" required="">
                                <option>--select--</option>
                            <%
                            
                            String sl="select * from tbl_premium";
                            ResultSet res=con.selectCommand(sl);
                            while(res.next())
                            {
                                pid=res.getString("premium_id");
                                pamt=res.getString("premium_amt");
                                
                            
                            %>
                            <option value="<%=res.getString("premium_id")%>"><%=pamt%></option> 
                            
                             <%
                            }
                            %>
                            </select>
                       
                    </tr>
                    <tr>
                        <td>Last Date:</td>
                        <td><input type="date" name="txtldate" value="<%=ldate%>" required=""></td>
                        <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
                    </tr>
                                       
                      
                    <tr>
                        <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
                        <td><input type="reset" name="btncancel" value="CANCEL"></td>
                    </tr>
                </table>
                            <table border="1">
                                <tr>
                                    <td>Sl.No</td>
                                    <td>Item Name</td>
                                    <td>Category Name</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
                                <%
                            String sel="select * from tbl_insurancetype it inner join tbl_premium p on it.premium_id=p.premium_id";
                            ResultSet rest=con.selectCommand(sel);
                            int i=1;
                            while(rest.next())
                            {
                                String typeid=rest.getString("insurancetype_id");
                                String insname=rest.getString("insurancetype_name");
                                String amt=rest.getString("premium_amt");
                                String date=rest.getString("last_dateto_apply");
                            
                             %> 
                             <tr>
                                 <td><%=i%></td>
                                 <td><%=insname%></td>
                                 <td><%=amt%></td>
                                 <td><%=date%></td>
                                 <td><a href="INSURANCETYPE.jsp?editid=<%=typeid%>">Edit</a></td>
                                 <td><a href="INSURANCETYPE.jsp?deleteid=<%=typeid%>">Delete</a></td>
                             </tr>
                            
                             <%
                             i++;
                             }
                             %>
                             
                            
                         
                                
                            </table>          
            </form>
        </center>
       
        
    </body>
</html>
<%@include file="footer.jsp" %>

