<%-- 
    Document   : PLACE
    Created on : Aug 12, 2018, 2:11:56 PM
    Author     : PSST
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String place="",eid="";
    if(request.getParameter("btnsubmit")!=null)
  {
      String pl=request.getParameter("txtplace");
     if(request.getParameter("hideeditid")!="")
     {
         String h=request.getParameter("hideeditid");
         String edit="update tbl_place set place_name='"+pl+"' where place_id='"+h+"'";
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
      String ins="insert into tbl_place(place_name) values('"+pl+"')";
      if(con.executeCommand(ins))
      {
          out.println("inserted Succesfull"+ins);
         
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
      String sel="select place_name from tbl_place where place_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
         place=res.getString("place_name");
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_place where place_id='"+did+"'";
      if(con.executeCommand(del))
      {
          out.println("Delete Sucessfull");
          
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
        <title>JSP Page</title>
    </head>
    <body>
        <center>
    <form>
       <table>
        <h1>PLACE</h1>
        <tr>
            <td>Place Name:</td>
            <td><input type="text" name="txtplace" value="<%=place%>"></td>
            <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
        </tr>
        <tr>
            <td><input type="submit" name="btnsubmit" value="SUBMIT"></td>
             <td><input type="reset" name="btncancel" value="CANCEL"></td>
            
        </tr>
        </table>
        <table border="1">
                <tr>
                    <td>SL.NO</td>
                    <td>Place Name</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
                <%
                    String sel="select * from tbl_place";
                    ResultSet rset=con.selectCommand(sel);
                    while(rset.next())
                    {
                        String pid=rset.getString("place_id");
                        String pname=rset.getString("place_name");
                        %>
                        
                        
              <tr>
                  <td><%=pid%></td>
                  <td><%=pname%></td>
                  <td><a href="PLACE.jsp?editid=<%=pid%>">Edit</a></td>
                  <td><a href="PLACE.jsp?deleteid=<%=pid%>">Delete</a></td>
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
