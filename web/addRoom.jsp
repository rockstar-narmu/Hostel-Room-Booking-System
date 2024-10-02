<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h1 {
            text-align: center;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="number"], input[type="submit"], select {
            width: 97%;
            padding: 10px;
            margin: 5px 0 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        /* Style for the dropdown */
        select {
            width: 100%;
            background-color: #fff;
            appearance: none; /* Remove default arrow */
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="gray" d="M7 10l5 5 5-5H7z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px;
        }
        .back-button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Add Room</h1>
    <form action="addRoom.jsp" method="post">
        <label for="roomId">Room ID:</label>
        <input type="number" id="roomId" name="room_id" required>

        <label for="roomNumber">Room Number:</label>
        <input type="text" id="roomNumber" name="room_number" required>

        <label for="roomType">Room Type:</label>
        <input type="text" id="roomType" name="room_type" required>

        <label for="pricePerNight">Price per Night:</label>
        <input type="number" id="pricePerNight" name="price_per_night" required>

        <label for="isAvailable">Is Available:</label>
        <select id="isAvailable" name="is_available" required>
            <option value="true">Yes</option>
            <option value="false">No</option>
        </select>

        <input type="submit" value="Add Room">
    </form>

    <%
        // Process form submission
        String roomId = request.getParameter("room_id");
        String roomNumber = request.getParameter("room_number");
        String roomType = request.getParameter("room_type");
        String pricePerNight = request.getParameter("price_per_night");
        String isAvailable = request.getParameter("is_available");

        if (roomId != null && roomNumber != null && roomType != null && pricePerNight != null && isAvailable != null) {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                PreparedStatement ps = con.prepareStatement("INSERT INTO Room (room_id, room_number, room_type, price_per_night, is_available) VALUES (?, ?, ?, ?, ?)");
                ps.setInt(1, Integer.parseInt(roomId));
                ps.setString(2, roomNumber);
                ps.setString(3, roomType);
                ps.setDouble(4, Double.parseDouble(pricePerNight));
                ps.setBoolean(5, Boolean.parseBoolean(isAvailable));

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<h3>Room added successfully!</h3>");
                } else {
                    out.println("<h3>Error: Room could not be added.</h3>");
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
    %>

    <a href="adminDashboard.jsp" class="back-button">Back to Dashboard</a>
</div>

</body>
</html>
