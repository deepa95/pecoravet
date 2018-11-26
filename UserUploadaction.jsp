<%-- 
    Document   : uploadaction.jsp
    Created on : 8 Sep, 2016, 10:29:12 AM
    Author     : ANOOP
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="org.apache.commons.fileupload.servlet.*" %>
<%@page import="org.apache.commons.fileupload.disk.*" %>
<jsp:useBean class="pkg.ConnectionClass" id="con"></jsp:useBean>
<%--<jsp:useBean class="Email.mail" id="obj1"></jsp:useBean>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            String c="";
            String field_name="";
        FileItem f_item=null;
String file_name="";
int idd1=6;
int id=7;
File savedFile=null;
String fn="",pf="";

String field[] = new String[20];
String value[]=new String[20];

//checking if request cotains multipart data
boolean isMultipart=ServletFileUpload.isMultipartContent(request);

if(isMultipart)
{
    

    FileItemFactory factory=new DiskFileItemFactory();
    ServletFileUpload upload=new ServletFileUpload(factory);

    //declaring a list of form fields
    List items_list=null;

    //assigning fields to list 'items_list'
    try
    {
    items_list=upload.parseRequest(request);
    }
    catch(FileUploadException ex)
    {
        out.println(ex);
    }

          //declaring iterator
   Iterator itr=items_list.iterator();
    int k=0;
    //iterating through the list 'items_list'
    while(itr.hasNext())
    {
       
        //typecasting next element in items_list as fileitem
        f_item=(FileItem)itr.next();

        //checking if 'f_item' contains a formfield(common controls like textbox,dropdown,radio buttonetc)
       if(f_item.isFormField())
        {
          
            //getting fieldname and value
            field[k]=f_item.getFieldName();
            value[k]=f_item.getString();
            
            if(field[k].equals("qlfctn"))
            {
                c=c+value[k]+",";
                id++;
                idd1++;
            }
                System.out.println("chk"+c);
                k++;
        }
       else
       {
            //f_item=(FileItem)itr.next();
            
           file_name=f_item.getName();
           field_name=f_item.getFieldName();
           if(file_name!="")
           {
           if(field_name.equals("photo"))
           {
           String ext=file_name.substring(file_name.lastIndexOf("."));
            //setting path to store image
            File proj_path=new File(config.getServletContext().getRealPath("/"));
            String file_path=proj_path.getParentFile().getParentFile().getPath()+"\\web\\User\\Photo\\";
            Random r=new Random();
             int r_num=r.nextInt(1111)+999;
             System.out.println("ifff : "+fn);
            fn="Logo_"+r_num+ext;
            //creating a file object
            savedFile=new File(file_path+fn);
            try
            {
                //writing the file object
                f_item.write(savedFile);               
                
            }
            catch(Exception ex)
            {
                out.println(ex);
            }
            }
           
           
           else  if(field_name.equals("txtproof"))
           {
           String ext1=file_name.substring(file_name.lastIndexOf("."));
            //setting path to store image
            File proj_path1=new File(config.getServletContext().getRealPath("/"));
            String file_path1=proj_path1.getParentFile().getParentFile().getPath()+"\\web\\LIFESTOCK INSPECTOR\\Proof\\";
            Random r=new Random();
             int r_num=r.nextInt(1111)+999;
             System.out.println("ifff : "+pf);
            pf="Proof_"+r_num+ext1;
            //creating a file object
            savedFile=new File(file_path1+pf);
            try
            {
                //writing the file object
                f_item.write(savedFile);               
                
            }
            catch(Exception ex)
            {
                out.println(ex);
            }
            }
           
           
           
          
           
       }
           
           }
    }
}
    
    //uname="DIPO"+str2.substring(0, 2)+"KSRTC";
 

//    out.print(password);
    //Strinh str1="insert into tbl_user ()";
  String str1="insert into tbl_user (user_name,user_addr,gender,user_dob,user_contact,user_email,user_proof,user_username,user_password)"
           + "values('"+value[0]+"','"+value[1]+"','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+value[5]+"','"+pf+"','"+value[6]+"','"+value[7]+"')";
          System.out.println(str1);
   if(con.executeCommand(str1))
        {
            out.println("Inserted Successfull");
        }
        else
        {
            out.println("Insertion Failed");
        }
      %> 
       <script type="text/javascript">
            alert("Inserted Successfully..");
          setTimeout(function(){window.location.href='USERREG.jsp'},100);
        </script>
   
    </body>
</html>
