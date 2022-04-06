<%-- 
    Document   : update_channel
    Created on : 26 Feb, 2022, 11:00:25 AM
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
                if(request.getParameter("ccode")==null){
                    response.sendRedirect("dashboard.jsp?code_error=1");
                }
                else{
                    String code = request.getParameter("ccode");
                    try{
                        if(request.getParameter("channel_name").length()==0 || request.getParameter("category").length()==0 || request.getParameter("detail").length()==0 ){
                            response.sendRedirect("edit_channel.jsp?empty=1");
                        }
                        else{
                            String channel_name = request.getParameter("channel_name");
                            String detail = request.getParameter("detail");
                            String category = request.getParameter("category");
                            try{
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                               
                                Date dt = new Date();
                                String date = dt.toString(); 
                                String status = "0";
                                PreparedStatement ps = cn.prepareStatement("update channel set channel_name=?,detail=?,category=?,date=? where code=?");
                                ps.setString(1,channel_name);
                                ps.setString(2,detail);
                                ps.setString(3,category);
                                ps.setString(4,date);
                                ps.setString(5,code);
                                
                                if(ps.executeUpdate()>0){
                                    response.sendRedirect("dashboard.jsp?cedit_success=1");
                                }
                                else{
                                   response.sendRedirect("edit_channel.jsp?ccode="+code+"&again=1");
                                }
                                cn.close();

                                //out.println(sn+" "+code+" "+channel_name+" "+detail+" "+email+" "+date);

                                }
                                catch(Exception ec){
                                    out.println(ec.getMessage());
                                } 
                           } 
                    }
                    catch(NullPointerException e){
                        response.sendRedirect("dashboard.jsp");
                        //out.println(e.getMessage());
                    }
                }
            }
%>


