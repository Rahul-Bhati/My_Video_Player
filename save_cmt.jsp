<%-- 
    Document   : save_cmt
    Created on : 20 Apr, 2022, 7:40:13 PM
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
                out.print("index");
            }
            else{ 
                if(request.getParameter("code")==null || request.getParameter("val")==null){
                    out.print("code_error");
                }
                else{
                    String cmt_code = request.getParameter("code") ;
                    String cmt = request.getParameter("val") ;
                    Date dt = new Date();
                    String date = dt.toString();
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                        PreparedStatement ps = cn.prepareStatement("update comment set comment=?,date=? where code=?");
                        ps.setString(1,cmt);
                        ps.setString(2,date);
                        ps.setString(3,cmt_code);
                        if(ps.executeUpdate()>0){
                            out.print("success");
                        }
                    }
                    catch(Exception ec){
                        out.println(ec.getMessage());
                    }
                }
            }
%>
