<%-- 
    Document   : ITEM PURCHASE
    Created on : 30 Aug, 2018, 10:18:16 AM
    Author     : DEEPA
--%>
<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String ipname="",eid="",id="",itempid="",itempdate="",itempqty="",itqty="",itdate="";
    
    if(request.getParameter("btnsubmit")!=null)
    {
        
        String ipid=request.getParameter("selitem");
        System.out.println(ipid);
        itdate=request.getParameter("txtipdate");
        itqty=request.getParameter("txtqty");
         if(request.getParameter("hid")!="")
           {
          String h=request.getParameter("hid");
          String edit="update tbl_itempurchase set itemp_date='"+itdate+"',itemp_qty='"+itqty+"',item_id='"+ipid+"' where itemp_id='"+h+"'";
         
          System.out.println(edit);
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
      String ins="insert into tbl_itempurchase(item_id,itemp_date,itemp_qty) values('"+ipid+"','"+itdate+"','"+itqty+"')";
      
      System.out.println(ins);
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
     String sel="select * from tbl_itempurchase ip inner join tbl_item i on ip.item_id=i.item_id where itemp_id='"+eid+"'";
     ResultSet res=con.selectCommand(sel);
      while(res.next())
      {
          itempid=res.getString("itemp_id");
          itempdate=res.getString("itemp_date");
          itempqty=res.getString("itemp_qty");
          id=res.getString("item_id");
          
          
      }
  }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_itempurchase where itemp_id='"+did+"'";
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <center> 
            <h1>ITEM PURCHASE</h1>
        <form>
            <table>
                <tr>
                        <td>Item Name:</td>
                                <td>
                            <select name="selitem" required="">
                                <option>--select--</option>
                            <%
                            String itmid="";
                            String sl="select * from tbl_item";
                            ResultSet res=con.selectCommand(sl);
                            
                           while(res.next())
                            {
                                itmid=res.getString("item_id");
                                ipname=res.getString("item_name");
                            
                            %>
                             <option <%if (itmid.equals(id)){%> selected=""<%}%> value="<%=itmid%>"><%=ipname%></option>
                            
                             <%
                            }
                            %>

                            </select>
                       
                    </tr>
                                       
                      
                <tr>
                    <td>Purchase Date </td>
                    <td><input type="date" name="txtipdate" value="<%=itdate%>" required=""></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
               </tr>
                  <tr>
                    <td>Quantity </td>
                    <td><input type="text" name="txtqty" value="<%=itqty%>" required=""></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
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
                                    <td>Item Date</td>
                                    <td>Item Quantity</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
         <%
                            String sel="select * from tbl_itempurchase ip inner join tbl_item i on ip.item_id=i.item_id";
                            ResultSet rest=con.selectCommand(sel);
                            int i=1;
                            while(rest.next())
                            {
                                String itempurid=rest.getString("itemp_id");
                                String iname=rest.getString("item_name");
                                String itemdate=rest.getString("itemp_date");
                                String qty=rest.getString("itemp_qty");
                            
                             %> 
                             <tr>
                                 <td><%=i%></td>
                                 <td><%=iname%></td>
                                 <td><%=itemdate%></td>
                                 <td><%=qty%></td>
                                 <td><a href="ITEM PURCHASE.jsp?editid=<%=itempurid%>">Edit</a></td>
                                 <td><a href="ITEM PURCHASE.jsp?deleteid=<%=itempurid%>">Delete</a></td>
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
