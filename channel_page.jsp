<%-- 
    Document   : channel_page
    Created on : 11 Mar, 2022, 12:25:55 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
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
            if(request.getParameter("ccode")==null){
                //response.sendRedirect("index.jsp");
                out.print("index");
            }
            else{
                String channel_code = request.getParameter("ccode");    
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from channel where code='"+channel_code+"'");
                    if(rs.next()){
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
                       <div class="col-sm-12" style='margin-top:-170px;'>
                           <div class="row">
                       <%
                        Statement st2 = cn.createStatement();
                        ResultSet rs2 = st2.executeQuery("select * from video where channel_code='"+channel_code+"'");
                        while(rs2.next()){
                        %>
                        <div class="col-sm-3 video-block">
                                <table class="table table-borderless card w3-card" style="width:320px;">
                                    <tr>
                                        <td>
                                            <a href="video-page.jsp?vcode=<%=rs2.getString("code")%>" rel=""><img src="channel_Video/<%=rs2.getString("code")%>.jpg" style="width:300px;height: 200px;" class="img-fluid"></a>
                                        </td>
                                    </tr>
                                    <tr class="video-name">
                                        <td style=""><h3> <b><a href="video-page.jsp?vcode=<%=rs2.getString("code")%>" rel=""><%=rs2.getString("video_name")%></a></b> </h3>
                                             <%
                                                 String channel_code1 = rs2.getString("channel_code");
                                                 Statement st3 = cn.createStatement();
                                                 ResultSet rs3 = st3.executeQuery("select * from channel where code='"+channel_code1+"'");
                                                 if(rs3.next()){
                                             %>
                                             <img src="channel_Image/<%=rs3.getString("code")%>.jpg" alt="">
                                             <span class="user">
                                                 <a class="channel" id="<%=rs3.getString("code")%>"><%=rs3.getString("channel_name")%></a>
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
                    </div>
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
        catch(NullPointerException er){
             out.println(er.getMessage());
        }
                
%>


