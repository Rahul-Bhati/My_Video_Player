<%-- 
    Document   : search
    Created on : 11 Mar, 2022, 8:54:04 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
    try{
        if(request.getParameter("sch")==null){
            //response.sendRedirect("index.jsp");
            out.print("index");
        }
        else{
            String search = request.getParameter("sch"); 
            String s[] = search.split(" ");
            String sql = "select * from video where video_name like '%"+search+"%' OR detail like '%"+search+"%'";
            for(int i=0;i<s.length;i++){
                sql = sql+"OR video_name like '%"+s[i]+"%' OR detail like '%"+s[i]+"%'";
            }
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                ResultSet rs1 = st.executeQuery(sql);
               %>
               <div class="row">
               <%
                while(rs1.next()){
                    %>
                    <div class="col-sm-3 video-block">
                                <table class="table table-borderless card w3-card" style="width:320px;">
                                    <tr>
                                        <td>
                                            <a href="video-page.jsp?vcode=<%=rs1.getString("code")%>" rel=""><img src="channel_Video/<%=rs1.getString("code")%>.jpg" style="width:300px;height: 200px;" class="img-fluid"></a>
                                        </td>
                                    </tr>
                                    <tr class="video-name">
                                        <td style=""><h3> <b><a href="video-page.jsp?vcode=<%=rs1.getString("code")%>" rel=""><%=rs1.getString("video_name")%></a></b> </h3>
                                             <%
                                                 String channel_code = rs1.getString("channel_code");
                                                 Statement st2 = cn.createStatement();
                                                 ResultSet rs2 = st2.executeQuery("select * from channel where code='"+channel_code+"'");
                                                 if(rs2.next()){
                                             %>
                                             <img src="channel_Image/<%=rs2.getString("code")%>.jpg" alt="">
                                             <span class="user">
                                                 <a class='channel' id="<%=rs2.getString("code")%>"><%=rs2.getString("channel_name")%></a>
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
                <%
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


