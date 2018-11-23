<%-- 
    Document   : CATEGORY
    Created on : Aug 12, 2018, 1:50:23 PM
    Author     : PSST
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String eid="";
    String catname="";
  if(request.getParameter("btnsubmit")!=null)
  {
      String cname=request.getParameter("txtcategory");
     if(request.getParameter("hideeditid")!="")
     {
         String h=request.getParameter("hideeditid");
         String edit="update tbl_category set category_name='"+cname+"' where category_id='"+h+"'";
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
      String ins="insert into tbl_category(category_name) values('"+cname+"')";
      if(con.executeCommand(ins))
      {
          System.out.println("inserted Succesfull"+ins);
         
      }
      else
      {
          System.out.println("Unsuccessful Insertion"+ins);
      }
     }
  }
  
  if(request.getParameter("editid")!=null)
  {
      eid=request.getParameter("editid");
      String sel="select category_name from tbl_category where category_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
         catname=res.getString("category_name");
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_category where category_id='"+did+"'";
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category</title>
    </head>
    <body>
        <center> 
            <h1>CATEGORY</h1>
        <form>
            <table>
                <tr>
                    <td>Category Name:</td>
                    <td><input type="text" name="txtcategory" value="<%=catname%>" required=""></td>
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
                    <td>Category Name</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
                <%
                    String sel="select * from tbl_category";
                    ResultSet rset=con.selectCommand(sel);
                    int i=1;
                    while(rset.next())
                    {
                        String catid=rset.getString("category_id");
                        String categoryname=rset.getString("category_name");
                        %>
                        
                        
              <tr>
                  <td><%=i%></td>
                  <td><%=categoryname%></td>
                  <td><a href="CATEGORY.jsp?editid=<%=catid%>">Edit</a></td>
                  <td><a href="CATEGORY.jsp?deleteid=<%=catid%>">Delete</a></td>
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

