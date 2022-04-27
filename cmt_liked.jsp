<%-- 
    Document   : cmt_liked
    Created on : 21 Apr, 2022, 10:06:35 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
    String email = null;
    Cookie c[] = request.getCookies();
    for(int i=0;i<c.length;i++){
        if(c[i].getName().equals("user")){
            email = c[i].getValue();
            break;
        }
    }
    if(email!=null){
        if(request.getParameter("code")!=null && request.getParameter("pid")!=null){
            String cmt_code = request.getParameter("code") ;
            String ptr = request.getParameter("pid");
            String pattern = "";                     
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from cmt_liked where cmt_code='"+cmt_code+"' AND email='"+email+"'");
                if(rs.next()){
                    pattern = rs.getString("ptr");
                }
                if(ptr.equals(pattern)){
                    PreparedStatement ps = cn.prepareStatement("delete from cmt_liked where cmt_code=? AND email=?");
                    ps.setString(1,cmt_code);
                    ps.setString(2,email);
                    if(ps.executeUpdate()>0){
                        out.print("black");
                    }
                }
                else if(pattern.equals("dislike")){
                    PreparedStatement ps = cn.prepareStatement("update cmt_liked set ptr=? where cmt_code=? AND email=?");
                    ps.setString(1,"like");
                    ps.setString(2,cmt_code);
                    ps.setString(3,email);
                    if(ps.executeUpdate()>0){
                        out.print("blue");
                    }
                }
                else{
                    PreparedStatement ps = cn.prepareStatement("insert into cmt_liked values(?,?,?)");
                    ps.setString(1,cmt_code);
                    ps.setString(2,email);
                    ps.setString(3,"like");
                    if(ps.executeUpdate()>0){
                        out.print("blue");
                    }
                }
                int like=0,dislike=0;
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='like'");
                if(rs1.next()){
                    like = Integer.parseInt(rs1.getString("count(*)"));
                    out.print("-"+like);
                }
                Statement st2 = cn.createStatement();
                ResultSet rs2 = st2.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='dislike'");
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
    else{
        out.print("index");
    }
%>
