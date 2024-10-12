<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
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
            max-width: 800px;
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
            text-align: center;
        }
        th {
            background-color: #007b77;
            color: #fff;
        }
        td {
            background-color: #f9f9f9;
        }
        .back-button, .cancel-button {
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
            transition: background-color 0.3s ease;
            border: none; /* Remove border */
            cursor: pointer; /* Change cursor to pointer */
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .cancel-button {
            background-color: #dc3545; /* Red color for Cancel button */
            margin: 0; /* Remove margin to fit in table cell */
            padding: 8px 15px; /* Slightly smaller padding */
        }
        .cancel-button:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        form {
            margin: 0; /* Remove margin for forms */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>My Bookings</h2>
    <%
        // Check if the user is logged in
        String username = (String) session.getAttribute("username");

        if (username == null) {
            // Redirect to login page if not logged in
            response.sendRedirect("index.jsp");
            return;
        }

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

            // Creating a scrollable and read-only result set
            pstmt = conn.prepareStatement(
                "SELECT b.booking_id, b.room_number, r.room_type, b.checkin_date, b.checkout_date, b.booking_date " +
                "FROM bookings b JOIN room r ON b.room_number = r.room_number " +
                "WHERE b.username = ?",
                ResultSet.TYPE_SCROLL_INSENSITIVE, 
                ResultSet.CONCUR_READ_ONLY
            );
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            // Check if the result set has any rows
            if (!rs.isBeforeFirst()) { // Moves cursor before the first row, returns false if the ResultSet is empty
                out.println("<p>No bookings found for you, " + username + ".</p>");
            } else {
                // Display the bookings in a table
    %>
                <table>
                    <tr>
                        <th>Booking ID</th>
                        <th>Room Number</th>
                        <th>Room Type</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Booking Date</th>
                        <th>Action</th> <!-- Add a new column for the Cancel button -->
                    </tr>
    <%
                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String roomNumber = rs.getString("room_number");
                    String roomType = rs.getString("room_type");
                    Date checkinDate = rs.getDate("checkin_date");
                    Date checkoutDate = rs.getDate("checkout_date");
                    Timestamp bookingDate = rs.getTimestamp("booking_date");
    %>
                    <tr>
                        <td><%= bookingId %></td>
                        <td><%= roomNumber %></td>
                        <td><%= roomType %></td>
                        <td><%= checkinDate %></td>
                        <td><%= checkoutDate %></td>
                        <td><%= bookingDate %></td>
                        <td>
                            <form action="confirmCancellation.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                                <input type="hidden" name="roomNumber" value="<%= roomNumber %>">
                                <input type="submit" class="cancel-button" value="Cancel Booking"">
                            </form>
                        </td>
                    </tr>
    <%
                }
    %>
                </table>

    <%
            }
        } catch (Exception e) {
            out.println("<p>An error occurred while fetching your bookings: " + e.getMessage() + "</p>");
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

    <!-- Back to Dashboard Button -->
    <a href="welcome.jsp" class="back-button">Back to Dashboard</a>
</div>

</body>
</html>
