<%-- 
    Document   : video
    Created on : 26 Feb, 2022, 10:44:16 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
  try{
            String email = null;
            Cookie c[] = request.getCookies();
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("user")){
                    email = c[i].getValue();
                    break;
                }
            }
            if(email==null){
                response.sendRedirect("index.jsp");
            }
            else{
                if(request.getParameter("ccode")==null){
                    response.sendRedirect("dashboard.jsp?code_error=1");
                }
                else{
                    String channel_code = request.getParameter("ccode") ;
                    //out.println(channel_code);
                    try{
                                       Class.forName("com.mysql.jdbc.Driver");
                                       Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                                       Statement st = cn.createStatement();
                                       ResultSet rs = st.executeQuery("select * from channel where code='"+channel_code+"'");
                                       if(rs.next()){
                                 %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>VR Tube</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="asset/css/styles.css" rel="stylesheet" />
        <link href="asset/css/bootstrap.css" rel='stylesheet' type='text/css' />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link href="asset/css/fontawesome-all.css" rel="stylesheet">
        <script src="https://use.fontawesome.com/09901d9403.js"></script>
        <style>
            .channel_name{
                                margin-left: 15px;
				width: 100vh;
				height: 50px;
				border-bottom: 5px solid #000;
				line-height: 50px;
				overflow: hidden;
			}
			.channel_name h4{
				color: #fff;
				font-size: 30px;
				background: #000;
				padding: 2px 20px;
				text-transform: uppercase;
			}
        </style>
   </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="dashboard.jsp">VR Tube</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fa fa-bars"></i></button>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="dashboard.jsp">
                                <div class="sb-nav-link-icon"><i class="fa fa-th"></i></div>
                                Dashboard
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link" href="logout.jsp">
                                <div class="sb-nav-link-icon"><i class="fa fa-sign-out"></i></div>
                                Logout &nbsp;&nbsp; </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        <%=email%>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main id="record">
                    <%
                                        if(request.getParameter("success")!=null){
                                            out.println("<h6 class='alert alert-success'>Channel Created Successfully !</h6>");
                                        }
                                        else if(request.getParameter("empty")!=null){
                                            out.println("<h6 class='alert alert-warning'>All Field Required !</h6>");
                                        }
                                        else if(request.getParameter("again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Try Again !</h6>");
                                        }
                                        else if(request.getParameter("img_code_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Image Code Error !</h6>");
                                        }
                                        else if(request.getParameter("code_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Code Error !</h6>");
                                        }
                                        else if(request.getParameter("img_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Image not uploaded !</h6>");
                                        }
                                        else if(request.getParameter("delete_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Deleted Successfully !</h6>");
                                        }
                                        else if(request.getParameter("delete_again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Video delete error : Try Again !</h6>");
                                        }
                                        else if(request.getParameter("restore_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Restored Successfully !</h6>");
                                        }
                                        else if(request.getParameter("restore_again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Video Restore error : Try Again !</h6>");
                                        }
                                        else if(request.getParameter("remove_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Permanantely Deleted !</h6>");
                                        }
                                        else if(request.getParameter("remove_again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Video Remove error : Try Again !</h6>");
                                        }
                                        else if(request.getParameter("change_img_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Image Changed Successfully !</h6>");
                                        }
                                        else if(request.getParameter("change_vsuccess")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Changed Successfully !</h6>");
                                        }
                                    %>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol><br><br><br>
                        <div class="channel_name">
                            <h4><b>Channel name :- <%=rs.getString("channel_name")%></b></h4>
                        </div><br>
                        <div class="col-sm-12">
                            <div class="row">
                                 <div class="col-sm-6">
                                     <img src="channel_Image/<%=channel_code%>.jpg" alt="channel_image" class="img-fluid"/><br><br>
                                    <a href="edit_cimage.jsp?ccode=<%=channel_code%>"><button class="btn btn-warning">Edit Image</button></a>
                                
                                 </div>
                                <div class="col-sm-6">
                                    <div class="w3-card-4 text-white  mb-3">
                                        <div class="card-header bg-primary">Add Video</div>
                                            <div class="card-body">
                                                <div id="cat">	
                                                <form  method="post" action="insert_video.jsp?ccode=<%=channel_code%>">
                                                    <label class="form-label">Video Name</label>
                                                    <input class="form-control"  type="text" name="video_name" placeholder="video name" required /><br>
                                                    <label class="form-label" >Detail</label>
                                                    <textarea rows="3" class="form-control" style="resize:none"  name="detail" placeholder="detail"></textarea><br>
                                                    <a><input type="submit" value="add" class="btn btn-primary"></a><br><br>
                                                </form>
                                                </div>
                                           </div>
                                    </div>
                                </div>
                            </div>
                        </div>
        	   </div>
                <br><br>
                <div class="row" >
                        <div class="col-sm-12">
                            <div class="container-fluid px-4">
                                <h2 style="font-family:serif"><b>All Videos</b></h2>
                                <%
                                       int flag=0;
                                       ResultSet rs1 = st.executeQuery("select * from video where channel_code='"+channel_code+"' AND status='0'");
                                       while(rs1.next()){
                                           flag = 1;
                                   %>
                                           <table class="table table-borderless">
                                               <tr>
                                                   <td><img src="channel_Video/<%=rs1.getString("code")%>.jpg" alt="video_image" class="img-fluid" style="width:100px;height:100px;"/><br><br>
                                                        <a href="change_vimage.jsp?vcode=<%=rs1.getString("code")%>&ccode=<%=channel_code%>"><button class="btn btn-warning">Edit Image</button></a>
                                                    </td>
                                                   <td style="width:400px" ><%=rs1.getString("video_name")%></td>
                                                   <td><a href="change_video.jsp?vcode=<%=rs1.getString("code")%>&ccode=<%=channel_code%>"><button class="btn btn-primary">Change Video</button></a></td>
                                                   <td><a href="edit_video.jsp?vcode=<%=rs1.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-edit" style="color:blue;cursor:pointer" ></i></a></td>
                                                   <td><a href="delete_video.jsp?vcode=<%=rs1.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-trash" style="color:red;cursor:pointer"></i></a></td>
                                               </tr>
                                           </table>
                                       
                                       &nbsp;
                                       &nbsp;
                                   <%
                                       }
                                       if(flag==0){
                                           out.println("<marquee><h3>Record Not Found ! First Add Videos.</h3></marquee>");
                                       }
                               %>								
                            </div>
                       </div>
                   </div><br><br>
                   <div class="row" >
                        <div class="col-sm-12">
                            <div class="container-fluid px-4">
                                <h2 style="font-family:serif"><b>Restore or Delete Videos</b></h2>
                                <%
                                       ResultSet rs2 = st.executeQuery("select * from video where channel_code='"+channel_code+"' AND status='1'");
                                       while(rs2.next()){
                                           flag=2;
                                   %>
                                           <table class="table table-borderless">
                                               <tr>
                                                   <td><img src="channel_Video/<%=rs2.getString("code")%>.jpg" alt="video_image" class="img-fluid" style="width:100px;height:100px;"/><br><br></td>
                                                   <td style="width:400px" ><%=rs2.getString("video_name")%></td>
                                                   <td><a href="restore_video.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-recycle" style="color:blue;cursor:pointer" > Restore</i></a></td>
                                                   <td><a href="p_delete_video.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-trash" style="color:red;cursor:pointer"> Delete</i></a></td>
                                               </tr>
                                           </table>
                                       
                                       &nbsp;
                                       &nbsp;
                                   <%
                                       }
                                       if(flag==0){
                                           out.println("<marquee><h3>Record Not Found !</h3></marquee>");
                                       }
                               %>								
                            </div>
                       </div>
                   </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2021</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="asset/js/scripts.js"></script>
        <script src="asset/js/datatables-simple-demo.js"></script>
    </body>
</html>


<%
                                               }
                                        cn.close();
                                    }
                                    catch(ClassNotFoundException e){
                                         System.out.println("Driver : "+ e.getMessage());
                                    }
                                    catch(SQLException ec){
                                         System.out.println("SQL : "+ec.getMessage());
                                    }
                }       
                        
            }
        }
        catch(NullPointerException er){
            response.sendRedirect("index.jsp");
        }  
%>
