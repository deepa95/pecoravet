<%-- 
    Document   : VACCINATION
    Created on : 19 Oct, 2018, 11:14:31 AM
    Author     : DEEPA
--%>

<%@include file="header.jsp" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%
    String itemid = "";
    String catdetailid = "",Ecatdetailid="";
    String eid = "", iname = "", tagno = "",itid="";
    String catid = "";
    String id = "", vdate = "", vaccineid = "";
  
    
    if (request.getParameter("btnsubmit") != null) {

        catdetailid = request.getParameter("selcattle");
        vdate = request.getParameter("txtipdate");
        itemid = request.getParameter("selitem");
      
        if (request.getParameter("hid") != "") {
            String h = request.getParameter("hid");
            String edit = "update tbl_vaccination set cattleD_id='" + catdetailid + "',vaccination_date='" + vdate + "',item_id='" + itemid + "' where vaccination_id='" + h + "'";
            System.out.println(edit);
            if (con.executeCommand(edit)) {
                out.println("Update Successfull");
            } else {
                out.println("Unsuccessful" + edit);
            }
        } else {
            String ins = "insert into tbl_vaccination(cattleD_id,vaccination_date,item_id) values('" + catdetailid + "','" + vdate + "','" + itemid + "')";
            System.out.println(ins);
            if (con.executeCommand(ins)) {
                out.println("Inserted Successfully");
            } else {
                out.println("Unsuccessful insertion" + ins);
            }
        }
    }

    if (request.getParameter("editid") != null) {
        eid = request.getParameter("editid");
        String sel = "Select * from tbl_vaccination where vaccination_id='" + eid + "'";
        ResultSet res = con.selectCommand(sel);
        while (res.next()) {
            vaccineid = res.getString("vaccination_id");
            Ecatdetailid = res.getString("cattleD_id");
            vdate = res.getString("vaccination_date");
            itemid = res.getString("item_id");

        }
    }
    if (request.getParameter("deleteid") != null) {
        String did = request.getParameter("deleteid");
        String del = "delete from tbl_vaccination where vaccination_id='" + did + "'";
        if (con.executeCommand(del)) {
            out.println("Delete Succesfull");
        } else {
            out.println("Unsuccessful");
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vaccination</title>
    </head>
    <body>
    <center>
        <h1>VACCINATION</h1>
        <form>
            <table>
                <tr>
                    <td>Cattle No:</td>
                    <td>
                        <select name="selcattle" required="">
                            <option>--select--</option>
                            <%                               
                                String s = "select * from tbl_cattledetails";
                                ResultSet rest = con.selectCommand(s);
                                while (rest.next()) {
                                    catdetailid = rest.getString("cattleD_id");
                                    tagno = rest.getString("cattleD_eartagno");


                            %>
                            <option <% if(catdetailid.equals(Ecatdetailid)){%> selected="" <%}%> value="<%=catdetailid%>"><%=tagno%></option> 

                            <%
                                
                                }
                            %>

                        </select>

                </tr>
                <tr>
                    <td>Vaccination Date </td>
                    <td><input type="date" name="txtipdate" value="<%=vdate%>" required=""></td>
                    <td><input type="hidden" name="hid" value="<%=vaccineid%>"></td>

                </tr>
                <tr>
                    <td>Item Name:</td>
                    <td>
                        <select name="selitem" required="">
                            <option>--select--</option>
                            <%

                                String sl = "select * from tbl_item";
                                ResultSet res = con.selectCommand(sl);
                                while (res.next()) {
                                    iname = res.getString("item_name");
                                    itid=res.getString("item_id");

                            %>
                            <option <%
                            if(itid.equals(itemid)){
                          %> selected=""<%}%> value="<%=itid%>"><%=iname%></option> 

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
                    <td>Ear Tagno</td>
                    <td>Vaccination Date</td>
                    <td>Item Name</td>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
                <%
                    String sel = "select * from tbl_vaccination v inner join tbl_cattledetails cd inner join tbl_item i on v.cattleD_id=cd.cattleD_id and v.item_id=i.item_id";
                    ResultSet rset = con.selectCommand(sel);
                    int i = 1;
                    while (rset.next()) {
                        String vid = rset.getString("vaccination_id");
                        String cattledid = rset.getString("cattleD_eartagno");
                        String vaccindate = rset.getString("vaccination_date");
                        String itname = rset.getString("item_name");

                %> 
                <tr>
                    <td><%=i%></td>
                    <td><%=cattledid%></td>
                    <td><%=vaccindate%></td>
                    <td><%=itname%></td>
                    <td><a href="VACCINATION.jsp?editid=<%=vid%>">Edit</a></td>
                    <td><a href="VACCINATION.jsp?deleteid=<%=vid%>">Delete</a></td>
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
