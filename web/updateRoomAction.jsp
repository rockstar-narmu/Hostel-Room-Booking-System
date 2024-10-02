<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Update</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h3 {
            color: #28a745;
        }
        h3.error {
            color: #dc3545;
        }
        p {
            color: #333;
            font-size: 16px;
            margin: 10px 0;
        }
        pre {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            padding: 15px;
            overflow-x: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
            border-radius: 5px;
        }
        .back-button {
            display: inline-block;
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
        .message {
            padding: 15px;
            border: 1px solid transparent;
            border-radius: 4px;
            margin-top: 15px;
        }
        .message.success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .message.error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>

<div class="container">
    <%
        String roomId = request.getParameter("roomId");
        String roomNumber = request.getParameter("roomNumber");
        String roomType = request.getParameter("roomType");
        String priceStr = request.getParameter("price");
        String isAvailableStr = request.getParameter("isAvailable");

        // Debugging: Print the parameters to ensure they are being received
        out.println("<p>roomId: " + roomId + "</p>");
        out.println("<p>roomNumber: " + roomNumber + "</p>");
        out.println("<p>roomType: " + roomType + "</p>");
        out.println("<p>price: " + priceStr + "</p>");
        out.println("<p>isAvailable: " + isAvailableStr + "</p>");

        if (roomId != null && roomNumber != null && roomType != null && priceStr != null && isAvailableStr != null) {
            try {
                double price = Double.parseDouble(priceStr);
                boolean isAvailable = Boolean.parseBoolean(isAvailableStr);

                // Load JDBC driver and establish connection
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");

                // Prepare SQL update statement
                String query = "UPDATE Room SET room_number = ?, room_type = ?, price_per_night = ?, is_available = ? WHERE room_id = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, roomNumber);
                ps.setString(2, roomType);
                ps.setDouble(3, price);
                ps.setBoolean(4, isAvailable);
                ps.setInt(5, Integer.parseInt(roomId));

                // Execute update and check if any rows were affected
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<div class='message success'><h3>Room updated successfully.</h3></div>");
                } else {
                    out.println("<div class='message error'><h3>Error: Room could not be updated. No rows affected.</h3></div>");
                }

                con.close();
            } catch (Exception e) {
                // Catch and display full stack trace using StringWriter
                java.io.StringWriter sw = new java.io.StringWriter();
                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                e.printStackTrace(pw);
                out.println("<pre>" + sw.toString() + "</pre>");
            }
        } else {
            out.println("<div class='message error'><h3>Invalid data provided.</h3></div>");
        }
    %>
    <a href="viewRoomsForUpdate.jsp" class="back-button">Back to Room List</a>
</div>

</body>
</html>
