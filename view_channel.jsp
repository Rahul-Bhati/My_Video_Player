<%-- 
    Document   : view_channel
    Created on : 23 Apr, 2022, 8:26:24 AM
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
            .cover{
                           min-height: 100%;
                            max-height: 100%;
                            position: relative;
                            display: block;
                            overflow: hidden;
                            min-height: 250px;
                       }
                       .cover img {
                            width: 100%;
                            height: 100%;
                            position: absolute;
                            top: 50%;
                            right: 0;
                            bottom: 0;
                            left: 50%;
                            display: block;
                            transform: translate(-50%,-50%);
                            object-fit: cover;
                          }

                          .cover:before {
                            position: absolute;
                            content: '';
                            z-index: 1;
                            bottom: 0;
                            left: 0;
                            width: 100%;
                            height: 60%;
                            opacity: 0.5;
                          }
                          .channel-image{
                              min-height: 100%;
                            max-height: 100%;
                            position: relative;
                            display: block;
                            min-height: 250px;
                          }
                          .channel-image img{
                              position: relative;
                              width: 100px;
                              height: 100px;
                              border-radius: 50%;
                              margin-top: -150px;                              
                              margin-left: 50px;

                          }
                          .channel-image h3{
                              position: relative;
                              margin-top: -120px;                              
                              margin-left: 180px;
                              font-size: 30px;
                              color: white;
                          }
                          .channel-image p{
                              position: relative;
                              margin-top: -10px;                              
                              margin-left: 180px;
                              font-size: 18px;
                              color: white;
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
                    <div class="row">
                       <div class="col-sm-12 cover">
                            <img class="img-fluid" src="2.jpg" width="100%">
                        </div>
                        <div class="channel-image">
                            <img src="channel_Image/<%=channel_code%>.jpg" class="img fluid">
                            <h3><b><%=rs.getString("channel_name")%></b></h3>
                           <%
                                int sub_count = 0;
                                Statement st1 = cn.createStatement();
                                ResultSet rs1 = st1.executeQuery("select count(*) from subscribe where channel_code='"+channel_code+"'");
                                if(rs1.next()){
                                    sub_count = Integer.parseInt(rs1.getString("count(*)"));
                                }
                            %>
                           <p><%=sub_count%> Subscribers</p>
                        </div>
                    </div>
                    <div class="row" style='margin-top:-170px;'>
                        <div class="col-sm-12">
                            <div class="container-fluid px-4">
                                <h2 style="font-family:serif"><b>All Videos</b></h2>
                                <%
                                       int flag=0;
                                       ResultSet rs2 = st.executeQuery("select * from video where channel_code='"+channel_code+"' AND status='0'");
                                       while(rs2.next()){
                                           flag = 1;
                                   %>
                                           <table class="table table-borderless">
                                               <tr>
                                                   <td><img src="channel_Video/<%=rs2.getString("code")%>.jpg" alt="video_image" class="img-fluid" style="width:100px;height:100px;"/><br><br>
                                                        <a href="change_vimage.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><button class="btn btn-warning">Edit Image</button></a>
                                                    </td>
                                                   <td style="width:400px" ><%=rs2.getString("video_name")%></td>
                                                   <td><a href="change_video.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><button class="btn btn-primary">Change Video</button></a></td>
                                                   <td><a href="edit_video.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-edit" style="color:blue;cursor:pointer" ></i></a></td>
                                                   <td><a href="delete_video.jsp?vcode=<%=rs2.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-trash" style="color:red;cursor:pointer"></i></a></td>
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
                                       ResultSet rs3 = st.executeQuery("select * from video where channel_code='"+channel_code+"' AND status='1'");
                                       while(rs3.next()){
                                           flag=2;
                                   %>
                                           <table class="table table-borderless">
                                               <tr>
                                                   <td><img src="channel_Video/<%=rs3.getString("code")%>.jpg" alt="video_image" class="img-fluid" style="width:100px;height:100px;"/><br><br></td>
                                                   <td style="width:400px" ><%=rs3.getString("video_name")%></td>
                                                   <td><a href="restore_video.jsp?vcode=<%=rs3.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-recycle" style="color:blue;cursor:pointer" > Restore</i></a></td>
                                                   <td><a href="p_delete_video.jsp?vcode=<%=rs3.getString("code")%>&ccode=<%=channel_code%>"><i class="fa fa-trash" style="color:red;cursor:pointer"> Delete</i></a></td>
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
