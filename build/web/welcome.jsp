<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to the Booking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        a {
            display: inline-block;
            margin: 20px;
            padding: 15px 30px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
    // Retrieve the username from session
    String username = (String) session.getAttribute("username");

    // Check if the user is logged in
    if (username == null) {
        response.sendRedirect("index.jsp"); // Redirect to login page if not logged in
    }
%>

<h2>Welcome, <%= username %>!</h2>
<p>What would you like to do today?</p>

<!-- Links for user actions -->
<a href="viewAvailableRooms.jsp">View Available Rooms</a>
<a href="viewMyBookings.jsp">View My Bookings</a>
<a href="logout.jsp">Log Out</a>

</body>
</html>
