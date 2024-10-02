<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Bookings</title>
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
        .back-button:active {
            background-color: #1e7e34;
        }
    </style>
</head>
<body>

<h1>All Bookings</h1>

<table>
    <thead>
        <tr>
            <th>Booking ID</th>
            <th>Guest Name</th>
            <th>Room Number</th>
            <th>Check-in Date</th>
            <th>Check-out Date</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Bookings");
                
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("booking_id") + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("room_number") + "</td>");
                    out.println("<td>" + rs.getDate("checkin_date") + "</td>");
                    out.println("<td>" + rs.getDate("checkout_date") + "</td>");
                    out.println("</tr>");
                }
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </tbody>
</table>

<!-- Attractive Back to Dashboard button -->
<a href="adminDashboard.jsp" class="back-button">Back to Dashboard</a>

</body>
</html>
