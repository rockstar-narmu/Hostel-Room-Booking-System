<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Delete User</title>
    <style>
        /* General Styles */
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

        h1 {
            color: #dc3545;
        }

        p {
            color: #333;
            font-size: 16px;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin-bottom: 20px;
        }

        ul li {
            margin: 5px 0;
            font-size: 15px;
            font-weight: bold;
        }

        /* Button Styles */
        .confirm-button, .cancel-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .confirm-button {
            background-color: #dc3545;
            color: white;
            margin-right: 10px;
        }

        .cancel-button {
            background-color: #007bff;
            color: white;
        }

        .confirm-button:hover, .cancel-button:hover {
            opacity: 0.9;
        }

        .button-group {
            display: flex;
            justify-content: center;
        }

        .back-link {
            margin-top: 15px;
            display: block;
            text-decoration: none;
            font-size: 14px;
            color: #007bff;
        }

        .back-link:hover {
            text-decoration: underline;
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
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Users WHERE user_id = ?");
            ps.setInt(1, Integer.parseInt(userId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
%>
                <h1>Confirm Deletion</h1>
                <p>Are you sure you want to delete the following user?</p>
                <ul>
                    <li>User ID: <%= rs.getInt("user_id") %></li>
                    <li>Username: <%= rs.getString("username") %></li>
                </ul>

                <div class="button-group">
                    <form action="deleteUser.jsp" method="post">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="confirm-button">Yes, Delete</button>
                    </form>
                    <a href="viewUsers.jsp" class="cancel-button">No, Cancel</a>
                </div>

<%
            } else {
                out.println("<p>User not found.</p>");
            }
            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>No user ID provided.</p>");
    }
%>
</div>

</body>
</html>
