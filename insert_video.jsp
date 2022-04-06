<%-- 
    Document   : insert_video
    Created on : 26 Feb, 2022, 10:56:28 AM
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
                response.sendRedirect("index.jsp");
            }
            else{  
                try{
                    if(request.getParameter("ccode")==null){
                        response.sendRedirect("dashboard.jsp?video_code_error=1");
                    }
                    else{
                        String channel_code = request.getParameter("ccode");
                        if(request.getParameter("video_name").length()==0 || request.getParameter("detail").length()==0 ){
                            response.sendRedirect("video.jsp?ccode="+channel_code+"&empty=1");
                        }
                        else{
                                int sn = 0;
                                String code = "";
                                String video_name = request.getParameter("video_name");
                                String detail = request.getParameter("detail");
                                

                                LinkedList l = new LinkedList();
                                for(char ch='A' ; ch<='Z' ; ch++){
                                    l.add(ch+"");
                                }
                                for(char ch='a' ; ch<='z' ; ch++){
                                    l.add(ch+"");
                                }
                                for(char ch='0' ; ch<='9' ; ch++){
                                    l.add(ch+"");
                                }
                                Collections.shuffle(l);
                                for(int i=0 ; i<6 ; i++){
                                    code = code+l.get(i);
                                }
                                try{
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                                    Statement st = cn.createStatement();
                                    ResultSet rs = st.executeQuery("select MAX(sn) from video");
                                    if(rs.next()){
                                         sn = rs.getInt(1);   
                                    }
                                    sn = sn + 1 ;
                                    code = code+"_"+sn;
                                    Date dt = new Date();
                                    String date = dt.toString(); 
                                    
                                    String status = "0" ;
                                    
                                    PreparedStatement ps = cn.prepareStatement("insert into video values(?,?,?,?,?,?,?,?)");
                                    ps.setInt(1,sn);
                                    ps.setString(2,code);
                                    ps.setString(3,video_name);
                                    ps.setString(4,detail);
                                    ps.setString(5,email);
                                    ps.setString(6,date);
                                    ps.setString(7,channel_code);
                                    ps.setString(8,status);
                                    if(ps.executeUpdate()>0){
                                        response.sendRedirect("video_image.jsp?vcode="+code+"&ccode="+channel_code+"&success=1");
                                                
                                    }
                                    else{
                                       response.sendRedirect("video.jsp?ccode="+channel_code+"&again=1");
                                    }
                                    cn.close();

                                    //out.println(sn+" "+code+" "+channel_name+" "+detail+" "+email+" "+date);

                                    }
                                    catch(Exception ec){
                                        out.println(ec.getMessage());
                                    } 
                         }
                    }
                }
                catch(NullPointerException e){
                    //response.sendRedirect("video.jsp");
                    out.println(e.getMessage());
                }
            }
%>

