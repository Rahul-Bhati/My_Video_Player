<%-- 
    Document   : subscribe
    Created on : 9 Mar, 2022, 1:49:54 PM
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
                        ResultSet rs = st.executeQuery("select * from subscribe where channel_code='"+channel_code+"' AND email='"+email+"'");
                        if(rs.next()){
                            PreparedStatement ps = cn.prepareStatement("delete from subscribe where channel_code=? AND email=?");
                            ps.setString(1,channel_code);
                            ps.setString(2,email);
                            if(ps.executeUpdate()>0){
                                out.print("Subscribe");
                            }
                        }
                        else{
                            PreparedStatement ps = cn.prepareStatement("insert into subscribe values(?,?)");
                            ps.setString(1,channel_code);
                            ps.setString(2,email);
                            if(ps.executeUpdate()>0){
                                out.print("Subscribed");
                            }
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
         out.println(er.getMessage());
    }
                
%>
