<%-- 
    Document   : MEDICINE HEAD
    Created on : 19 Oct, 2018, 11:14:54 AM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%

  String catdetailid="";
  String eid="",tagno="";
  String medhid="";
  String mdate="";
  if(request.getParameter("btnsubmit")!=null)
  {
     
        catdetailid=request.getParameter("selcattle");
        mdate=request.getParameter("txtmdate");
         
      if(request.getParameter("hideeditid")!=null)
      {
          String h=request.getParameter("hideeditid");
          String edit="update tbl_medicinehead set cattleD_id='"+catdetailid+"',medicineH_date='"+mdate+"' where medicineH_id='"+h+"'";
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
      String ins="insert into tbl_medicinehead(cattleD_id,medicineH_date) values('"+catdetailid+"','"+mdate+"')";
      
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
      String sel="Select * from tbl_medicinehead where medicineH_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
         medhid=res.getString("medicineH_id");
         catdetailid=res.getString("cattleD_id");
          mdate=res.getString("medicineH_date");
          
          
          
          
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_medicineH where medicineH_id='"+did+"'";
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
        <title>Medicine</title>
    </head>
    <body>
        <center>
             <h1>MEDICINE</h1>
            <form>
                <table>
                    
                    <tr>
                        <td>Ear Tagno:</td>
                                <td>
                            <select name="selcattle" required="">
                                <option>--select--</option>
                            <%
                            
                            String s="select * from tbl_cattledetails";
                            ResultSet rest=con.selectCommand(s);
                            while(rest.next())
                            {
                                catdetailid=rest.getString("cattleD_id");
                                tagno=rest.getString("cattleD_eartagno");
                                
                            
                            %>
                            <option value="<%=rest.getString("cattleD_id")%>"><%=tagno%></option> 
                            
                             <%
                            }
                            %>

                            </select>
                       
                       
                    </tr>
                    <tr>
                    <td>Medicine Date </td>
                    <td><input type="date" name="txtmdate" value="<%=mdate%>" required="" ></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
               </tr>
                                       
                      
                    <tr>
                        <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
                        <td><input type="reset" name="btncancel" value="CANCEL"></td>
                    </tr>
                </table>
                            <table border="1">
                                <tr>
                                    <td>Sl.No</td>
                                    <td>Ear TagNo</td>
                                    <td>Medicine Date</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
                                <%
                            String sel="select * from tbl_medicinehead mh inner join tbl_cattledetails cd on mh.cattleD_id=cd.cattleD_id";

                            ResultSet res=con.selectCommand(sel);
                            while(res.next())
                            {
                                String mhid=res.getString("medicineH_id");
                                String cattledid=res.getString("cattleD_id");
                                String mhdate=res.getString("medicineH_date");
                            
                             %> 
                             <tr>
                                 <td><%=medhid%></td>
                                 <td><%=cattledid%></td>
                                 <td><%=mhdate%></td>
                                 <td><a href="MEDICINE HEAD.jsp?editid=<%=medhid%>">Edit</a></td>
                                 <td><a href="MEDICINE HEAD.jsp?deleteid=<%=medhid%>">Delete</a></td>
                             </tr>
                            
                             <%
                             }
                             %>
                             
                            
                         
                                
                            </table>          
            </form>
        </center>
       
        
    </body>
</html>
<%@include file="footer.jsp" %>

