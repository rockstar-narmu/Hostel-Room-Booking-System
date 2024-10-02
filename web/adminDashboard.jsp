<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 10px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .dashboard-item {
            padding: 20px;
            background-color: #007bff;
            color: #fff;
            text-align: center;
            border-radius: 5px;
        }
        .dashboard-item a {
            color: #fff;
            text-decoration: none;
        }
        .actions {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
        }
        .actions a {
            background-color: #28a745;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .actions a:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Admin Dashboard</h1>
    
    <!-- Dashboard Grid for viewing stats -->
    <div class="dashboard-grid">
        <div class="dashboard-item">
    <h3><a href="viewBookings.jsp" style="color:white; text-decoration:none;">Total Bookings</a></h3>
    <p>
        <%
            // Fetch total bookings from the database
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Bookings");
                if (rs.next()) {
                    out.println(rs.getInt(1));
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </p>
</div>

        
        <div class="dashboard-item">
    <h3><a href="viewRooms.jsp" style="color:white; text-decoration:none;">Available Rooms</a></h3>
    <p>
        <%
            // Fetch total available rooms from the database
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Room WHERE is_available = 'true'");
                if (rs.next()) {
                    out.println(rs.getInt(1));
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </p>
</div>

        
        <div class="dashboard-item">
    <h3><a href="viewUsers.jsp" style="color:white; text-decoration:none;">Total Users</a></h3>
    <p>
        <%
            // Fetch total users from the database
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM Users");
                if (rs.next()) {
                    out.println(rs.getInt(1));
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </p>
</div>

    </div>

    <!-- Actions for Add/Update/Delete Room -->
    <div class="actions">
        <a href="addRoom.jsp">Add Room</a>
        <a href="viewRoomsForUpdate.jsp">Update Room</a>
        <a href="viewRoomsForDeletion.jsp">Delete Room</a>
        <a href="logout.jsp">Log out</a>
    </div>

</div>

</body>
</html>
