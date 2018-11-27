<%-- 
    Document   : STOCK
    Created on : Aug 12, 2018, 2:44:41 PM
    Author     : PSST
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String itname="", eid="",itid="",stockid="";
    String qty="";
    String itemid=request.getParameter("selItem");
   
    
    if(request.getParameter("btnsubmit")!=null)
    {
        qty=request.getParameter("txtqty");
        if(request.getParameter("hid")!="")
        {
          String hid=request.getParameter("hid");
          System.out.println("hidden"+hid);
          String up="update tbl_stock set qty='"+qty+"',item_id='"+itemid+"' where stock_id='"+hid+"'";
          if(con.executeCommand(up))
          {
              out.println("Updated Successfully");
          }
          else
          {
              out.println("Updation failed");
          }
        }
        else
        {
        String ins="insert into tbl_stock (qty,item_id) values('"+qty+"','"+itemid+"')";
        if(con.executeCommand(ins))
        {
            out.println("Inserted Successful");
        }
        else
        {
            out.println("Unsuccessful Insertion");
        }
        
        }
    }
    String itemname="";
    if(request.getParameter("editid")!=null)
    {
        eid=request.getParameter("editid");
        String sel="select * from tbl_stock s inner join tbl_item i on s.item_id=i.item_id where stock_id='"+eid+"'";
        ResultSet rset=con.selectCommand(sel);
        while(rset.next())
        {
            itid=rset.getString("item_id");
            itemname=rset.getString("item_name");
            qty=rset.getString("qty");
            System.out.println(qty);
            stockid=rset.getString("stock_id");
            
        }
    }
    if(request.getParameter("deleteid")!=null)
    {
        String did=request.getParameter("deleteid");
        String del="delete from tbl_stock where stock_id='"+did+"'";
        if(con.executeCommand(del))
        {
            out.println("Delete Succeesful");
        }
        else
        {
            out.println("Deletion Failed");
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
             <h1>STOCK</h1>
            <form>
                <table>
                    
                    <tr>
                        <td>Item Name:</td>
                                <td>
                            <select name="selItem" required="">
                                
                                <%
                           String itmid="";
                            
                            String sl="select * from tbl_item";
                            ResultSet res=con.selectCommand(sl);
                            while(res.next())
                            {
                             itmid=res.getString("item_id");
                              itname=res.getString("item_name");
                              
                              %>
                             <option <%if (itmid.equals(itid)){%> selected=""<%}%> value="<%=itid%>"><%=itname%></option> 
                             <%
                             }
                             %>
    
                            
                            </select>
                       
                    </tr>
                    <tr>
                        <td>Quantity:</td>
                        <td><input type="text" name="txtqty" value="<%=qty%>" required=""></td>
                        <td><input type="hidden" name="hid" value="<%=stockid%>"></td>
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
                                    <td>Quantity</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                    
                                    
                                </tr>
                                <%
                            int i=1;
                                String sel="select * from tbl_stock s inner join tbl_item i on s.item_id=i.item_id";
                                ResultSet rest=con.selectCommand(sel);
                                while(rest.next())
                                {
                                     qty=rest.getString("qty");
                                     itid=rest.getString("item_id");
                                     stockid=rest.getString("stock_id");
                                
                                %>
                                
                                <tr>
                                 <td><%=i%></td>
                                 <td><%=rest.getString("item_name")%></td>
                                 <td><%=qty%></td>
                                 <td><a href="STOCK.jsp?editid=<%=stockid%>">Edit</a></td>
                                 <td><a href="STOCK.jsp?deleteid=<%=stockid%>">Delete</a></td>
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
