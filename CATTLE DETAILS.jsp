<%-- 
    Document   : CATTLE DETAILS
    Created on : 19 Oct, 2018, 11:13:28 AM
    Author     : DEEPA
--%>


<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
  String tagno="";
  String cattlecatid="";
  String cattlecatname="";
  String cddate="";
  String eid="",id="";
  String name="";
  String date="";
  String userid="";
  if(request.getParameter("btnsubmit")!=null)
  {
      tagno=request.getParameter("txttagno");
      cattlecatid=request.getParameter("selname");
      date=request.getParameter("txtcddate");
      name=request.getParameter("sel");
      if(request.getParameter("hideeditid")!="")
      {
          String h=request.getParameter("hideeditid");
          String edit="update tbl_cattledetails set cattleD_eartagno='"+tagno+"', cattlecat_id='"+cattlecatid+"',cattleD_date='"+cddate+"', user_id='"+userid+"' where cattleD_id='"+h+"'";
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
      String ins="insert into tbl_cattledetails(cattleD_eartagno,cattlecat_id,cattleD_date,user_id) values('"+tagno+"','"+cattlecatid+"','"+cddate+"','"+name+"')";
      System.out.println(ins);
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
      String sel="Select * from tbl_cattledetails where cattleD_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
          
          tagno=res.getString("cattleD_eartagno");
          cattlecatid=res.getString("cattlecat_id");
          date=res.getString("cattleD_date");
          userid=res.getString("user_id");
          id=res.getString("cattleD_id");
          
          
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_cattledetails where cattleD_id='"+did+"'";
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <center> 
            <h1>CATTLE DETAILS</h1>
        <form>
            <table>
                <tr>
                    <td>Ear Tagno: </td>
                    <td><input type="text" name="txttagno" value="<%=tagno%>" required="" ></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
               </tr>
                
                <tr>
                        <td>Cattle Category Name:</td>
                                <td>
                            <select name="selname" required="">
                                <option>--select--</option>
                            <%
                            
                            String sl="select * from tbl_cattle_category";
                            ResultSet res=con.selectCommand(sl);
                            while(res.next())
                            {
                                cattlecatid=res.getString("cattlecat_id");
                                cattlecatname=res.getString("cattlecat_name");
                            
                            %>
                             <option <%if (cattlecatid.equals(id)){%> selected=""<%}%> value="<%=cattlecatid%>"><%=cattlecatname%></option>
                            
                             <%
                            }
                            %>

                            </select>
                       
                    </tr>
                    <tr>
                    <td>Date: </td>
                    <td><input type="date" name="txtcddate" value="<%=cddate%>" required="" ></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
               </tr>
                                       
                <tr>
                        <td>User Name:</td>
                                <td>
                            <select name="sel" required="">
                                <option>--select--</option>
                            <%
                            
                            String sel="select * from tbl_user";
                            ResultSet rset=con.selectCommand(sel);
                            while(rset.next())
                            {
                                userid=rset.getString("user_id");
                                name=rset.getString("user_name");
                            
                            %>
                             <option <%if (userid.equals(id)){%> selected=""<%}%> value="<%=userid%>"><%=name%></option> 
                            
                             <%
                            }
                            %>

                            </select>
                       
                    </tr>    
                
                <tr>
                    <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
                     <td><input type="reset" name="btncancel" value="CANCEL"></td>
                </tr>
                </table>
                             <table border="1">
                                <tr>
                                    <td>Sl.No</td>
                                    <td>Ear Tagno</td>
                                    <td>Cattle Category Name</td>
                                    <td>Date</td>
                                    <td>User Name</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
         <%
                            String select="select * from tbl_cattledetails cd inner join tbl_cattle_category cc inner join tbl_user u on cd.cattlecat_id=cc.cattlecat_id and cd.user_id=u.user_id";
                            ResultSet rest=con.selectCommand(select);
                            int i=1;
                            while(rest.next())
                            {
                                String cattleDid=rest.getString("cattleD_id");
                                String earno=rest.getString("cattleD_eartagno");
                                String catname=rest.getString("cattlecat_id");
                                String catdate=rest.getString("cattleD_date");
                                String user=rest.getString("user_name");
                            
                             %> 
                             <tr>
                                 <td><%=i%></td>
                                 <td><%=earno%></td>
                                 <td><%=catname%></td>
                                 <td><%=catdate%></td>
                                 <td><%=user%></td>
                                 <td><a href="CATTLE DETAILS.jsp?editid=<%=cattleDid%>">Edit</a></td>
                                 <td><a href="CATTLE DETAILS.jsp?deleteid=<%=cattleDid%>">Delete</a></td>
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

