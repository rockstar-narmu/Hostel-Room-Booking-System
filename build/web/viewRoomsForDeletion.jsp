<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Room</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .container { max-width: 800px; margin: 50px auto; padding: 20px; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 10px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
        .delete-button { background-color: #dc3545; color: white; padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; }
        .delete-button:hover { opacity: 0.8; }
        .back-button { margin-top: 20px; background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; text-decoration: none; display: inline-block; }
        .back-button:hover { opacity: 0.8; }
    </style>
</head>
<body>

<div class="container">
    <h1>Delete Room</h1>
    <table>
        <tr>
            <th>Room ID</th>
            <th>Room Number</th>
            <th>Room Type</th>
            <th>Price per Night</th>
            <th>Is Available</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Room");

                while (rs.next()) {
                    int roomId = rs.getInt("room_id");
                    String roomNumber = rs.getString("room_number");
                    String roomType = rs.getString("room_type");
                    double price = rs.getDouble("price_per_night");
                    boolean isAvailable = rs.getBoolean("is_available");

                    // Display room details with a delete button
        %>
                    <tr>
                        <td><%= roomId %></td>
                        <td><%= roomNumber %></td>
                        <td><%= roomType %></td>
                        <td><%= price %></td>
                        <td><%= isAvailable ? "Yes" : "No" %></td>
                        <td>
                            <form action="confirmRoomDeletion.jsp" method="get">
                                <input type="hidden" name="roomId" value="<%= roomId %>">
                                <button type="submit" class="delete-button">Delete</button>
                            </form>
                        </td>
                    </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>

    <!-- Back to Dashboard button -->
    <a href="adminDashboard.jsp" class="back-button">Back to Dashboard</a>
</div>

</body>
</html>
