<%-- 
    Document   : edit_video
    Created on : 26 Feb, 2022, 2:33:32 PM
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
                if(request.getParameter("vcode")==null && request.getParameter("ccode")==null){
                    response.sendRedirect("dashboard.jsp?code_error=1");
                }
                else{
                    String vcode = request.getParameter("vcode");   
                    String channel_code = request.getParameter("ccode");

                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("select * from video where code='"+vcode+"'");
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
                                            out.println("<h6 class='alert alert-success'>Channel Updated Successfully !</h6>");
                                        }
                                        else if(request.getParameter("empty")!=null){
                                            out.println("<h6 class='alert alert-warning'>All Field Required !</h6>");
                                        }
                                        else if(request.getParameter("again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Try Again !</h6>");
                                        }
                                        else if(request.getParameter("code_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Code Error !</h6>");
                                        }
                       %>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol><br><br>
                        <div class="col-sm-12">
                            <div class="card text-white bg-primary mb-3">
				<div class="card-header">Edit Video</div>
                                    <div class="card-body">
					<div id="cat">	
                                            <form  method="post" action="update_video.jsp?vcode=<%=vcode%>&ccode=<%=channel_code%>">
                                            <label class="form-label">Video Name</label>
                                            <input class="form-control"  type="text" name="video_name" value="<%=rs.getString("video_name")%>" required /><br>
                                            <label class="form-label" >Detail</label>
                                            <textarea class="form-control"  name="detail" ><%=rs.getString("detail")%></textarea><br>
                                            <a><input type="submit" value="Edit" class="btn btn-warning"></a><br><br>
                                        </form>
                                        </div>
                                   </div>
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
