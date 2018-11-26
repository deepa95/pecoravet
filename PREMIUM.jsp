<%-- 
    Document   : PREMIUM
    Created on : 19 Oct, 2018, 11:14:08 AM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String eid="",pay="",caste="",pamt="";
    if(request.getParameter("btnsubmit")!=null)
  {
       pamt=request.getParameter("txtamt");
       pay=request.getParameter("txtpay");
       caste=request.getParameter("sel");
     if(request.getParameter("hideeditid")!="")
     {
         String h=request.getParameter("hideeditid");
         String edit="update tbl_premium set premium_amt='"+pamt+"',premium_payable='"+pay+"',premium_caste='"+caste+"' where premium_id='"+h+"'";
         if(con.executeCommand(edit))
         {
             out.println("Update Succesfully");
             
         }
         else
         {
             out.println("Unsuccessful");
         }
     }
     else
     {
      String ins="insert into tbl_premium(premium_amt,premium_payable,premium_caste) values('"+pamt+"','"+pay+"','"+caste+"')";
      if(con.executeCommand(ins))
      {
          out.println("inserted Succesfull");
         
      }
      else
      {
          out.println("Unsuccessful Insertion"+ins);
      }
     }
  }
  
  if(request.getParameter("editid")!=null)
  {
      eid=request.getParameter("editid");
      String sel="select * from tbl_premium where premium_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
       pamt=res.getString("premium_amt");
       pay=res.getString("premium_payable");
       caste=res.getString("premium_caste");
       
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_premium where premium_id='"+did+"'";
      if(con.executeCommand(del))
      {
          out.println("Delete Sucessfull");
          
      }
      else
      {
          out.println("Unsuccessful");
      }
  }
    
    
    %><!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <center>
    <form>
       <table>
        <h1>PREMIUM</h1>
        <tr>
            <td>Premium Amount:</td>
            <td><input type="text" name="txtamt" value="<%=pamt%>" required=""></td>
            <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
        </tr>
         <tr>
            <td>Premium Payable:</td>
            <td><input type="text" name="txtpay" value="<%=pay%>" required=""></td>
            <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
        </tr>
         <tr>
            <td>Premium Caste:</td>
            <td>
         <select name="sel" required="">
             <option name="select">Select</option>
             <option name="General">General</option>
             <option name="Sc">SC</option>
             <option name="St">ST</option>
         </select></td>
        </tr>
        <tr>
            <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
             <td><input type="reset" name="btncancel" value="CANCEL"></td>
            
        </tr>
        </table>
        <table border="1">
                <tr>
                    <td>SL.NO</td>
                    <td>Premium Amount</td>
                    <td>Premium Payable</td>
                    <td>Premium Caste</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
                <%
                    String sel="select * from tbl_premium";
                    ResultSet rset=con.selectCommand(sel);
                    while(rset.next())
                    {
                        String pid=rset.getString("premium_id");
                        String pamount=rset.getString("premium_amt");
                        String ppay=rset.getString("premium_payable");
                        String pcaste=rset.getString("premium_caste");
                        %>
                        
                        
              <tr>
                  <td><%=pid%></td>
                  <td><%=pamount%></td>
                  <td><%=ppay%></td>
                  <td><%=pcaste%></td>
                  
                  <td><a href="PREMIUM.jsp?editid=<%=pid%>">Edit</a></td>
                  <td><a href="PREMIUM.jsp?deleteid=<%=pid%>">Delete</a></td>
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

