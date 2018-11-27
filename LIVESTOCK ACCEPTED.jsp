<%-- 
    Document   : LIVESTOCK ACCEPTED
    Created on : 10 Nov, 2018, 9:31:45 AM
    Author     : DEEPA
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
           <h1 align="center">LIVESTOCK ACCEPTED LIST</h1>
    <%
        if(request.getParameter("rid")!=null)
        {
           String up="update tbl_livestock set _status='2' where livestock_id='"+request.getParameter("rid")+"'";
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
                    <td>PROOF</td>
                    <td>QUALIFICATION</td>
                    <td>ACCEPT</td>
                    <td>REJECT</td>
                  
                   
                </tr>
                <%
                   String st="select * from tbl_livestock l inner join tbl_place p on l.place_id=p.place_id";
                       
                   ResultSet rs=con.selectCommand(st);//import
                   int i=1;
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
                      String proof=rs.getString("livestock_proof");
                      String quali=rs.getString("livestock_quali");
                      
                      
                       
                              
                       
                       %>
                       <tr> 
                          <td><%=i%></td>
                             <td><%=lname%> </td>
                             <td><%=laddr%></td>
                             <td><%=place%></td>
                           <td><%=gender%></td>
                           <td><%=dob%></td>
                           <td><%=contact%></td>
                           <td><%=email%></td>
                            <td><%=quali%></td>
                             
                             
                             
                           
                           
                           <td><img src="../Farmer/Proof/<%=proof%>" width="100" height="100"></td>
           
                           
                           
                         
                         <td><a href="LIVESTOCK ACCEPTED.jsp?rid=<%=rs.getString("livestock_id")%>">REJECT </a></td></tr>
                       
                       <%
                       
                       
                       i++;
                   }
                %>
            </table>
            
            
        
     
    </body>
</html>


