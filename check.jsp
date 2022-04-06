<%-- 
    Document   : check
    Created on : 26 Feb, 2022, 8:58:25 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if(request.getParameter("email").length()==0 || request.getParameter("pass").length()==0 ){
        response.sendRedirect("index.jsp?log_empty=1");
    }
    else{
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from user where email='"+email+"'");
                if(rs.next()){
                    if(pass.equals(rs.getString("pass"))){
                        Cookie c = new Cookie("user",email);
                        c.setMaxAge(3600);
                        response.addCookie(c);
                        response.sendRedirect("dashboard.jsp");
                    }
                    else{
                        response.sendRedirect("index.jsp?pass_invalid=1");
                    }
                }
                else{
                    response.sendRedirect("index.jsp?email_invalid=1");
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
%>

