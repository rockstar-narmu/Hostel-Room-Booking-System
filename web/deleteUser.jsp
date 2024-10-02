<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h3 {
            font-size: 18px;
            color: #28a745;
        }

        .error-message {
            font-size: 18px;
            color: #dc3545;
        }

        /* Back to User List Button */
        a.back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }

        a.back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
<%
    String userId = request.getParameter("userId");
    if (userId != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
            PreparedStatement ps = con.prepareStatement("DELETE FROM Users WHERE user_id = ?");
            ps.setInt(1, Integer.parseInt(userId));
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<h3>User deleted successfully.</h3>");
            } else {
                out.println("<h3 class='error-message'>Error: User could not be deleted.</h3>");
            }
            con.close();
        } catch (Exception e) {
            out.println("<h3 class='error-message'>Error: " + e.getMessage() + "</h3>");
        }
    } else {
        out.println("<h3 class='error-message'>No user ID provided.</h3>");
    }
%>
    <a href="viewUsers.jsp" class="back-button">Back to User List</a>
</div>

</body>
</html>
