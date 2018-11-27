<%-- 
    Document   : LIVESTOCK DETAILS
    Created on : 9 Nov, 2018, 9:16:48 PM
    Author     : DEEPA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <table border="1" align="center">
           <tr>LIVESTOCK DETAILS</tr>
                <tr>
                    <td>SL.NO</td>
                    <td>NAME</td>
                    <td>ADDRESS</td>
                    <td>PLACE</td>
                     <td>GENDER</td>
                    <td>DATE OF BIRTH</td>
                    <td>CONTACT</td>
                    <td>E-MAIL</td>
                    <td>QUALIFICATION</td>
                    <td>PROOF</td>                  
                    <td>ACCEPT</td>
                    <td>REJECT</td>
                </tr>   
       <%
                   String st="select * from tbl_livestock l inner join tbl_place p on l.place_id=p.place_id";
                       
                   ResultSet rs=con.selectCommand(st);//import
                   while(rs.next())
                   {
                       String lid=rs.getString("livestock_id");//get values from state table
                       String lname=rs.getString("livestock_name");
                       String laddr=rs.getString("livestock_addr");
                       String place=rs.getString("place_id");
                      String gender=rs.getString("gender");
                      String dob=rs.getString("dob");
                      String contact=rs.getString("livestock_contact");
                      String email=rs.getString("livestock_email");
                      String quali=rs.getString("livestock_quali");
                      String proof=rs.getString("livestock_proof");
                      
                      
                       if(request.getParameter("acceptid")!=null)
                       {
                           String up="update tbl_livestock set livestock_status='1' where livestock_id='"+request.getParameter("acceptid")+"'";
                           if(con.executeCommand(up))
                           {
                               out.println("ACCEPTED");
                           }
                           else
                           {
                               out.println(up);
                           }
      
                           
                       }
                         if(request.getParameter("rejectid")!=null)
                       {
                           String up="update tbl_livestock set livestock_status='2' where livestock_id='"+request.getParameter("rejectid")+"'";
                           if(con.executeCommand(up))
                           {
                               out.println("REJECTED");
                           }
                           else
                           {
                               out.println(up);
                           }
      
                           
                       }
                              
                       
                       %>
                       <tr> 
                           <td> <%=lid%></td>
                             <td><%=lname%> </td>
                             <td><%=laddr%></td>
                             <td><%=place%></td>
                           <td><%=gender%></td>
                           <td><%=dob%></td>
                            <td><%=contact%></td>
                             <td><%=email%></td>
                             <td><%=quali%></td>
                             <td><%=proof%></td>
                             
                             
                          
                           
                           <td><img src="../LIFESTOCK INSPECTOR/Proof/<%=proof%>" width="100" height="100"></td>
           
                           
                           
                         
                          <td> <a href=" LIVESTOCK DETAILS.jsp?acceptid=<%=lid%>">ACCEPT</a></td>
                          <td><a href="LIVESTOCK DETAILS.jsp?rejectid=<%=lid%>">REJECT</a></td></tr>
                       
                       <%
                       
                       
                       
                   }
                %>
            </table>
            
            
     
 
    </body>
</html>


