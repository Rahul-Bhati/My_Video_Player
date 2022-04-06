<%-- 
    Document   : update_video
    Created on : 26 Feb, 2022, 2:36:14 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
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
                try{
                    if(request.getParameter("vcode")==null && request.getParameter("ccode")==null){
                        response.sendRedirect("dashboard.jsp?code_error=1");
                    }
                    else{
                        String vcode = request.getParameter("vcode");      
                        String channel_code = request.getParameter("ccode");
                        
                        if(request.getParameter("video_name").length()==0 || request.getParameter("detail").length()==0 ){
                            response.sendRedirect("video.jsp?ccode="+channel_code+"&empty=1");
                        }
                        else{
                                String video_name = request.getParameter("video_name");
                                String detail = request.getParameter("detail");

                                try{
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                                    
                                    Date dt = new Date();
                                    String date = dt.toString(); 
                                    
                                    PreparedStatement ps = cn.prepareStatement("update video set video_name=?,detail=?,date=? where code=?");
                                    ps.setString(1,video_name);
                                    ps.setString(2,detail);
                                    ps.setString(3,date);
                                    ps.setString(4,vcode);
                                   
                                    if(ps.executeUpdate()>0){
                                        response.sendRedirect("video.jsp?ccode="+channel_code+"&vsuccess=1");
                                                
                                    }
                                    else{
                                       response.sendRedirect("video.jsp?ccode="+channel_code+"&again=1");
                                    }
                                    cn.close();

                                    //out.println(sn+" "+code+" "+channel_name+" "+detail+" "+email+" "+date);

                                    }
                                    catch(Exception ec){
                                        out.println(ec.getMessage());
                                    } 
                         }
                    }
                }
                catch(NullPointerException e){
                   // response.sendRedirect("dashboard.jsp");
                    out.println(e.getMessage());
                }
            }
%>
