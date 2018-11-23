<%-- 
    Document   : CATTLE CATEGORY
    Created on : Aug 12, 2018, 2:00:28 PM
    Author     : PSST
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String ccname="",eid="",cattlecatid="";
    if(request.getParameter("btnsubmit")!=null)
    {
        String catcname=request.getParameter("txtcattlecat");
        if(request.getParameter("hid")!="")
        {
            String h=request.getParameter("hid");
         String edit="update tbl_cattle_category set cattlecat_name='"+catcname+"' where cattlecat_id='"+h+"'";
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
        String ins="insert into tbl_cattle_category(cattlecat_name) values('"+catcname+"')";
      if(con.executeCommand(ins))
      {
          out.println("Inserted Succesfull");
         
      }
      else
      {
          out.println("Unsuccessful Insertion");
      }
     }
    }if(request.getParameter("editid")!=null)
  {
      eid=request.getParameter("editid");
      String sel="select cattlecat_name from tbl_cattle_category where cattlecat_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
         ccname=res.getString("cattlecat_name");
      }
  }
    if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_cattle_category where cattlecat_id='"+did+"'";
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
        <title>cattle category form</title>
    </head>
    <body>
        <center>
    <form>
       <table>
        <h1>CATTLE CATEGORY</h1>
        <tr>
            <td>Cattle Category Name:</td>
            <td><input type="text" name="txtcattlecat" value="<%=ccname%>" required=""></td>
            <td><input type="hidden" name="hid" value="<%=eid%>"></td>
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
                    String sel="select * from tbl_cattle_category";
                    ResultSet rset=con.selectCommand(sel);
                    int i=1;
                    while(rset.next())
                    {
                        String ccatid=rset.getString("cattlecat_id");
                        String categoryname=rset.getString("cattlecat_name");
                        %>
                        
                        
              <tr>
                  <td><%=i%></td>
                  <td><%=categoryname%></td>
                  <td><a href="CATTLE CATEGORY.jsp?editid=<%=ccatid%>">Edit</a></td>
                  <td><a href="CATTLE CATEGORY.jsp?deleteid=<%=ccatid%>">Delete</a></td>
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
