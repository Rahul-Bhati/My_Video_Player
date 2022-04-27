<%-- 
    Document   : dashboard
    Created on : 26 Feb, 2022, 9:23:17 AM
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
        <script>
           
        </script>
   </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="dashboard.jsp">VR tube</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fa fa-bars"></i></button>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="index.jsp">
                                <div class="sb-nav-link-icon"><i class="fa fa-home"></i></div>
                                Home
                            </a>
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
                                        else if(request.getParameter("ccode_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Channel Edit Error !</h6>");
                                        }
                                        else if(request.getParameter("delete_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Channel Deleted Successfully !</h6>");
                                        }
                                        else if(request.getParameter("delete_again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Try Again !</h6>");
                                        }
                                        else if(request.getParameter("cedit_success")!=null){
                                            out.println("<h6 class='alert alert-success'>Channel Updated Successfully !</h6>");
                                        }
                                        else if(request.getParameter("isuccess")!=null){
                                            out.println("<h6 class='alert alert-success'>Image Updated Successfully !</h6>");
                                        }
                                        else if(request.getParameter("vsuccess")!=null){
                                            out.println("<h6 class='alert alert-success'>Video Uploaded Successfully !</h6>");
                                        }
                                    %>
					<span id="store" prel="" pid="" prec="0"></span>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol><br><br>
                        <div class="col-sm-12">
                            <div class="card text-white bg-primary mb-3">
				<div class="card-header">Add Channel</div>
                                    <div class="card-body">
					<div id="cat">	
					<form  method="post" action="insert_channel.jsp">
                                            <label class="form-label">Channel Name</label>
                                            <input class="form-control"  type="text" name="channel_name" placeholder="channel name" required /><br>
                                            <label class="form-label">Category</label>
                                            <select class="form-control" name="category">
                                                <option value="Music">Music</option>
                                                <option value="Entertainment">Entertainment</option>                                            
                                                <option value="Film">Film</option>
                                                <option value="News">News</option>
                                                <option value="Kids">Kids</option>
                                                <option value="Comedy">Comedy</option>
                                                <option value="Education">Education</option>
                                                <option value="HowTo & Style">HowTo & Style</option>
                                                <option value="Animation">Animation</option>
                                                <option value="Politics">Politics</option>
                                                <option value="Motivation">Motivation</option>                                                
                                                <option value="Yoga">Yoga</option>
                                                <option value="Exercise">Exercise</option>                                           
                                                <option value="Anime">Anime</option>
                                                <option value="Bhajan">Bhajan</option>                                           
                                                <option value="Movies">Movies</option>
                                                <option value="Short Clips & Videos">Short Clips & Videos</option>
                                            </select><br>
                                            <label class="form-label" >Detail</label>
                                            <textarea rows="3" class="form-control"  name="detail" placeholder="detail" style="resize:none"></textarea><br>
                                            <a><input type="submit" value="Create" class="btn btn-warning"></a><br><br>
                                        </form>
                                        </div>
                                   </div>
			    </div>
                        </div>
        	   </div>
                   <div class="row" >
                        <div class="col-sm-12">
                            <div class="container-fluid px-4">
                                <h2 style="font-family:serif"><b>All Channels</b></h2>
                                <%
                                    try{
                                       Class.forName("com.mysql.jdbc.Driver");
                                       Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                                       Statement st = cn.createStatement();
                                       ResultSet rs = st.executeQuery("select * from channel where email='"+email+"' AND status='0'");
                                       while(rs.next()){
                                   %>
                                           <table class="table table-borderless">
                                               <tr>
                                                   <td><img src="channel_Image/<%=rs.getString("code")%>.jpg" alt="channel_image" class="img-fluid" style="width:150px;height:100px;"/><br><br>
                                                        <a href="edit_cimage.jsp?ccode=<%=rs.getString("code")%>"><button class="btn btn-warning">Edit Image</button></a>
                                                    </td>
                                                   <td style="width:300px" ><%=rs.getString("channel_name")%></td>
                                                   <td><a href="view_channel.jsp?ccode=<%=rs.getString("code")%>"><button class="btn btn-info">View <i class="fa fa-eye" aria-hidden="true"></i></button></a></td>
                                                   <td><a href="video.jsp?ccode=<%=rs.getString("code")%>"><button class="btn btn-primary">Add Video</button></a></td>
                                                   <td><a href="edit_channel.jsp?ccode=<%=rs.getString("code")%>"><i class="fa fa-edit" style="color:blue;cursor:pointer" ></i></a></td>
                                                   <td><a href="delete_channel.jsp?ccode=<%=rs.getString("code")%>"><i class="fa fa-trash" style="color:red;cursor:pointer"></i></a></td>
                                               </tr>
                                           </table>
                                       
                                       &nbsp;
                                       &nbsp;
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
        }
        catch(NullPointerException er){
            response.sendRedirect("index.jsp");
        }  
%>

