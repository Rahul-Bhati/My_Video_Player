<%-- 
    Document   : logout
    Created on : 26 Feb, 2022, 9:12:23 AM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie c = new Cookie("user","");
    c.setMaxAge(0);
    response.addCookie(c);
    response.sendRedirect("index.jsp");
%>
