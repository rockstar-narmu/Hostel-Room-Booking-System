<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    boolean loginSuccessful = false;
    
    try {
        // Load the Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Connect to the Derby database using your credentials
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");

        // Prepare the SQL query to verify admin credentials
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM Admins WHERE username = ? AND password = ?");
        stmt.setString(1, username);
        stmt.setString(2, password);

        // Execute the query
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            loginSuccessful = true;
            session.setAttribute("adminUsername", username);  // Store admin's username in session
        }

        con.close();  // Close the connection
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
    
    // If login is successful, redirect to the admin dashboard
    if (loginSuccessful) {
        response.sendRedirect("adminDashboard.jsp");  // Redirect to the admin dashboard
    } else {
        // Display an error message if login fails
        out.println("<p>Invalid username or password. Please try again.</p>");
        out.println("<a href='index.jsp'>Back to login</a>");
    }
%>

</body>
</html>
