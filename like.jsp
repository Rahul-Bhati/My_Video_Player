<%-- 
    Document   : like
    Created on : 9 Mar, 2022, 9:19:53 AM
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
                if(request.getParameter("code")==null && request.getParameter("ptr")==null){
                    //response.sendRedirect("index.jsp");
                    out.print("index");
                }
                else{
                    String video_code = request.getParameter("code");
                    String ptr = request.getParameter("ptr");
                    String pattern = "";                     
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("select * from liked where video_code='"+video_code+"' AND email='"+email+"'");
                        if(rs.next()){
                            pattern = rs.getString("ptr");
                        }
                        if(ptr.equals(pattern)){
                            PreparedStatement ps = cn.prepareStatement("delete from liked where video_code=? AND email=?");
                            ps.setString(1,video_code);
                            ps.setString(2,email);
                            if(ps.executeUpdate()>0){
                                out.print("black");
                            }
                        }
                        else if(pattern.equals("dislike")){
                            PreparedStatement ps = cn.prepareStatement("update liked set ptr=? where video_code=? AND email=?");
                            ps.setString(1,"like");
                            ps.setString(2,video_code);
                            ps.setString(3,email);
                            if(ps.executeUpdate()>0){
                                out.print("blue");
                            }
                        }
                        else{
                            PreparedStatement ps = cn.prepareStatement("insert into liked values(?,?,?)");
                            ps.setString(1,video_code);
                            ps.setString(2,email);
                            ps.setString(3,"like");
                            if(ps.executeUpdate()>0){
                                out.print("blue");
                            }
                            else{
                                response.sendRedirect("index.jsp?again=1");
                            }
                        }
                        int like=0,dislike=0;
                        Statement st1 = cn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select count(*) from liked where video_code='"+video_code+"' AND ptr='like'");
                        if(rs1.next()){
                            like = Integer.parseInt(rs1.getString("count(*)"));
                            out.print("-"+like);
                        }
                        Statement st2 = cn.createStatement();
                        ResultSet rs2 = st2.executeQuery("select count(*) from liked where video_code='"+video_code+"' AND ptr='dislike'");
                        if(rs2.next()){
                            dislike = Integer.parseInt(rs2.getString("count(*)"));
                            out.print("-"+dislike);
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

