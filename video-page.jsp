<%-- 
    Document   : video-page
    Created on : 6 Mar, 2022, 4:35:12 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
  try{
            String email = null;
            int flag = 0;
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
            
            if(request.getParameter("vcode")==null){
                response.sendRedirect("index.jsp");
            }
            else{
                String video_code = request.getParameter("vcode");
                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                   
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from video where code='"+video_code+"'");
                    if(rs.next()){
                        String channel_code = rs.getString("channel_code");
                        Statement st1 = cn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select * from channel where code='"+channel_code+"'");
                        if(rs1.next()){
                            if(flag==1){
                                Statement st17 = cn.createStatement();
                                ResultSet rs17 = st17.executeQuery("select * from user_view where video_code='"+video_code+"' AND email='"+email+"'");
                                if(rs17.next()){}
                                else{
                                    PreparedStatement ps = cn.prepareStatement("insert into user_view values(?,?)");
                                    ps.setString(1,video_code);
                                    ps.setString(2,email);
                                    if(ps.executeUpdate()>0){}
                                }
                                Statement st19 = cn.createStatement();
                                ResultSet rs19 = st19.executeQuery("select * from history where video_code='"+video_code+"' AND email='"+email+"'");
                                if(rs19.next()){}
                                else{
                                    PreparedStatement ps = cn.prepareStatement("insert into history values(?,?)");
                                    ps.setString(1,video_code);
                                    ps.setString(2,email);
                                    if(ps.executeUpdate()>0){}
                                }

                            }
                                
                            
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
  background: white;
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
        border: 1;
        outline: 0.5;
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
a{
        cursor: pointer;
        text-decoration:  none;
}
          
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

/* ===========================================  Video Page =============================================== */

.row-1{
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}
.play-video{
    flex-basis: 69%;
}
.right-sidebar{
    flex-basis: 30%;
}
.play-video video{
    width: 100%;
}
.side-video-list{
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
}
.side-video-list img{
    width: 300px;
    height: 150px;
    padding: 5px 0;
    border-radius: 30%;
}
.side-video-list .small-thumbnail{
    flex-basis: 50%;
}
.side-video-list .vid-info{
    flex-basis: 49%;
}
.play-video .tags a{
    color: #0000ff;
    font-size: 13px;
}
.play-video h3{
    font-weight: 600;
    font-size: 22px;
}
.play-video .play-video-info{
    display: flex;
    align-items:center;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-top: 10px;
    font-size: 14px;
    color: #5a5a5a;
}
.play-video .play-video-info a i{
    width: 20px;
    margin-right: 8px;
}
.play-video .play-video-info a{
    display: inline-flex;
    align-items: center;
    margin-left: 15px;
}
.play-video hr{
    border: 0;
    height: 2px;
    background: #ccc;
    margin: 10px 0px;
}
.publish{
    display: flex;
    algn-items: center;
    margin-top: 20px;
}
.publish div{
    flex: 1;
    line-height: 18px;
}
.publish img{
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 15px;
}
.publish div p{
    color: #000;
    font-weight: 600;
    font-size: 18px;
}
.publish div span{
    font-size: 13px;
    color: #5a5a5a;
}
.publish button{
    background: red;
    color: white;
    padding: 2px 10px;
    border: 0;
    outline: 0;
    border-radius: 50%;
    cursor: pointer;
}
.description{
    padding-left: 55px;
    margin: 15px 0px;
}
.description p{
    font-size: 14px;
    margin-bottom: 5px;
    color: #5a5a5a;
}
.description h4{
    font-size: 14px;
    color: #5a5a5a;
    margin-top: 15px;
}
.comment{
    display: flex;
    algn-items: center;
    margin: 30px 0px;
    position: relative;
}
.comment img{
    width: 35px;
    height: 35px;
    border-radius: 50%;
    margin-right: 15px;
}
.comment input{
    border: 0;
    outline: 0;
    border-bottom: 1px solid #ccc;
    width: 100%;
    padding-top: 10px;
    background: transparent;
}
.comment i{
    border: none;
    padding-top: 10px;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
}
.comment i:hover{
    color: blue;
}
.old-comment{
    display: flex;
    algn-items: center;
    margin: 20px 0px;
}
.old-comment img{
    width: 35px;
    height: 35px;
    border-radius: 50%;
    margin-right: 15px;
}
.old-comment h3{
    font-size: 14px;
    margin-bottom: 5px;
}
.old-comment h3 span{
    font-size: 12px;
    color: #5a5a5a;
    font-weight: 500;
    margin-left: 8px;
}
.old-comment .comment-action{
    display: flex;
    align-items: center;
    margin: 8px 0;
    font-size: 14px;
}
.old-comment .comment-action img{
    border-radius: 0;
    width: 20px;
    margin-right: 5px;
}
.old-comment .comment-action span{
    margin-right: 20px;
    color: #5a5a5a;
}
.old-comment .comment-action a{
    color: #0000ff;
}
@media(max-width:900px){
    .play-video{
        flex-basis: 100%;
    }
    .right-sidebar{
        flex-basis: 100%;
    }
    .description{
        padding-left: 0;
    }
    .play-video .play-video-info a{
        margin-left: 0;
        margin-right: 15px;
        margin-top: 15px;
    }
}
i{
    cursor: pointer;
}
</style>
    <script>
        $(document).ready(function(){
            $(".bxs-like").click(function(){
                var code = $(this).attr("rel");
                var ptr = $(this).attr("pid");
                var num=0;
                $.post(
                     "like.jsp",{code:code,ptr:ptr},function(data){
                          var dt = data.trim();
                          var s = dt.split("-");
                          //alert(dt+" "+s);
                          if(dt!="index"){
                            $("#like-"+code).css("color",s[0]);                
                            $("#dislike-"+code).css("color","black");
                            $("#likecount-"+code).text(s[1]);
                            $("#dislikecount-"+code).text(s[2]);
                          }
                     }
                );
            });
            $(".bxs-dislike").click(function(){
                var code = $(this).attr("rel");
                var ptr = $(this).attr("pid");
                var num=0;
                $.post(
                     "dislike.jsp",{code:code,ptr:ptr},function(data){
                          var dt = data.trim();
                          var s = dt.split("-");
                         // alert(dt+" "+s);
                         if(dt!="index"){
                            $("#dislike-"+code).css("color",s[0]);
                            $("#like-"+code).css("color","black");
                            $("#likecount-"+code).text(s[1]);
                            $("#dislikecount-"+code).text(s[2]);
                         }
                     }
                );
            });
            $(".subscribe").click(function(){
                var code = $(this).attr("rel");
                //alert(code);
                $.post(
                    "subscribe.jsp",{ccode:code},function(data){
                        //alert(data);
                       var sub = data.trim();
                       if(sub!="index"){
                            $("#sub-"+code).text(sub);
                       }
                    }
                );
            });
            $(".btn.btn_common").click(function(){
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
            $(".bx.bxs-playlist").click(function(){
                var code = $(this).attr("rel"); 
                //alert(code);
                $.post(
                        "watch-later.jsp",{vcode:code},function(data){
                            var dt = data.trim();
                            if(dt == "success"){
                                $("#watch-"+code).css("color","blue");
                            }
                            else if(dt == "exist"){
                                $("#watch-"+code).css("color","#5a5a5a");
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
            $(".tags").click(function(){
                var text = $("#tags").text();
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
            $(".bx.bx-shuffle").click(function(){
                var vcode = $(this).attr("rel");
                $.post(
                      "load_rand_video.jsp",{vcode:vcode},function(data){
                            var dt = data.trim();
                            $("#random-video").html(dt);
                      }
                );
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
          
/* =======================================  JQuery for comment operation Start ===================================  */
        $(document).on("click",".bx.bxs-send",function(){
                var code = $(".cmt-text").attr("id");
                var text = $(".cmt-text").val();
                var femail = $(".cmt-text").attr("rel"); 
                //alert(code+" "+text+" "+femail);
                $.post(
                        "comment.jsp",{vcode:code,cmt:text,femail:femail},function(data){
                            var dt = data.trim();
                            //alert(dt);
                            if(dt != "index"){
                                $(".cmt-text").val(" ");
                                $("#cmt").append(dt);
                            }
                        }
                );
            });
        $(document).on("click",".bx.bxs-edit",function(){
            var code = $(this).attr("id");
            var val = $("#e-"+code).text();
            //alert(code+" "+val);
            $("#e-"+code).html("<input id='s-"+code+"' type='text' value='"+val+"' class='form-control' style='width:80%'>");
            $("#"+code).attr("class","bx bxs-save");
        });
        $(document).on("click",".bx.bxs-save",function(){
            var code = $(this).attr("id");
            var val = $("#s-"+code).val();
            //alert(code+" "+val);
            $.post(
                 "save_cmt.jsp",{code:code,val:val},function(data){
                     if(data.trim()=="success"){
                         $("#e-"+code).text(val);
                         $("#"+code).attr("class","bx bxs-edit");
                     }
                 }
            );
        });
        $(document).on("click",".bx.bxs-message-square-x",function(){
            var code = $(this).attr("rel");
            //alert(code);
            $.post(
                 "del_cmt.jsp",{code:code},function(data){
                     if(data.trim()=="success")
                        $("#d-"+code).fadeOut(1000);
                 }
            );
        });
        $(document).on("click",".bx.bxs-like",function(){
            var code = $(this).attr("rel");
            var pid = $("#like-"+code).attr("pid");
            $.post(
                 "cmt_liked.jsp",{code:code,pid:pid},function(data){
                     var dt = data.trim();
                     var s = dt.split("-");
                     if(dt!="index"){
                       $("#like-"+code).css("color",s[0]);                
                       $("#dislike-"+code).css("color","black");
                       $("#likecount-"+code).text(s[1]);
                       $("#dislikecount-"+code).text(s[2]);
                     }
                 }
            );
            
        });
        $(document).on("click",".bx.bxs-dislike",function(){
            var code = $(this).attr("rel");
            var pid = $("#dislike-"+code).attr("pid");
            $.post(
                 "cmt_disliked.jsp",{code:code,pid:pid},function(data){
                     var dt = data.trim();
                     var s = dt.split("-");
                     if(dt!="index"){
                       $("#dislike-"+code).css("color",s[0]);                
                       $("#like-"+code).css("color","black");
                       $("#likecount-"+code).text(s[1]);
                       $("#dislikecount-"+code).text(s[2]);
                     }
                 }
            );
        });
        $(document).ready(function(){
            $(".btn.load").click(function(){
                var id = $(this).attr("id");
                var next = parseInt(id)+1;
                var vcode = $(this).attr("rel");
               // alert(id+" "+next+" "+vcode);
                $.post(
                      "load_cmt.jsp",{id:id,vcode:vcode},function(data){
                            var dt = data.trim();
                            if(dt=="")
                                $(".btn.load").fadeToggle(1000);
                            $("#cmt").append(dt);
                            $(".btn.load").attr("id",next);
                      }
                );
            });
        });
/* =======================================  JQuery for comment operation End ===================================  */

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
          <li><a class="link_name">Category</a></li>
          <li><a class="category">Music</a></li>
          <li><a class="category">Entertainment</a></li>
          <li><a class="category">Film</a></li>
          <li><a class="category">News</a></li>
          <li><a class="category">Kids</a></li>
          <li><a class="category">Comedy</a></li>
          <li><a class="category">Eduction</a></li>
          <li><a class="category">HowTo & Style</a></li>
          <li><a class="category">Animation</a></li>
          <li><a class="category">Politics</a></li>
          <li><a class="category">Motivation</a></li>
          <li><a class="category">Yoga</a></li>
          <li><a class="category">Exercise</a></li>
          <li><a class="category">Anime</a></li>
          <li><a class="category">Bhajan</a></li>
          <li><a class="category">Movies</a></li>
          <li><a class="category">Short Clips & Videos</a></li>
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
             Statement st12 = cn.createStatement();
             ResultSet rs12 = st12.executeQuery("select * from subscribe where email = '"+email+"'");
             while(rs12.next()){
                 String channel_code3 = rs12.getString("channel_code");
                 Statement st13 = cn.createStatement();
                 ResultSet rs13 = st13.executeQuery("select * from channel where code = '"+channel_code3+"'");
                 if(rs13.next()){
                %>
                <li><a class="channel" id="<%=rs13.getString("code")%>"><%=rs13.getString("channel_name")%></a></li>
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
                Statement st2 = cn.createStatement();
                ResultSet rs2 = st2.executeQuery("select * from user where email=email");
                if(rs2.next()){
        %>    
        <div class="profile-details">
                <div class="profile-content">
                        <img src="profile/<%=rs2.getString("code")%>.jpg" alt="profileImg">
                </div>
                <div class="name-job">
                        <div class="profile_name"><%=rs2.getString("username")%></div>
                </div>
                <a href="logout.jsp"><i class='bx bx-log-out' ></i></a>
        </div>
<%                     
                }
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
        <div class="row-1">
            <div class="play-video col-sm-8">
                <video src="channel_Video/<%=rs.getString("code")%>.mp4" controls="true"></video>               
                <div class="tags">
                    <a id="tags">#<%=rs1.getString("category")%></a>
                </div>
                <h3><%=rs.getString("video_name")%></h3>
                <div class="play-video-info">
                 <%
                    Statement st18 = cn.createStatement();
                    ResultSet rs18 = st18.executeQuery("select count(*) from user_view where video_code='"+video_code+"'");
                    if(rs18.next()){           
                     %>
                    <p><%=rs18.getInt("count(*)")%> views &bull; <%=rs.getString("date")%></p>
                    <%
                       }
                 %>
                    <div >
                        <%
                            String ptr = "";
                            Statement st4 = cn.createStatement();
                            ResultSet rs4 = st4.executeQuery("select * from liked where video_code='"+video_code+"' AND email='"+email+"'");
                            if(rs4.next()){
                                ptr = rs4.getString("ptr");
                            }
                            int like=0,dislike=0;
                            Statement st8 = cn.createStatement();
                            ResultSet rs8 = st8.executeQuery("select count(*) from liked where video_code='"+video_code+"' AND ptr='like'");
                            if(rs8.next()){
                                like = Integer.parseInt(rs8.getString("count(*)"));
                            }
                            Statement st9 = cn.createStatement();
                            ResultSet rs9 = st9.executeQuery("select count(*) from liked where video_code='"+video_code+"' AND ptr='dislike'");
                            if(rs9.next()){
                                dislike = Integer.parseInt(rs9.getString("count(*)"));
                            }
                            String watch_color = "#5a5a5a";
                            Statement st14 = cn.createStatement();
                            ResultSet rs14 = st14.executeQuery("select * from watch_later where video_code='"+video_code+"' AND email='"+email+"'");
                            if(rs14.next()){
                                watch_color = "blue";
                            }
                         %>
                         
                        <a>
                            <i class='bx bxs-like' pid="like" id="like-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>" style="color:black;"></i>
                            <span id="likecount-<%=rs.getString("code")%>"><%=like%></span>
                        </a>     
                        <a>
                            <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>" style="color:black;">
                            </i><span id="dislikecount-<%=rs.getString("code")%>"><%=dislike%></span>
                        </a>
                        <a>
                            <i class='bx bxs-playlist' style="font-size:16px;color:<%=watch_color%>;" title="watch later" id="watch-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>"></i>
                        </a>
                    </div>
                    <script>
                        $(document).ready(function(){
                            var vcode = "<%=video_code%>";
                            var ptr = "<%=ptr%>";
                            if(ptr=="like"){
                                $("#like-"+vcode).css("color","blue");                
                                $("#dislike-"+vcode).css("color","black");
                            }
                            else if(ptr=="dislike"){
                                $("#dislike-"+vcode).css("color","blue");                
                                $("#like-"+vcode).css("color","black");
                            }
                        });
                    </script>
                </div>
                <hr>
                <div class="publish">
                    <img src="channel_Image/<%=rs1.getString("code")%>.jpg">
                    <div style='cursor:pointer;'>
                        <p id="<%=rs1.getString("code")%>" class="channel"><%=rs1.getString("channel_name")%></p>
                        <%
                            int sub_count = 0;
                                Statement st15 = cn.createStatement();
                                ResultSet rs15 = st15.executeQuery("select count(*) from subscribe where channel_code='"+channel_code+"'");
                                if(rs15.next()){
                                    sub_count = Integer.parseInt(rs15.getString("count(*)"));
                                }
                        %>
                        <span><%=sub_count%> Subscribers</span>
                    </div>
                        <%
                            Statement st5 = cn.createStatement();
                            ResultSet rs5 = st5.executeQuery("select * from subscribe where channel_code='"+channel_code+"' AND email='"+email+"'");
                            if(rs5.next()){ 
                        %>
                        <button type="button" id="sub-<%=rs1.getString("code")%>" rel="<%=rs1.getString("code")%>" class="rounded circle subscribe">Subscribed</button>
                        <%
                            }
                            else{
                        %>
                        <button type="button" id="sub-<%=rs1.getString("code")%>" rel="<%=rs1.getString("code")%>" class="rounded circle subscribe">Subscribe</button>
                        <%
                            }
                         %>
                </div>
                <div class="description row-2">
                    <p><%=rs.getString("detail")%></p>
                    <hr>
                    <%
                         int total_comment = 0;
                         Statement st10 = cn.createStatement();
                         ResultSet rs10 = st10.executeQuery("select count(*) from comment where video_code='"+video_code+"'");
                         if(rs10.next()){
                             total_comment = Integer.parseInt(rs10.getString("count(*)"));
                         
                    %> 
                    <h4><%=total_comment%> Comments</h4>
                    <%
                         }
                    %>
                    <div class="comment">
                        <%
                         Statement st20 = cn.createStatement();
                            ResultSet rs20 = st20.executeQuery("select * from user where email=email");
                            if(rs20.next()){
                         %>
                        <img src="profile/<%=rs20.getString("code")%>.jpg" alt="profileImg">
                        <input type="text" placeholder="Write comments... " id="<%=rs.getString("code")%>" rel="<%=rs.getString("email")%>" class="cmt-text">
                        <i class='bx bxs-send' style="cursor:pointer;"></i>
                        <%
                            }        
                        %>
                    </div>
                    <div class="old-comment row" id="cmt">
                        
                    <%
                         Statement st11 = cn.createStatement();
                         ResultSet rs11 = st11.executeQuery("select * from comment where video_code='"+video_code+"' limit 0,1 ");
                         while(rs11.next()){
                             String from_email = rs11.getString("from_email");
                             String cmt_code = rs11.getString("code");
                             Statement st12 = cn.createStatement();
                             ResultSet rs12 = st12.executeQuery("select * from user where email='"+from_email+"'");
                             if(rs12.next()){
                                
                                String ptrn = "";
                                int cmt_like=0,cmt_dislike=0;
                                Statement st21 = cn.createStatement();
                                ResultSet rs21 = st21.executeQuery("select * from cmt_liked where cmt_code='"+cmt_code+"' AND email='"+email+"'");
                                if(rs21.next()){
                                    ptrn = rs21.getString("ptr");
                                }
                                
                                Statement st22 = cn.createStatement();
                                ResultSet rs22 = st22.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='like'");
                                if(rs22.next()){
                                    cmt_like = Integer.parseInt(rs22.getString("count(*)"));
                                }
                                Statement st23 = cn.createStatement();
                                ResultSet rs23 = st23.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='dislike'");
                                if(rs23.next()){
                                    cmt_dislike = Integer.parseInt(rs23.getString("count(*)"));
                                }
                                
                                 if(from_email.equals(email)){
                                    %>
                                    <div class="col-sm-12" id="d-<%=rs11.getString("code")%>">
                                        <div class="row">
                                            <div class="col-sm-1">
                                                <img src="profile/<%=rs12.getString("code")%>.jpg" alt="profileImg" style="width: 35px;height: 35px;border-radius: 50%;margin-right: 15px;">
                                            </div>
                                            <div class="col-sm-11">
                                                <h3><%=rs11.getString("from_name")%> <span><%=rs11.getString("date")%></span></h3>
                                                <p id="e-<%=rs11.getString("code")%>"><%=rs11.getString("comment")%></p>
                                                <div class="comment-action">
                                                    <i class='bx bxs-like' pid="like" id="like-<%=rs11.getString("code")%>" rel="<%=rs11.getString("code")%>"></i>&nbsp;&nbsp;<span id="likecount-<%=rs11.getString("code")%>"><%=cmt_like%></span>     
                                                    <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=rs11.getString("code")%>" rel="<%=rs11.getString("code")%>"></i>&nbsp;&nbsp;<span id="dislikecount-<%=rs11.getString("code")%>"><%=cmt_dislike%></span>
                                                    <i class='bx bxs-edit' style="color: blue" id="<%=rs11.getString("code")%>"></i> &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <i class='bx bxs-message-square-x' rel="<%=rs11.getString("code")%>" style="color: red"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                 }
                                 else{
                      %>
                        
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                     <img src="profile/<%=rs12.getString("code")%>.jpg" alt="profileImg">
                                </div>
                                <div class="col-sm-11">
                                    <h3><%=rs11.getString("from_name")%> <span><%=rs11.getString("date")%></span></h3>
                                    <p>
                                        <%=rs11.getString("comment")%>
                                    </p>
                                    <div class="comment-action">
                                        <i class='bx bxs-like' pid="like" id="like-<%=rs11.getString("code")%>" rel="<%=rs11.getString("code")%>"></i>&nbsp;&nbsp;<span id="likecount-<%=rs11.getString("code")%>"><%=cmt_like%></span>     
                                        <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=rs11.getString("code")%>" rel="<%=rs11.getString("code")%>"></i>&nbsp;&nbsp;<span id="dislikecount-<%=rs11.getString("code")%>"><%=cmt_dislike%></span>
                                        <span>REPLY</span>
                                        <a href="">All replies</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                             <%
                                 }
                                 %>
                      <script>
                        $(document).ready(function(){
                            var cmcode = "<%=cmt_code%>";
                            var ptr = "<%=ptrn%>";
                            if(ptr=="like"){
                                $("#like-"+cmcode).css("color","blue");                
                                $("#dislike-"+cmcode).css("color","black");
                            }
                            else if(ptr=="dislike"){
                                $("#dislike-"+cmcode).css("color","blue");                
                                $("#like-"+cmcode).css("color","black");
                            }
                        });
                    </script>
                                 <%
                             }
                          }
                      %>
                      
                     </div>
                      <div class="load-more">
                          <center><button id="1" class="btn load" rel="<%=video_code%>" style="border-bottom:1px solid black;"><span style="font-size:18px;padding:0;">load more</span></button></center>
                      </div>
                </div>
            </div>
            <div class="right-sidebar col-sm-4">
                <div class="container">
                    <span class="pills" style="font-family:sans-serif;font-size:20px;"><b>Random Videos</b></span>
                    <button style="float:right" class="btn load-video" title="shuffle"><i class='bx bx-shuffle' rel="<%=video_code%>" style="font-size:20px;"></i></button>
                </div>
                <div class="side-video-list row" id="random-video">
                     <%
                        Statement st6 = cn.createStatement();
                        ResultSet rs6 = st6.executeQuery("select * from video where code<>'"+video_code+"' order by rand() limit 0,7 ");
                        while(rs6.next()){
                            String channel_code2 = rs6.getString("channel_code");
                            Statement st7 = cn.createStatement();
                            ResultSet rs7 = st7.executeQuery("select * from channel where code='"+channel_code2+"' AND status='0'");
                            if(rs7.next()){
                        %>
                        <a href="video-page.jsp?vcode=<%=rs6.getString("code")%>" class="small-thumbnail"><img src="channel_Video/<%=rs6.getString("code")%>.jpg" class="img-fluid rounded"></a>
                        <div class="vid-info">
                            <a href="video-page.jsp?vcode=<%=rs6.getString("code")%>"><%=rs6.getString("video_name")%></a>
                            <p class="subscribe" style="cursor:pointer;" id='<%=rs7.getString("code")%>'><%=rs7.getString("channel_name")%></p>
                            <%
                                int sub_count1 = 0;
                                Statement st16 = cn.createStatement();
                                ResultSet rs16 = st16.executeQuery("select count(*) from subscribe where channel_code='"+channel_code2+"'");
                                if(rs16.next()){
                                    sub_count1 = Integer.parseInt(rs16.getString("count(*)"));
                                }
                            %>
                           <p><%=sub_count1%> Subscribers</p>
                        </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="load-more-video">
                    <center></center>
                </div>
            </div>
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
                            
                        }
                    }
                    cn.close();
                }
                catch(ClassNotFoundException e){
                    System.out.println("Driver : "+ e.getMessage());
                }
                catch(SQLException er){
                    System.out.println("SQL : "+er.getMessage());
                }
           }
            
   }
   catch(NullPointerException ec){
       out.println(ec.getMessage());
   }
%>
