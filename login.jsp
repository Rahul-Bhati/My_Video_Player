<%-- 
    Document   : login
    Created on : 25 Feb, 2022, 5:13:46 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
	if(request.getParameter("text")!=null){
		%>
		<div class="title">Login</div>
		<div class="content">
			<form action="check.jsp" method="post">
				<div class="user-details">
                                    <div class="input-box">
                                            <span class="details">Email</span>
                                            <input type="text" name="email" placeholder="Enter your email" required>
                                    </div>
                                    <div class="input-box">
                                            <span class="details">Password</span>
                                            <input type="password" name="pass" placeholder="Enter your password" required>
                                    </div>
                                    <div class="button">
                                            <input type="submit" class="btn btn-info" value="Login">
                                    </div>
                                </div>
			</form>
		</div>
		<%
	}

        %>
