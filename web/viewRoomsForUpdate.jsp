<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Rooms</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9; margin: 0; padding: 0; }
        .container { max-width: 1100px; margin: 40px auto; padding: 25px; background-color: #ffffff; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 10px; }
        h1 { text-align: center; color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px 15px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background-color: #007bff; color: #ffffff; font-size: 16px; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #eaeaea; }
        input[type="text"], select { padding: 8px 12px; width: 90%; border: 1px solid #ddd; border-radius: 4px; }
        .update-button, .reset-button { padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .update-button { background-color: #28a745; color: white; }
        .reset-button { background-color: #ffc107; color: white; }
        .update-button:hover, .reset-button:hover { opacity: 0.9; }
        .back-button { display: inline-block; padding: 10px 20px; background-color: #007bff; color: white; border-radius: 5px; text-align: center; font-weight: bold; text-decoration: none; }
        .back-button:hover { opacity: 0.9; }
        @media (max-width: 768px) {
            .container { padding: 15px; }
            th, td { padding: 10px; font-size: 14px; }
            input[type="text"], select { font-size: 14px; }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Update Rooms</h1>
    <table>
        <tr>
            <th>Room ID</th>
            <th>Room Number</th>
            <th>Room Type</th>
            <th>Price per Night</th>
            <th>Is Available</th>
            <th>Actions</th>
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
        %>
                    <form action="updateRoomAction.jsp" method="post">
                    <tr>
                        <td><%= roomId %></td>
                        <td><input type="text" name="roomNumber" value="<%= roomNumber %>"></td>
                        <td>
                            <select name="roomType">
                                <option value="Single" <%= roomType.equals("Single") ? "selected" : "" %>>Single</option>
                                <option value="Double" <%= roomType.equals("Double") ? "selected" : "" %>>Double</option>
                                <option value="Deluxe" <%= roomType.equals("Deluxe") ? "selected" : "" %>>Deluxe</option>
                                <option value="Family" <%= roomType.equals("Family") ? "selected" : "" %>>Family</option>
                                <option value="Suite" <%= roomType.equals("Suite") ? "selected" : "" %>>Suite</option>
                            </select>
                        </td>
                        <td><input type="text" name="price" value="<%= price %>"></td>
                        <td>
                            <select name="isAvailable">
                                <option value="true" <%= isAvailable ? "selected" : "" %>>Yes</option>
                                <option value="false" <%= !isAvailable ? "selected" : "" %>>No</option>
                            </select>
                        </td>
                        <td>
                            <input type="hidden" name="roomId" value="<%= roomId %>">
                            <button type="submit" class="update-button">Update</button>
                            <button type="reset" class="reset-button">Reset</button>
                        </td>
                    </tr>
                    </form>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <a href="adminDashboard.jsp" class="back-button">Back to Dashboard</a>
</div>

</body>
</html>
