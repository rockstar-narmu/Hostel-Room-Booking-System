<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guest Login</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database connection setup
    String dbURL = "jdbc:derby://localhost:1527/user"; // Adjust the DB URL if necessary
    String dbUser = "narmu"; // Database user
    String dbPass = "1234";   // Database password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Using a PreparedStatement for better security
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Successful login
            session.setAttribute("username", username); // Store username in session
            response.sendRedirect("welcome.jsp");
        } else {
            // Login failed
            out.println("Invalid username or password.");
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // Close resources in reverse order
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
