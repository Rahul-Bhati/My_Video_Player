<%-- 
    Document   : delete_channel
    Created on : 26 Feb, 2022, 2:08:27 PM
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
                    response.sendRedirect("dashboard.jsp?delete_code_error=1");
                }
                else{
                    String channel_code = request.getParameter("ccode") ;
                    String status = "1";
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        PreparedStatement ps = cn.prepareStatement("update channel set status=? where code=?");
                        ps.setString(1,status);
                        ps.setString(2,channel_code);
                        if(ps.executeUpdate()>0){
                            PreparedStatement ps1 = cn.prepareStatement("update video set status=? where channel_code=?");
                            ps1.setString(1,status);
                            ps1.setString(2,channel_code);
                            if(ps1.executeUpdate()>0){
                                response.sendRedirect("dashboard.jsp?delete_success=1");
                            }
                        }
                        else{
                            response.sendRedirect("dashboard.jsp?delete_again=1");
                        }
                    }
                    catch(Exception ec){
                        out.println(ec.getMessage());
                    }
                }
            }
%>