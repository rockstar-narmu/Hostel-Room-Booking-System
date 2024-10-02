<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .delete-button {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .delete-button:hover {
            background-color: #c82333;
        }
        .back-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h1>User List</h1>

<table>
    <thead>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            // Fetch all users from the database
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT user_id, username FROM Users");

                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    out.println("<tr>");
                    out.println("<td>" + userId + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td><form action='confirmDeleteUser.jsp' method='post'><input type='hidden' name='userId' value='" + userId + "' /><button type='submit' class='delete-button'>Delete</button></form></td>");
                    out.println("</tr>");
                }
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </tbody>
</table>

<!-- Back to Dashboard and Add User buttons -->
<a href="adminDashboard.jsp" class="back-button">Back to Dashboard</a>

</body>
</html>
