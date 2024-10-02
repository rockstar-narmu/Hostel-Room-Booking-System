<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            width: 100%;
            max-width: 500px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007b77;
            color: #fff;
        }
        td {
            background-color: #007b66;
            color: #fff;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="date"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 96%;
        }
        .button {
            background-color: #28a745;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #218838;
        }
        .back-button {
            background-color: #6c757d;
            color: #fff;
            text-decoration: none;
            padding: 10px;
            border-radius: 5px;
            display: inline-block;
            text-align: center;
            width: 96%;
            margin-top: 15px;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #5a6268;
        }
        .error-message {
            color: red;
            text-align: center;
            margin: 15px 0;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Book Room</h2>
    <%
        // Get logged-in username from session
        String username = (String) session.getAttribute("username");
        
        // Check if the user is logged in
        if (username == null) {
            response.sendRedirect("index.jsp"); // Redirect to login page if not logged in
            return;
        }

        String roomId = request.getParameter("room_id");

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

            // Retrieve the details of the selected room
            String sql = "SELECT * FROM room WHERE room_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, roomId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String roomType = rs.getString("room_type");
                double price = rs.getDouble("price_per_night");
                String availability = rs.getString("is_available");

                // Check room availability
                if ("false".equals(availability)) {
    %>
                    <!-- Display an error message if the room is not available -->
                    <div class="error-message">This room is already booked and is not available for booking.</div>
    <%
                } else {
    %>
                    <!-- Display room details if available -->
                    <table>
                        <tr>
                            <th>Room Number</th>
                            <td><%= roomId %></td>
                        </tr>
                        <tr>
                            <th>Room Type</th>
                            <td><%= roomType %></td>
                        </tr>
                        <tr>
                            <th>Price per Night</th>
                            <td>$<%= price %></td>
                        </tr>
                        <tr>
                            <th>Availability</th>
                            <td>Available</td>
                        </tr>
                    </table>

                    <!-- Booking Form -->
                    <form action="confirmBooking.jsp" method="post">
                        <input type="hidden" name="room_id" value="<%= roomId %>">
                        <input type="hidden" name="username" value="<%= username %>"> <!-- Add hidden field for username -->
                        <label for="checkin">Check-in Date:</label>
                        <input type="date" id="checkin" name="checkin" required>
                        
                        <label for="checkout">Check-out Date:</label>
                        <input type="date" id="checkout" name="checkout" required>

                        <input type="submit" value="Confirm Booking" class="button">
                    </form>
    <%
                }
            } else {
                out.println("<p>Room details not found.</p>");
            }
        } catch (Exception e) {
            out.println("<p>An error occurred: " + e.getMessage() + "</p>");
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
    
    <!-- Back to Available Rooms Button -->
    <a href="viewAvailableRooms.jsp" class="back-button">Back to Available Rooms</a>
</div>

</body>
</html>
