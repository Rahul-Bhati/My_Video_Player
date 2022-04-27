<%-- 
    Document   : load_rand_video
    Created on : 23 Apr, 2022, 7:38:33 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
    if(request.getParameter("vcode")!=null){
        String vcode = request.getParameter("vcode");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            Statement st6 = cn.createStatement();
            ResultSet rs6 = st6.executeQuery("select * from video where code<>'"+vcode+"' order by rand() limit 0,7 ");
            while(rs6.next()){
                String channel_code2 = rs6.getString("channel_code");
                Statement st7 = cn.createStatement();
                ResultSet rs7 = st7.executeQuery("select * from channel where code='"+channel_code2+"' AND status='0'");
                if(rs7.next()){
            %>
            <a href="video-page.jsp?vcode=<%=rs6.getString("code")%>" class="small-thumbnail"><img src="channel_Video/<%=rs6.getString("code")%>.jpg" class="img-fluid rounded"></a>
            <div class="vid-info">
                <a href="video-page.jsp?vcode=<%=rs6.getString("code")%>"><%=rs6.getString("video_name")%></a>
                <p class="subscribe" style="cursor:pointer;" id='<%=rs7.getString("code")%>'><%=rs7.getString("channel_name")%></p>
                <%
                    int sub_count1 = 0;
                    Statement st16 = cn.createStatement();
                    ResultSet rs16 = st16.executeQuery("select count(*) from subscribe where channel_code='"+channel_code2+"'");
                    if(rs16.next()){
                        sub_count1 = Integer.parseInt(rs16.getString("count(*)"));
                    }
                %>
               <p><%=sub_count1%> Subscribers</p>
            </div>
            <%
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
    
%>