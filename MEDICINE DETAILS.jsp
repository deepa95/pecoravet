<%-- 
    Document   : MEDICINE DETAILS
    Created on : 19 Oct, 2018, 11:15:15 AM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String itid="",itname="",qty="",eid="",iname="",price="",mhid="",id=""; 
    
    if(request.getParameter("btnsubmit")!=null)
    {
        mhid=request.getParameter("selhid");
        itid=request.getParameter("selitem");
        qty=request.getParameter("txtqty");
        price=request.getParameter("txtprice");
        
         if(request.getParameter("hid")!="")
           {
          String h=request.getParameter("hid");
          String edit="update tbl_medicinedetail set medicineH_id='"+mhid+"',item_id='"+itid+"',medicineD_qty='"+qty+"',unit_price='"+price+"' where medicineD_id='"+h+"'";
         
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
      String ins="insert into tbl_medicinedetail(medicineH_id,item_id,medicineD_qty,unit_price) values('"+mhid+"','"+itid+"','"+qty+"','"+price+"')";
      
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
      
  if (request.getParameter("editid") != null) {
        eid = request.getParameter("editid");
        String sel = "Select * from tbl_medicinedetail where medicineD_id='" + eid + "'";
        ResultSet res = con.selectCommand(sel);
        while (res.next()) {
            id = res.getString("medicineD_id");
            mhid = res.getString("medicineH_id");
            itid = res.getString("item_id");
            qty = res.getString("medicineD_qty");
            price = res.getString("unit_price");
        }
    }
  if(request.getParameter("deleteid")!=null)
  {
      String did=request.getParameter("deleteid");
      String del="delete from tbl_medicinedetail where medicineD_id='"+did+"'";
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
        <title>Medicine Details</title>
    </head>
    <body>
        <center>
             <h1>MEDICINE DETAILS</h1>
            <form>
                <table>
                    <tr>
                        <td>Bill No:</td>
                                <td>
                            <select name="selhid">
                                <option>--select--</option>
                            <%
                            
                            String s1="select * from tbl_medicinehead";
                            ResultSet res=con.selectCommand(s1);
                            while(res.next())
                            {
                                mhid=res.getString("medicineH_id");
                                
                                
                            
                            %>
                            <option value="<%=res.getString("medicineH_id")%>"><%=mhid%></option> 
                            
                             <%
                            }
                            %>

                            </select>
                       
                    </tr>
                    <tr>
                        <td>Item Name:</td>
                                <td>
                            <select name="selitem">
                                <option>--select--</option>
                            <%
                            
                            String s="select * from tbl_item";
                            ResultSet rest=con.selectCommand(s);
                            while(rest.next())
                            {
                                 String itemid=rest.getString("item_id");
                                itname=rest.getString("item_name");
                                
                            
                            %>
                            <option<%if (itemid.equals(itid)){%> selected=""<%}%> value="<%=itemid%>"><%=itname%></option> 
                            
                             <%
                            }
                            %>

                            </select>
                       
                    </tr>
                    <tr>
                    <td>Quantity </td>
                    <td><input type="text" name="txtqty" value="<%=qty%>" ></td>
                    <td><input type="hidden" name="hid" value="<%=eid%>"></td>
                   
               </tr>
                <tr>
                    <td>Unit Price </td>
                    <td><input type="text" name="txtprice" value="<%=price%>" ></td>
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
                                    <td>Bill No</td>
                                    <td> Item Name</td>
                                    <td>Quantity</td>
                                    <td>Unit Price</td>
                                    <td>Edit</td>
                                    <td>Delete</td>
                                </tr>
                                <%
                            String sel="select * from tbl_medicinedetail md inner join tbl_medicinehead mh inner join tbl_item i on md.medicineH_id=mh.medicineH_id and md.item_id=i.item_id";
                            ResultSet rset=con.selectCommand(sel);
                            int i=1;
                            while(rset.next())
                            {
                                String mdid=rset.getString("medicineD_id");
                                String itemname=rset.getString("item_name");
                                String quantity=rset.getString("medicineD_qty");
                                String unitprice=rset.getString("unit_price");
                            
                             %> 
                             <tr>
                                 <td><%=i%></td>
                                 <td><%=mdid%></td>
                                 <td><%=itemname%></td>
                                 <td><%=quantity%></td>
                                  <td><%=unitprice%></td>
                                 <td><a href="MEDICINE DETAILS.jsp?editid=<%=mdid%>">Edit</a></td>
                                 <td><a href="MEDICINE DETAILS.jsp?deleteid=<%=mdid%>">Delete</a></td>
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

