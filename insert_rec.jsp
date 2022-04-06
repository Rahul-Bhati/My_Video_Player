<%-- 
    Document   : insert_rec
    Created on : 26 Feb, 2022, 8:43:45 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*;" pageEncoding="UTF-8"%>
<%
    if(request.getParameter("username").length()==0 || request.getParameter("email").length()==0 || request.getParameter("pass").length()==0 || 
       request.getParameter("phone").length()==0 || request.getParameter("dob").length()==0 || request.getParameter("gender").length()==0 || request.getParameter("country").length()==0)
    {
        response.sendRedirect("register.jsp?empty=1");
    }
    else
    {
        int sn = 0;
        String code = "";
        String rusername = request.getParameter("username");
        String remail = request.getParameter("email");
        String rpass = request.getParameter("pass");
        String rphone = request.getParameter("phone");
        String rdob = request.getParameter("dob");
        String rgender = request.getParameter("gender");
        String rcountry = request.getParameter("country");
        
        //out.println(rusername+" "+remail+" "+rpass+" "+rphone+" "+rgender+" "+rcountry);
        
        LinkedList l = new LinkedList();
        for(char c='A';c<='Z';c++){
            l.add(c+"");
        }
        for(char c='a';c<='z';c++){
            l.add(c+"");
        }
        for(char c='0';c<='9';c++){
            l.add(c+"");
        }
        Collections.shuffle(l);
        for(int i=0;i<6;i++){
            code = code+l.get(i);
        }
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select MAX(sn) from user");
            if(rs.next()){
                 sn = rs.getInt(1);   
            }
            sn = sn + 1 ;
            code = code+"_"+sn;
                     
            PreparedStatement ps = cn.prepareStatement("insert into user values(?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,sn);
            ps.setString(2,code);
            ps.setString(3,rusername);
            ps.setString(4,remail);
            ps.setString(5,rpass);
            ps.setString(6,rphone);
            ps.setString(7,rdob);
            ps.setString(8,rgender);
            ps.setString(9,rcountry);
            if(ps.executeUpdate()>0){
                response.sendRedirect("profile_img.jsp?code="+code+"&success=1");
            }
            else{
                response.sendRedirect("register.jsp?again=1");
            }
            cn.close();
                    
            //out.println(sn+" "+code+" "+rusername+" "+remail+" "+rpass+" "+rphone+" "+rgender+" "+rdob+" "+rcountry);
                
        }
        catch(ClassNotFoundException e){
        	System.out.println("Driver : "+ e.getMessage());
	}
	catch(SQLException ec){
		System.out.println("SQL : "+ec.getMessage());
	} 
    }
%>
