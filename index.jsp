<%-- 
    Document   : index
    Created on : 22 Feb, 2022, 2:44:08 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
    try{
      int flag = 0;
      String email = null;
      Cookie c[] = request.getCookies();
      for(int i=0;i<c.length;i++){
        if(c[i].getName().equals("user")){
            email = c[i].getValue();
            break;
        }
      }
      if(email!=null){
           flag = 1;
      }
      else{
           flag = 0;
      }   
      try{
         Class.forName("com.mysql.jdbc.Driver");
         Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
         %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
      <title>VR Tube</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel='stylesheet' href='https://unpkg.com/aos@2.3.0/dist/aos.css'>
    <link href="asset/css/fontawesome-all.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/09901d9403.js"></script>
    <style>
			/* Google Fonts Import Link */
			@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
			*{
			  margin: 0;
			  padding: 0;
			  box-sizing: border-box;
			  font-family: 'Poppins', sans-serif;
			}
			.sidebar{
			  position: fixed;
			  top: 0;
			  left: 0;
			  height: 100%;
			  width: 230px;
			  background: #11101d;
			  z-index: 100;
			  transition: all 0.5s ease;
			}
			.sidebar.close{
			  width: 78px;
			}
			.sidebar .logo-details{
			  height: 60px;
			  width: 100%;
			  display: flex;
			  align-items: center;
			}
			.sidebar .logo-details i{
			  font-size: 30px;
			  color: #fff;
			  height: 50px;
			  min-width: 78px;
			  text-align: center;
			  line-height: 50px;
			}
			.sidebar .logo-details .logo_name{
			  font-size: 22px;
			  color: #fff;
			  font-weight: 600;
			  transition: 0.3s ease;
			  transition-delay: 0.1s;
			}
			.sidebar.close .logo-details .logo_name{
			  transition-delay: 0s;
			  opacity: 0;
			  pointer-events: none;
			}
			.sidebar .nav-links{
			  height: 100%;
			  padding: 30px 0 150px 0;
			  overflow: auto;
			}
			.sidebar.close .nav-links{
			  overflow: visible;
			}
			.sidebar .nav-links::-webkit-scrollbar{
			  display: none;
			}
			.sidebar .nav-links li{
			  position: relative;
			  list-style: none;
			  transition: all 0.4s ease;
			}
			.sidebar .nav-links li:hover{
			  background: #1d1b31;
			}
			.sidebar .nav-links li .iocn-link{
			  display: flex;
			  align-items: center;
			  justify-content: space-between;
			}
			.sidebar.close .nav-links li .iocn-link{
			  display: block
			}
			.sidebar .nav-links li i{
			  height: 50px;
			  min-width: 78px;
			  text-align: center;
			  line-height: 50px;
			  color: #fff;
			  font-size: 20px;
			  cursor: pointer;
			  transition: all 0.3s ease;
			}
			.sidebar .nav-links li.showMenu i.arrow{
			  transform: rotate(-180deg);
			}
			.sidebar.close .nav-links i.arrow{
			  display: none;
			}
			.sidebar .nav-links li a{
			  display: flex;
			  align-items: center;
			  text-decoration: none;
			}
			.sidebar .nav-links li a .link_name{
			  font-size: 18px;
			  font-weight: 400;
			  color: #fff;
			  transition: all 0.4s ease;
			}
			.sidebar.close .nav-links li a .link_name{
			  opacity: 0;
			  pointer-events: none;
			}
			.sidebar .nav-links li .sub-menu{
			  padding: 6px 6px 14px 80px;
			  margin-top: -10px;
			  background: #1d1b31;
			  display: none;
			}
			.sidebar .nav-links li.showMenu .sub-menu{
			  display: block;
			}
			.sidebar .nav-links li .sub-menu a{
			  color: #fff;
			  font-size: 15px;
			  padding: 5px 0;
			  white-space: nowrap;
			  opacity: 0.6;
			  transition: all 0.3s ease;
			}
			.sidebar .nav-links li .sub-menu a:hover{
			  opacity: 1;
			}
			.sidebar.close .nav-links li .sub-menu{
			  position: absolute;
			  left: 100%;
			  top: -10px;
			  margin-top: 0;
			  padding: 10px 20px;
			  border-radius: 0 6px 6px 0;
			  opacity: 0;
			  display: block;
			  pointer-events: none;
			  transition: 0s;
			}
			.sidebar.close .nav-links li:hover .sub-menu{
			  top: 0;
			  opacity: 1;
			  pointer-events: auto;
			  transition: all 0.4s ease;
			}
			.sidebar .nav-links li .sub-menu .link_name{
			  display: none;
			}
			.sidebar.close .nav-links li .sub-menu .link_name{
			  font-size: 18px;
			  opacity: 1;
			  display: block;
			}
			.sidebar .nav-links li .sub-menu.blank{
			  opacity: 1;
			  pointer-events: auto;
			  padding: 3px 20px 6px 16px;
			  opacity: 0;
			  pointer-events: none;
			}
			.sidebar .nav-links li:hover .sub-menu.blank{
			  top: 50%;
			  transform: translateY(-50%);
			}
			.sidebar .profile-details{
			  position: fixed;
			  bottom: 0;
			  width: 230px;
			  display: flex;
			  align-items: center;
			  justify-content: space-between;
			  background: #1d1b31;
			  padding: 12px 0;
			  transition: all 0.5s ease;
			}
			.sidebar.close .profile-details{
			  background: none;
			}
			.sidebar.close .profile-details{
			  width: 78px;
			}
			.sidebar .profile-details .profile-content{
			  display: flex;
			  align-items: center;
			}
			.sidebar .profile-details img{
			  height: 52px;
			  width: 52px;
			  object-fit: cover;
			  border-radius: 16px;
			  margin: 0 14px 0 12px;
			  background: #1d1b31;
			  transition: all 0.5s ease;
			}
			.sidebar.close .profile-details img{
			  padding: 10px;
			}
			.sidebar .profile-details .profile_name,
			.sidebar .profile-details .job{
			  color: #fff;
			  font-size: 15px;
			  font-weight: 500;
			  white-space: nowrap;
			}
			.sidebar.close .profile-details i,
			.sidebar.close .profile-details .profile_name,
			.sidebar.close .profile-details .job{
			  display: none;
			}
			.sidebar .profile-details .job{
			  font-size: 12px;
			}
			.home-section{
			  position: relative;
			  background: #E4E9F7;
                          min-height: 100vh;
			  height: 100%;
			  left: 230px;
			  width: calc(100% - 230px);
			  transition: all 0.5s ease;
			}
			.sidebar.close ~ .home-section{
			  left: 78px;
			  width: calc(100% - 78px);
			}
                        .sidebar.close ~ .home-section .video-block{
                            transform: scale(.99);
                            transition: .3s;
			}
                        .sidebar.close ~ .home-section .video-block:hover{
                            transform: scale(1.05);
                            z-index: 99;
                        }
                        
			.home-section .home-content{
			  height: 60px;
			  display: flex;
			  align-items: center;
			}
			.home-section .home-content .bx-menu,
			.home-section .home-content .text{
			  color: #11101d;
			  font-size: 35px;
			}
			.home-section .home-content .bx-menu{
			  margin: 0 15px;
			  cursor: pointer;
			}
			.home-section .home-content .text{
			  font-size: 26px;
			  font-weight: 600;
			}
			@media (max-width: 420px) {
			  .sidebar.close .nav-links li .sub-menu{
				display: none;
			  }
			}
			<!-- divider style css -->
			.wrapper
			{
			  padding-bottom: 90px;
			}

			.divider
			{
			  position: relative;
			  margin-top: 90px;
			  height: 1px;
			}

			.div-transparent:before
			{
			  content: "";
			  position: absolute;
			  top: 0;
			  left: 5%;
			  right: 5%;
			  width: 90%;
			  height: 1px;
			  background-image: linear-gradient(to right, transparent, rgb(48,49,51), transparent);
			}

			.div-dot:after
			{
			  content: "";
			  position: absolute;
			  z-index: 1;
			  top: -9px;
			  left: calc(50% - 9px);
			  width: 18px;
			  height: 18px;
			  background-color: goldenrod;
			  border: 1px solid rgb(48,49,51);
			  border-radius: 50%;
			  box-shadow: inset 0 0 0 2px white,
					  0 0 0 4px white;
			}
                   
                /*======================== search box  ============================*/ 
	
                        .container .input{
                                border: 0;
                                outline: none;
                                color: #8b7d77;
                        }

                        .search_wrap{
                                width: 500px;
                                margin: 38px auto;
                        }

                        .search_wrap .search_box{
                                position: relative;
                                width: 500px;
                                height: 45px;
                        }

                        .search_wrap .search_box .input{
                                position: absolute;
                                top: 0;
                                left: 0;
                                width: 100%;
                                height: 100%;
                                padding: 10px 20px;
                                border-radius: 3px;
                                font-size: 18px;
                        }

                        .search_wrap .search_box .btn{
                                position: absolute;
                                top: 0;
                                right: 0;
                                width: 60px;
                                height: 100%;
                                background: #7690da;
                                z-index: 1;
                                cursor: pointer;
                             
                        }

                        .search_wrap .search_box .btn:hover{
                                background: #708bd2;
                        }

                        .search_wrap .search_box .btn.btn_common .bx{
                                position: absolute;
                                top: 50%;
                                left: 50%;
                                transform: translate(-50%,-50%);
                                color: #fff;
                                font-size: 20px;
                        }

                        .search_wrap.search_wrap_1 .search_box .btn{
                                right: 0;
                                border-top-right-radius: 3px;
                                border-bottom-right-radius: 3px;
                        }

                        .search_wrap.search_wrap_1 .search_box .input{
                                padding-right: 80px;
                        }
                       
         /*================================================ search box  ========================================================*/ 
		
	/*=========================================== how to show video  ======================================================*/ 
        .video-block{
            width: clamp(50px,70%,360px);
        }
        .video-name {
          flex: 1;
          padding-top: 9px;
        }
        .video-name img{
          border-radius: 100%;
          width: 30px;
          height: 30px;
          float: left;
          margin-right: 10px;
        }

        .video-name h3{font-size: 15px;padding-bottom: 4px;margin-bottom: 8px;display: block;}

        .user
        {
          line-height: 25px;
          font-size: 13px;
          color: #737373;
        }

        .user {
          display: block;
          font-weight: 600;
        }
        .user i{
                cursor: pointer;
                line-height: 25px;
                font-size: 20px;
                float: right;
        }
        a{
                cursor: pointer;
                text-decoration:  none;
        }
        a:hover{
            color: #5a5a5a;
        }

</style>
    <script>
            $(document).ready(function(){
                $(".btn.btn_common").click(function(){
                    var text = $("#search").val();
                    $.post(
                         "search.jsp",{sch:text},function(data){
                            var dt = data.trim();
                            if(dt != "index"){
                                //alert(data);
                                $("#rec").html(data);
                            }
                         }
                    );
                });
                $(".bx.bxs-heart").click(function(){
                    var id = $(this).attr("id");
                    $.post(
                         "favourite.jsp",{vcode:id},function(data){
                            var dt = data.trim();
                            //alert(data);
                            if(dt == "favourite"){
                                $("#"+id).css("color","red");
                            }
                            else if(dt=="unfavourite") {
                                $("#"+id).css("color","#5a5a5a");
                            }
                         }
                         
                    );
                });
                $(".category").click(function(){
                    var text = $(this).text();
                    $.post(
                         "search.jsp",{sch:text},function(data){
                            var dt = data.trim();
                            if(dt != "index"){
                                //alert(data);
                                $("#search").val(text);
                                $("#rec").html(data);
                            }
                         }
                    );
                });
                $(".channel").click(function(){
                    var code = $(this).attr("id");
                    //alert(code);
                    $.post(
                         "channel_page.jsp",{ccode:code},function(data){
                                //alert(data);
                            var dt = data.trim();
                            if(dt != "index"){
                                $("#rec").html(data);
                            }
                         }
                    );
                });
                $(".favourite").click(function(){
                    $("#rec").load("favourite_page.jsp");
                });
                $(".watch-later").click(function(){
                    $("#rec").load("watch_later_page.jsp");
                });
                $(".history").click(function(){
                    $("#rec").load("history_page.jsp");
                });
            });
            $(document).on("click",".channel",function(){
                var code = $(this).attr("id");
                //alert(code);
                $.post(
                     "channel_page.jsp",{ccode:code},function(data){
                            //alert(data);
                            var dt = data.trim();
                            if(dt != "index"){
                                $("#rec").html(data);
                            }
                     }
                );
             });
             $(document).on("click",".btn.btn_common",function(){
                var text = $("#search").val();
                $.post(
                     "search.jsp",{sch:text},function(data){
                          //alert(data);
                          var dt = data.trim();
                          if(dt != "index"){
                                //alert(data);
                                $("#rec").html(data);
                          }
                     }
                );
          });
          $(document).on("click",".bx.bxs-trash.1",function(){
                var code = $(this).attr("rel");
                $.post(
                     "remove_fav.jsp",{vcode:code},function(data){
                          var dt = data.trim();
                          if(dt != "index"){
                                //alert(data);
                                $("#del-"+code).fadeOut();
                          }
                     }
                );
          });
          $(document).on("click",".bx.bxs-trash.2",function(){
                var code = $(this).attr("rel");
                $.post(
                     "remove_watch.jsp",{vcode:code},function(data){
                          var dt = data.trim();
                          if(dt != "index"){
                                //alert(data);
                                $("#d-"+code).fadeOut();
                          }
                     }
                );
          });
          $(document).on("click",".bx.bxs-trash.3",function(){
                var code = $(this).attr("rel");
                $.post(
                     "remove_history.jsp",{vcode:code},function(data){
                          var dt = data.trim();
                          if(dt != "index"){
                                //alert(data);
                                $("#dl-"+code).fadeOut();
                          }
                     }
                );
          });
    </script>
</head>
<body>
  <div class="sidebar close">
    <div class="logo-details">
      <i class='bx bxl-venmo'>V</i>
      <span class="logo_name">VR Tube</span>
    </div>
    <ul class="nav-links">
        <li>
        <a href="index.jsp">
          <i class='bx bxs-home' ></i>
          <span class="link_name">Home</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="index.jsp">Home</a></li>
        </ul>
      </li>
      <li>
        <a href="dashboard.jsp">
          <i class='bx bx-grid-alt' ></i>
          <span class="link_name">My Channel</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="dashboard.jsp">My Channel</a></li>
        </ul>
      </li>
      <li>
        <div class="iocn-link">
          <a>
            <i class='bx bx-book-alt' ></i>
            <span class="link_name">Category</span>
          </a>
          <i class='bx bxs-chevron-down arrow' ></i>
        </div>
          <ul class="sub-menu">
          <li><a class="link_name" href="#">Category</a></li>
          <li><a class="category" href="#">Music</a></li>
          <li><a class="category" href="#">Entertainment</a></li>
          <li><a class="category" href="#">Film</a></li>
          <li><a class="category" href="#">News</a></li>
          <li><a class="category" href="#">Kids</a></li>
          <li><a class="category" href="#">Comedy</a></li>
          <li><a class="category" href="#">Eduction</a></li>
          <li><a class="category" href="#">HowTo & Style</a></li>
          <li><a class="category" href="#">Animation</a></li>
          <li><a class="category" href="#">Politics</a></li>
          <li><a class="category" href="#">Motivation</a></li>
          <li><a class="category" href="#">Yoga</a></li>
          <li><a class="category" href="#">Exercise</a></li>
          <li><a class="category" href="#">Anime</a></li>
          <li><a class="category" href="#">Bhajan</a></li>
          <li><a class="category" href="#">Movies</a></li>
          <li><a class="category" href="#">Short Clips & Videos</a></li>
        </ul>
      </li>
      <%
         if(flag==1){
         %>
      <li>
        <div class="iocn-link">
          <a href="#">
            <i class='bx bx-collection' ></i>
            <span class="link_name">SUBSCRIPTIONS</span>
          </a>
          <i class='bx bxs-chevron-down arrow' ></i>
        </div>
        <ul class="sub-menu">
          <li><a class="link_name" href="#">SUBSCRIPTIONS</a></li>
          <%
             Statement st3 = cn.createStatement();
             ResultSet rs3 = st3.executeQuery("select * from subscribe where email = '"+email+"'");
             while(rs3.next()){
                 String channel_code3 = rs3.getString("channel_code");
                 Statement st4 = cn.createStatement();
                 ResultSet rs4 = st4.executeQuery("select * from channel where code = '"+channel_code3+"'");
                 if(rs4.next()){
                %>
                <li><a class="channel" id="<%=rs4.getString("code")%>"><%=rs4.getString("channel_name")%></a></li>
                <%  
                 }
             }
           %> 
        </ul>
      </li>
      
      <li class="favourite" id='<%=email%>'>
        <a>
          <i class='bx bxs-heart'></i>
          <span class="link_name">Favourite</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name">Favourite</a></li>
        </ul>
      </li>
      <li class="watch-later">
        <a>
          <i class="fa fa-clock-o" aria-hidden="true"></i>
          <span class="link_name">Watch Later</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name">Watch Later</a></li>
        </ul>
      </li>
      <li class="history">
        <a>
          <i class='bx bx-history'></i>
          <span class="link_name">History</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name">History</a></li>
        </ul>
      </li>
      <li>
        <a href="logout.jsp">
          <i class='bx bx-log-out-circle' ></i>
          <span class="link_name">Logout</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="logout.jsp">Logout</a></li>
        </ul>
      </li>
      <%
         }
         else{
         %>
      <li>
        <a href="register.jsp">
          <i class='bx bx-log-in-circle' ></i>
          <span class="link_name">Sign-up</span>
        </a>
        <ul class="sub-menu blank">
          <li><a class="link_name" href="register.jsp">Sign-up</a></li>
        </ul>
      </li>
      <%
         }
         %>
      
      <li>
       <%
            if(flag==1){
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from user where email=email");
                if(rs.next()){
        %>    
        <div class="profile-details">
                <div class="profile-content">
                        <img src="profile/<%=rs.getString("code")%>.jpg" alt="profileImg">
                </div>
                <div class="name-job">
                        <div class="profile_name"><%=rs.getString("username")%></div>
                </div>
                <a href="logout.jsp"><i class='bx bx-log-out' ></i></a>
        </div>
<%              }
            }
            else{
        %>
        <div class="profile-details">
                <div class="profile-content">
                        <img src="" alt="profile">
                </div>
                <div class="name-job">
                        <div class="profile_name">Rahul Bhati</div>
                        <div class="job">Web Desginer</div>
                </div>
                <a href="register.jsp"><i class='bx bx-log-in' ></i></a>
        </div>
        <%
            }
        %>
      </li>
		
    </ul>
  </div>
  <section class="home-section">
    <div class="home-content">
      <i class='bx bx-menu' ></i>
      <div class="container">
        <div class="search_wrap search_wrap_1">
          <div class="search_box">
            <input type="text" class="input" id="search" placeholder="search...">
            <div class="btn btn_common">
              <i class='bx bx-search'></i>
            </div>
          </div>
        </div>
      </div>
      
    </div>
      <div class="container-fluid" id="rec">  
            <div class="row">
                            <%
                            Statement st1 = cn.createStatement();
                            ResultSet rs1 = st1.executeQuery("select * from video");
                            while(rs1.next()){
                            %>
<!--                               "-->

                            <div class="col-sm-3 video-block">
                                <table class="table table-borderless card w3-card" style="width:320px;">
                                    <tr>
                                        <td>
                                            <a href="video-page.jsp?vcode=<%=rs1.getString("code")%>" rel=""><img src="channel_Video/<%=rs1.getString("code")%>.jpg" style="width:300px;height: 200px;" class="img-fluid"></a>
                                        </td>
                                    </tr>
                                    <tr class="video-name">
                                        <td style=""><h3> <b><a href="video-page.jsp?vcode=<%=rs1.getString("code")%>" rel=""><%=rs1.getString("video_name")%></a></b> </h3>
                                             <%
                                                 String channel_code = rs1.getString("channel_code");
                                                 Statement st2 = cn.createStatement();
                                                 ResultSet rs2 = st2.executeQuery("select * from channel where code='"+channel_code+"'");
                                                 if(rs2.next()){
                                             %>
                                             <img src="channel_Image/<%=rs2.getString("code")%>.jpg" alt="">
                                             <span class="user"><a class='subscribe' id="<%=rs2.getString("code")%>"><%=rs2.getString("channel_name")%></a>
                                              <%   
                                                 if(flag==1){
                                                        String video_code = rs1.getString("code");
                                                        Statement st5 = cn.createStatement();
                                                        ResultSet rs5 = st5.executeQuery("select * from favourite where video_code='"+video_code+"' AND email='"+email+"'");
                                                        if(rs5.next()){                                                  
                                              %>
                                                            <i class='bx bxs-heart' id="<%=rs1.getString("code")%>" style="color:red;"></i>
                                               <% 
                                                        }
                                                        else{
                                                         %>
                                                          <i class='bx bxs-heart' id="<%=rs1.getString("code")%>" style="color:#5a5a5a;"></i>
                                                           <%
                                                        }
                                                 }
                                               %>
                                             </span>
                                        </td>
                                             <%
                                                 }   
                                             %>
                                    </tr>
                                </table>
                            </div>
                            <%
                             }
                            %>
             </div>
      </div>
    <div class="row">
      <div class="wrapper">
        <div class="divider div-transparent div-dot"></div>
      </div><br><br>
    </div><br><br>
    <div class="row">
        <div class="col-sm-12"></div>
        <div class="col-sm-12"></div>
        <div class="col-sm-6" style="padding:20px;">
        <div style="margin-left:40px;">
            <h3>Follow us on:</h3>
            <a href="" style="font-size:25px;color:black;"><i class='bx bxl-facebook-circle'></i></a> &nbsp;
            <a href="" style="font-size:25px;color:black;"><i class='bx bxl-instagram' ></i></a>&nbsp;
            <a href="" style="font-size:25px;color:black;"><i class='bx bxl-twitter' ></i></a>
        </div>
        </div>
        <div class="col-sm-6" style="padding:40px;">
            <center>© VR Tube.com <br> All rights reserved and created by Rahul Bhati</center>
        </div>
    </div>
      <div class="row">
      </div>
  </section> 
    <!-- ============================================= For Animation ============================================================= --> 
        <script src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-157cd5b220a5c80d4ff8e0e70ac069bffd87a61252088146915e8726e5d9f147.js"></script>

          <script src='https://unpkg.com/aos@2.3.0/dist/aos.js'></script>

              <script id="rendered-js" >
        AOS.init({
          duration: 1000 });
        //# sourceURL=pen.js
            </script>

   <!-- ============================================= For Animation ============================================================= --> 
  <script>
    let arrow = document.querySelectorAll(".arrow");
    for (var i = 0; i < arrow.length; i++) {
      arrow[i].addEventListener("click", (e)=>{
        let arrowParent = e.target.parentElement.parentElement;//selecting main parent of arrow
        arrowParent.classList.toggle("showMenu");
      });
    }
    let sidebar = document.querySelector(".sidebar");
    let sidebarBtn = document.querySelector(".bx-menu");
    console.log(sidebarBtn);
    sidebarBtn.addEventListener("click", ()=>{
      sidebar.classList.toggle("close");  
    });

  </script>
</body>
</html>
<%
                
                cn.close();
            }
            catch(ClassNotFoundException e){
                System.out.println("Driver : "+ e.getMessage());
            }
            catch(SQLException er){
                System.out.println("SQL : "+er.getMessage());
            }
        }
        catch(NullPointerException er){
            response.sendRedirect("index.jsp");
        }  
%>