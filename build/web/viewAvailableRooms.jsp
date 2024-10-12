<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Available Rooms</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            text-align: center;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            font-size: 14px;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .view-button {
            background-color: #17a2b8; /* Light blue for View Details */
        }
        .view-button:hover {
            background-color: #138496; /* Darker shade on hover */
        }
        .book-button {
            background-color: #28a745; /* Green for Book Room */
        }
        .book-button:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .book-button:disabled {
            background-color: #6c757d; /* Gray color for disabled button */
            cursor: not-allowed;       /* Change cursor for disabled button */
        }
        .back-button {
            background-color: #6c757d; /* Gray for Back button */
            margin-top: 30px;
        }
        .back-button:hover {
            background-color: #5a6268; /* Darker gray on hover */
        }
        .back-container {
            margin: 20px auto;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Available Rooms</h2>

    <table>
        <thead>
            <tr>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Price per Night</th>
                <th>Availability</th>
                <th>Action</th> <!-- Action Column -->
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection setup
                String dbURL = "jdbc:derby://localhost:1527/user"; // Adjust the DB URL if necessary
                String dbUser = "narmu"; // Database user
                String dbPass = "1234";   // Database password

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    stmt = conn.createStatement();

                    String sql = "SELECT * FROM room"; // Query to fetch available rooms
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String roomNumber = rs.getString("room_number");
                        String roomType = rs.getString("room_type");
                        double price = rs.getDouble("price_per_night");
                        String availability = rs.getString("is_available");

                        // Generate table rows dynamically based on room data
                        %>
                        <tr>
                            <td><%= roomNumber %></td>
                            <td><%= roomType %></td>
                            <td>₹<%= price %></td>
                            <td><%= availability.equals("true") ? "Available" : "Booked" %></td>
                            <td>
                                <!-- View Details Button -->
                                <a href="viewRoomDetails.jsp?room_id=<%= roomNumber %>" class="button view-button">View Details</a>
                                
                                <!-- Book Room Button -->
                                <!-- Book Room Button, disabled if the room is booked -->
                                <% if (availability.equals("false")) { %>
                                    <button class="button book-button" disabled>Book Room</button>
                                <% } else { %>
                                    <a href="bookRoom.jsp?room_id=<%= roomNumber %>" class="button book-button">Book Room</a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    out.println("An error occurred: " + e.getMessage());
                    e.printStackTrace();
                } finally {
                    // Close resources in reverse order
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>

    <!-- Back to Dashboard Button -->
    <div class="back-container">
        <a href="welcome.jsp" class="button back-button">Back to Dashboard</a>
    </div>
</body>
</html>
