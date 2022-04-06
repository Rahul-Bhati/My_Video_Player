<%-- 
    Document   : watch_later_page
    Created on : 12 Mar, 2022, 2:13:51 PM
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
                //response.sendRedirect("index.jsp");
                out.print("index");
            }
            else{
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("select * from user where email = '"+email+"'");
                        %>
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
                          .user-image{
                              min-height: 100%;
                            max-height: 100%;
                            position: relative;
                            display: block;
                            min-height: 250px;
                          }
                          .user-image img{
                              position: relative;
                              width: 100px;
                              height: 100px;
                              border-radius: 50%;
                              margin-top: -150px;                              
                              margin-left: 50px;

                          }
                          .user-image h3{
                              position: relative;
                              margin-top: -120px;                              
                              margin-left: 180px;
                              font-size: 30px;
                              color: white;
                          }
                       </style>
               <div class="row">
                   <div class="col-sm-12 cover">
                        <img class="img-fluid" src="2.jpg" width="100%">
                    </div>
                   <%
                        if(rs.next()){
                        %>
                   <div class="user-image">
                           <img src="profile/<%=rs.getString("code")%>.jpg" class="img fluid">
                           <h3><b><%=rs.getString("username")%></b></h3>
                       </div>
                           <%
                        }
                        %>
                   <div class="col-sm-12"></div><br>
                   <div class="col-sm-12" style='margin-top:-200px;'>
                        <div class="row">

               <%
                        Statement st1 = cn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select * from watch_later where email = '"+email+"'");
                        while(rs1.next()){
                            String v_code = rs1.getString("video_code");
                            Statement st2 = cn.createStatement();
                            ResultSet rs2 = st2.executeQuery("select * from video where code = '"+v_code+"'");
                            if(rs2.next()){
                                %>

                            <div class="col-sm-3 video-block" id="d-<%=rs2.getString("code")%>">
                                <table class="table table-borderless card w3-card" style="width:320px;">
                                    <tr>
                                        <td>
                                            <a href="video-page.jsp?vcode=<%=rs2.getString("code")%>" rel=""><img src="channel_Video/<%=rs2.getString("code")%>.jpg" style="width:300px;height: 200px;" class="img-fluid"></a>
                                        </td>
                                    </tr>
                                    <tr class="video-name">
                                        <td style=""><h3> <b><a href="video-page.jsp?vcode=<%=rs2.getString("code")%>" rel=""><%=rs2.getString("video_name")%></a></b> </h3>
                                             <%
                                                 String channel_code = rs2.getString("channel_code");
                                                 Statement st3 = cn.createStatement();
                                                 ResultSet rs3 = st3.executeQuery("select * from channel where code='"+channel_code+"'");
                                                 if(rs3.next()){
                                             %>
                                             <img src="channel_Image/<%=rs3.getString("code")%>.jpg" alt="">
                                             <span class="user">
                                                 <a class='channel' id="<%=rs3.getString("code")%>"><%=rs3.getString("channel_name")%></a>
                                                 <i class='bx bxs-trash 2' rel="<%=rs2.getString("code")%>" style="color: red;" title="Remove"></i>
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
                        }
                          %>
                        </div>
                   </div>
               </div>
                <%  
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
    catch(NullPointerException er){
         out.println(er.getMessage());
    }
                
%>





