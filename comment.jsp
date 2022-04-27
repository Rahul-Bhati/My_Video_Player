<%-- 
    Document   : comment
    Created on : 10 Mar, 2022, 11:12:30 AM
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
                if(request.getParameter("vcode").length()==0 || request.getParameter("cmt").length()==0 || request.getParameter("femail").length()==0){
                    //response.sendRedirect("index.jsp");
                    out.print("index");
                }
                else{
                    String from_name = "";
                    String video_code = request.getParameter("vcode");
                    String to_email = request.getParameter("femail");
                    String comment = request.getParameter("cmt");
                      int sn = 0;
                        String code = "";
                         LinkedList l = new LinkedList();
                        for(char ch='A';ch<='Z';ch++){
                            l.add(ch+"");
                        }
                        for(char ch='a';ch<='z';ch++){
                            l.add(ch+"");
                        }
                        for(char ch='0';ch<='9';ch++){
                            l.add(ch+"");
                        }
                        Collections.shuffle(l);
                        for(int i=0;i<6;i++){
                            code = code+l.get(i);
                        }

                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                            Statement st = cn.createStatement();
                            ResultSet rs = st.executeQuery("select MAX(sn) from comment");
                            if(rs.next()){
                                 sn = rs.getInt(1);   
                            }
                            sn = sn + 1 ;
                            code = code+"_"+sn;
                            Date dt = new Date();
                            String date = dt.toString();
                            ResultSet rs1 = st.executeQuery("select * from user where email='"+email+"'");
                            if(rs1.next()){
                                 from_name = rs1.getString("username");   
                            }
                            //out.print(sn+" "+code+" "+from_name+" "+email+" "+comment+" "+to_email+" "+video_code);
                            PreparedStatement ps = cn.prepareStatement("insert into comment values(?,?,?,?,?,?,?,?)");
                            ps.setInt(1,sn);
                            ps.setString(2,code);
                            ps.setString(3,from_name);
                            ps.setString(4,email);
                            ps.setString(5,comment);
                            ps.setString(6,to_email);
                            ps.setString(7,video_code);
                            ps.setString(8,date);

                            if(ps.executeUpdate()>0){
                                %>
                                <div class="col-sm-12" id="d-<%=code%>">
                                    <div class="row">
                                        <div class="col-sm-1">
                                            <img src="profile/<%=rs1.getString("code")%>.jpg" alt="profileImg" style="width: 35px;height: 35px;border-radius: 50%;margin-right: 15px;">
                                        </div>
                                        <div class="col-sm-11">
                                            <h3><%=from_name%> <span><%=date%></span></h3>
                                            <p id="e-<%=code%>"><%=comment%></p>
                                            <div class="comment-action">
                                                <i class='bx bxs-like' pid="like" id="like-<%=code%>" rel="<%=code%>"></i><span id="likecount-<%=code%>">0</span>     
                                                <i class='bx bxs-dislike' pid="dislike" id="dislike-<%=code%>" rel="<%=code%>"></i><span id="dislikecount-<%=code%>">0</span>
                                                <i class='bx bxs-edit' style="color: blue" id="<%=code%>"></i> &nbsp;&nbsp;&nbsp;&nbsp;
                                                <i class='bx bxs-message-square-x' rel="<%=code%>" style="color: red"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
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
