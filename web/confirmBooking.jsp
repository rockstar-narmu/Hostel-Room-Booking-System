<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            width: 60%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h2 {
            color: #333;
        }
        .message {
            margin: 20px 0;
            font-size: 18px;
            color: #28a745;
        }
        .details {
            margin: 20px 0;
            font-size: 16px;
            color: #333;
            background-color: #e9f5e9;
            padding: 15px;
            border: 1px solid #d1e7d1;
            border-radius: 5px;
        }
        .details p {
            margin: 10px 0;
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
        .dashboard-button {
            background-color: #007bff; /* Blue */
        }
        .dashboard-button:hover {
            background-color: #0056b3; /* Darker Blue */
        }
        .view-bookings-button {
            background-color: #28a745; /* Green */
        }
        .view-bookings-button:hover {
            background-color: #218838; /* Darker Green */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Confirmation</h2>
        <%
            // Database connection setup
            String dbURL = "jdbc:derby://localhost:1527/user"; // Adjust the DB URL if necessary
            String dbUser = "narmu"; // Database user
            String dbPass = "1234";   // Database password

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            // Retrieve booking details from form submission
            String roomId = request.getParameter("room_id");
            String username = request.getParameter("username");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");

            // Variable to hold the price per night
            double pricePerNight = 0.0; // This will be fetched from the database

            // Calculate total nights and total price
            long totalNights = 0;
            double totalPrice = 0;

            try {
                // Parse check-in and check-out dates
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date checkinDate = sdf.parse(checkin);
                Date checkoutDate = sdf.parse(checkout);

                // Calculate difference in days
                long diffInMillies = checkoutDate.getTime() - checkinDate.getTime();
                totalNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);

                // Establish database connection
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                // Query to get the price per night for the selected room
                String priceQuery = "SELECT price_per_night FROM room WHERE room_number = ?";
                pstmt = conn.prepareStatement(priceQuery);
                pstmt.setString(1, roomId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    pricePerNight = rs.getDouble("price_per_night");
                }

                // Calculate total price
                totalPrice = totalNights * pricePerNight;

                // Use the correct column names in the query for bookings
                String sql = "INSERT INTO bookings (username, room_number, checkin_date, checkout_date) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, roomId);
                pstmt.setString(3, checkin);
                pstmt.setString(4, checkout);

                int rowsInserted = pstmt.executeUpdate();

                if (rowsInserted > 0) {
                    // Update room availability in room table
                    String updateRoomSQL = "UPDATE room SET is_available = 'false' WHERE room_number = ?";
                    pstmt = conn.prepareStatement(updateRoomSQL);
                    pstmt.setString(1, roomId);
                    pstmt.executeUpdate();

                    // Booking confirmation message
                    out.println("<p class='message'>Room booked successfully! Your booking is confirmed.</p>");
                    // Display booking details
                    out.println("<div class='details'>");
                    out.println("<h3>Booking Details</h3>");
                    out.println("<p><strong>Room ID:</strong> " + roomId + "</p>");
                    out.println("<p><strong>Username:</strong> " + username + "</p>");
                    out.println("<p><strong>Check-in Date:</strong> " + checkin + "</p>");
                    out.println("<p><strong>Check-out Date:</strong> " + checkout + "</p>");
                    out.println("<p><strong>Total Nights:</strong> " + totalNights + "</p>");
                    out.println("<p><strong>Price Per Night:</strong> $" + pricePerNight + "</p>");
                    out.println("<p><strong>Total Price:</strong> $" + totalPrice + "</p>");
                    out.println("</div>");
                } else {
                    out.println("<p class='message'>An error occurred. Please try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p>An error occurred: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        <!-- Button to go back to Dashboard -->
        <a href="welcome.jsp" class="button dashboard-button">Back to Dashboard</a>
        
        <!-- Button to view bookings -->
        <a href="viewMyBookings.jsp" class="button view-bookings-button">View My Bookings</a>
    </div>
</body>
</html>
