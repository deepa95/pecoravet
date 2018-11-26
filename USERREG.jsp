<%-- 
    Document   : USERREG
    Created on : 19 Oct, 2018, 11:13:01 AM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<!DOCTYPE html>
<%
    String fname="",faddr="",fgender="",fdob="",fcontact="",femail="",fuser="",fpass="",lproof="";

    if(request.getParameter("btnsubmit")!=null)
    {
        fname=request.getParameter("txtname");
        faddr=request.getParameter("txtaddr");
        fgender=request.getParameter("gender");
        fdob=request.getParameter("txtdob");
        fcontact=request.getParameter("txtcontact");
        femail=request.getParameter("txtemail");
        fuser=request.getParameter("txtuser");
        fpass=request.getParameter("txtpass");
        
        
        
 }
    
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FARMER REGISTRATION</title>
    </head>
    <body>
       <center> 
        <h1>FARMER REGISTRATION</h1>
        <form action="UserUploadaction.jsp" enctype="multipart/form-data" method="post">
            <table>
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="txtname" required=""></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><textarea name="txtaddr"></textarea></td>
                </tr>
                <tr>
                    <td>Gender:</td>
                    <td><input type="radio" name="gender" value="Male" required="">Male
                    <input type="radio" name="gender" value="Female">Female</td>
                </tr>
                <tr>
                    <td>Date of birth:</td>
                    <td><input type="date" name="txtdate" required=""></td>
                </tr>
                <tr>
                    <td>Contact No:</td>
                    <td><input type="tel" name="txtcontact" required="" pattern=""></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="txtemail" required="" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">></td>
                </tr>
                
                <tr>
                    <td>Proof</td>
                    <td><input type="file" name="txtproof" required=""></td>
                </tr>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="txtuser" required=""></td>
                </tr>
                <tr>
                     <td>Password:</td>
                    <td><input type="Password" name="txtpass" required="" pattern=".{6,}"></td>
                </tr>
                <tr>
                    <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
                    <td><input type="Reset" name="btncancel" value="CANCEL"></td>
                </tr>
                    
                    
                    
                  
            </table>            
        </form>
       </center>  
    </body>
</html>
<%@include file="footer.jsp" %>

