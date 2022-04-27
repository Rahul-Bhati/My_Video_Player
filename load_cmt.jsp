<%-- 
    Document   : load_cmt
    Created on : 22 Apr, 2022, 11:36:57 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
    int flag = 0;
      String email = null;
      Cookie c[] = request.getCookies();
      for(int i=0;i<c.length;i++){
        if(c[i].getName().equals("user")){
            email = c[i].getValue();
            break;
        }
      }
      if(email!=null){
           flag = 1;
      }
      else{
           flag = 0;
      } 
    if(request.getParameter("id")!=null && request.getParameter("vcode")!=null){
        int id = Integer.parseInt(request.getParameter("id"));
        String vcode = request.getParameter("vcode");
        int start = id*1;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from comment where video_code='"+vcode+"' limit "+start+",1 ");
            while(rs.next()){
                String from_email = rs.getString("from_email");
                String cmt_code = rs.getString("code");
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from user where email='"+from_email+"'");
                if(rs1.next()){
                    //out.print(cmt_code+" "+from_email);
                    String ptrn = "";
                    int cmt_like=0,cmt_dislike=0;
                    Statement st21 = cn.createStatement();
                    ResultSet rs21 = st21.executeQuery("select * from cmt_liked where cmt_code='"+cmt_code+"' AND email='"+email+"'");
                    if(rs21.next()){
                        ptrn = rs21.getString("ptr");
                    }

                    Statement st22 = cn.createStatement();
                    ResultSet rs22 = st22.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='like'");
                    if(rs22.next()){
                        cmt_like = Integer.parseInt(rs22.getString("count(*)"));
                    }
                    Statement st23 = cn.createStatement();
                    ResultSet rs23 = st23.executeQuery("select count(*) from cmt_liked where cmt_code='"+cmt_code+"' AND ptr='dislike'");
                    if(rs23.next()){
                        cmt_dislike = Integer.parseInt(rs23.getString("count(*)"));
                    }  
                    if(from_email.equals(email)){
                                    %>
                                    <div class="col-sm-12" id="d-<%=rs.getString("code")%>">
                                        <div class="row">
                                            <div class="col-sm-1">
                                                <img src="profile/<%=rs1.getString("code")%>.jpg" alt="profileImg" style="width: 35px;height: 35px;border-radius: 50%;margin-right: 15px;">
                                            </div>
                                            <div class="col-sm-11">
                                                <h3><%=rs.getString("from_name")%> <span><%=rs.getString("date")%></span></h3>
                                                <p id="e-<%=rs.getString("code")%>"><%=rs.getString("comment")%></p>
                                                <div class="comment-action">
                                                    <i class='bx bxs-like' pid="like" id="like-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>"></i>&nbsp;&nbsp;<span id="likecount-<%=rs.getString("code")%>"><%=cmt_like%></span>     
                                                    <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>"></i>&nbsp;&nbsp;<span id="dislikecount-<%=rs.getString("code")%>"><%=cmt_dislike%></span>
                                                    <i class='bx bxs-edit' style="color: blue" id="<%=rs.getString("code")%>"></i> &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <i class='bx bxs-message-square-x' rel="<%=rs.getString("code")%>" style="color: red"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                 }
                                 else{
                      %>
                        
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                     <img src="profile/<%=rs1.getString("code")%>.jpg" alt="profileImg">
                                </div>
                                <div class="col-sm-11">
                                    <h3><%=rs.getString("from_name")%> <span><%=rs.getString("date")%></span></h3>
                                    <p>
                                        <%=rs.getString("comment")%>
                                    </p>
                                    <div class="comment-action">
                                        <i class='bx bxs-like' pid="like" id="like-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>"></i>&nbsp;&nbsp;<span id="likecount-<%=rs.getString("code")%>"><%=cmt_like%></span>     
                                        <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=rs.getString("code")%>" rel="<%=rs.getString("code")%>"></i>&nbsp;&nbsp;<span id="dislikecount-<%=rs.getString("code")%>"><%=cmt_dislike%></span>
                                        <span>REPLY</span>
                                        <a href="">All replies</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                             <%
                                 }
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