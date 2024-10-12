<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 100%;
            max-width: 500px;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-radius: 10px;
        }
        h2 {
            color: #28a745;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .icon-success {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="icon-success">&#10003;</div> <!-- Checkmark icon -->
    <h2>Registration Successful!</h2>
    <p>You have successfully registered as a guest. You can now log in using your credentials.</p>
    <a href="index.jsp" class="btn">Go to Login Page</a>
</div>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");

    // Database connection setup
    String dbURL = "jdbc:derby://localhost:1527/user"; // Adjust the DB URL if necessary
    String dbUser = "narmu"; // Database user
    String dbPass = "1234";   // Database password

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Check if the passwords match
        if (!password.equals(confirmPassword)) {
            out.println("<p>Passwords do not match. Please try again.</p>");
            return; // Stop further execution
        }

        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Check if username already exists
        String checkSql = "SELECT * FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            out.println("<p>Username already exists. Please choose a different username.</p>");
        } else {
            // Insert new user
            String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.executeUpdate();
        }
    } catch (Exception e) {
        out.println("<p>An error occurred: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
