<%-- 
    Document   : remove_history
    Created on : 22 Mar, 2022, 11:32:07 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
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
                if(request.getParameter("vcode")==null){
                    //response.sendRedirect("index.jsp");
                    out.print("index");
                }
                else{
                    String video_code = request.getParameter("vcode");
                    try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                            Statement st = cn.createStatement();
                            PreparedStatement ps = cn.prepareStatement("delete from history where video_code=?");
                            ps.setString(1, video_code);
                            if(ps.executeUpdate()>0){
                                out.print("success");
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
   catch(NullPointerException ec){
       out.println(ec.getMessage());
   }
%>



