<%-- 
    Document   : ViewCompanyDetails
    Created on : 9 Jul, 2018, 7:48:07 PM
    Author     : Alisha
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="obj" class="pkg.ConnectionClass"></jsp:useBean>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 align="center">INSURANCE APPLICATION</h1>
    <%
            
            if(request.getParameter("aid")!=null)
            {
                String accept=request.getParameter("aid");
                String acQry="update tbl_insurance set insurance_status='accepted' where insurance_id='"+accept+"'";
                boolean b= obj.executeCommand(acQry);
                if(b==true)
                {
                    out.println("Accepted");
                }
                else
                {
                    System.out.println(acQry);
                }
            }

            
            
            if(request.getParameter("rid")!=null)
            {
                String reject=request.getParameter("rid");
                String acQry="update tbl_insurance set insurance_status='rejected' where insurance_id='"+reject+"'";
                boolean b= obj.executeCommand(acQry);
                if(b==true)
                {
                    out.println("Rejected");
                }
                else
                {
                    System.out.println(acQry);
                }
            }
            
        %>    
        <table align="center" border="2">
            <tr>
                <th>SL NO</th>
                <th>INSURANCE NAME</th>
                <th>TAG NO</th>
                <th>DATE</th>
                <th>USER NAME</th>
                
                
              <th colspan="2">STATUS</th>
            </tr>
            <tr>
    <%
        String insname="",tagno="",insdate="",username="",insid="";
        int i=1;
        
            String sel="select * from tbl_insurance i inner join tbl_insurancetype it inner join tbl_cattledetails c inner join tbl_user u on i.insurancetype_id=it.insurancetype_id and i.user_id=u.user_id and i.cattleD_id=c.cattleD_id where insurance_status='0'";
            System.out.println(sel);
            ResultSet rs=obj.selectCommand(sel);
            while(rs.next())
            {
                insid=rs.getString("insurance_id");
                insname=rs.getString("insurancetype_name");                
                tagno=rs.getString("cattleD_eartagno");
                insdate=rs.getString("insurance_date");
                username=rs.getString("user_name");
                
    %>
                <td><%=i%></td>
                <td><%=insname%></td>
                <td><%=tagno%></td>
                <td><%=insdate%></td>
                <td><%=username%></td>
                
                <td><a href="VIEW INSURANCE APPLICATION.jsp?rid=<%=rs.getString("insurance_id")%>">REJECT </a></td>
                <td><a href="VIEW INSURANCE APPLICATION.jsp?aid=<%=rs.getString("insurance_id")%>">ACCEPT </a></td>
            </tr>
    <%
                i++;
            }
    %>
            </tr>
        </table>
            
        
    </body>
</html>
<%@include file="footer.jsp" %>
