<%-- 
    Document   : ITEM
    Created on : Aug 12, 2018, 2:17:26 PM
    Author     : PSST
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
  String iname="";
  String cname="";
  String eid="";
  String catid="";
  String id="";
  if(request.getParameter("btnsubmit")!=null)
  {
      String itname=request.getParameter("txtitemname");
      catid=request.getParameter("selcat");
      if(request.getParameter("hideeditid")!="")
      {
          String h=request.getParameter("hideeditid");
          String edit="update tbl_item set item_name='"+itname+"', category_id='"+catid+"' where item_id='"+h+"'";
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
      String ins="insert into tbl_item(item_name,category_id) values('"+itname+"','"+catid+"')";
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
      String sel="Select * from tbl_item where item_id='"+eid+"'";
      ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
          catid=res.getString("category_id");
          iname=res.getString("item_name");
          id=res.getString("item_id");
          
          
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_item where item_id='"+did+"'";
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
  <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Item form</title>
    </head>
    <body>
        <center>
             <h1>ITEM</h1>
            <form>
                <table>
                    <tr>
                        <td>Item Name:</td>
                        <td><input type="text" name="txtitemname" value="<%=iname%>" required=""></td>
                        <td><input type="hidden" name="hideeditid" value="<%=eid%>"></td>
                    </tr>
                    <tr>
                        <td>Category Name:</td>
                                <td>
                            <select name="selcat" required="">
                                <option>--select--</option>
                            <%
                            
                            String sl="select * from tbl_category";
                            ResultSet res=con.selectCommand(sl);
                            while(res.next())
                            {
                                cname=res.getString("category_name");
                            
                            %>
                            <option value="<%=res.getString("category_id")%>"><%=cname%></option> 
                            
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
                                    <td>Item Name</td>
                                    <td>Category Name</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
                                <%
                            String sel="select * from tbl_item i inner join tbl_category c on c.category_id=i.category_id";
                            ResultSet rest=con.selectCommand(sel);
                            int i=1;
                            while(rest.next())
                            {
                                String itemid=rest.getString("item_id");
                                String itname=rest.getString("item_name");
                                String ctname=rest.getString("category_name");
                            
                             %> 
                             <tr>
                                 <td><%=i%></td>
                                 <td><%=itname%></td>
                                 <td><%=ctname%></td>
                                 <td><a href="ITEM.jsp?editid=<%=itemid%>">Edit</a></td>
                                 <td><a href="ITEM.jsp?deleteid=<%=itemid%>">Delete</a></td>
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
