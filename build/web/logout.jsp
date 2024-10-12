<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();
    // Redirect to the login page
    response.sendRedirect("index.jsp");
%>
