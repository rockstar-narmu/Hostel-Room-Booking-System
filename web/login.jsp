<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Hostel and Guest House Booking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        .message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login Status</h2>

    <%
        // Database connection details
        String dbURL = "jdbc:derby://localhost:1527/user"; // adjust based on your setup
        String dbUser = "narmu"; // update with your DB username
        String dbPass = "1234";  // update with your DB password
        String userType = request.getParameter("user-type");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String query = "";
        boolean isValidUser = false;

        try {
            // Load the JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish the connection
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement stmt;

            // Query based on user type
            if ("guest".equals(userType)) {
                query = "SELECT * FROM Users WHERE username = ? AND password = ?";
            }  else {
                query = "SELECT * FROM ADMINS WHERE username = ? AND password = ?";
            }

            // Prepare and execute the query
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            // Check if the user exists
            if (rs.next()) {
                isValidUser = true;
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Handle login result
        if (isValidUser) {
            // Redirect to appropriate dashboard based on user type
            if ("guest".equals(userType)) {
                session.setAttribute("username", username);
                response.sendRedirect("welcome.jsp");
            } else if ("admin".equals(userType)) {
                session.setAttribute("adminUsername", username);
                response.sendRedirect("adminDashboard.jsp");
            }
        } else {
            // Display error message if login fails
            out.println("<div class='message'>Invalid username or password. Please try again.</div>");
            out.println("<a href='index.jsp'>Go back to login</a>");
        }
    %>
</div>
</body>
</html>
