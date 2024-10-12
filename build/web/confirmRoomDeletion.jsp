<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Delete Room</title>
    <style>
        body { 
            font-family: 'Arial', sans-serif; 
            background-color: #f4f4f4; 
            margin: 0; 
            padding: 0;
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh;
        }
        .container { 
            max-width: 600px; 
            padding: 30px; 
            background-color: #fff; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); 
            border-radius: 10px; 
            text-align: center;
        }
        h1 { 
            font-size: 24px; 
            margin-bottom: 20px; 
            color: #333;
        }
        p { 
            font-size: 16px; 
            color: #666;
        }
        ul { 
            list-style: none; 
            padding: 0; 
            text-align: left;
        }
        ul li { 
            margin: 10px 0; 
            font-size: 16px; 
            color: #333;
        }
        ul li strong { 
            font-weight: bold;
        }
        .confirm-button, .cancel-button { 
            padding: 12px 30px; 
            font-size: 16px; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
            margin: 20px 10px 0;
            transition: background-color 0.3s;
        }
        .confirm-button { 
            background-color: #28a745;
        }
        .confirm-button:hover { 
            background-color: #218838;
        }
        .cancel-button { 
            background-color: #007bff; 
            text-decoration: none;
        }
        .cancel-button:hover { 
            background-color: #0056b3;
        }
        form { 
            display: inline-block; 
            margin: 0;
        }
        a { 
            text-decoration: none; 
            color: white; 
            padding: 12px 30px; 
            font-size: 16px; 
            border-radius: 5px; 
            display: inline-block;
            background-color: #007bff;
            transition: background-color 0.3s;
        }
        a:hover { 
            background-color: #0056b3; 
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Confirm Room Deletion</h1>
    <%
        String roomId = request.getParameter("roomId");
        if (roomId != null) {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM Room WHERE room_id = ?");
                ps.setInt(1, Integer.parseInt(roomId));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String roomNumber = rs.getString("room_number");
                    String roomType = rs.getString("room_type");
                    double price = rs.getDouble("price_per_night");
                    boolean isAvailable = rs.getBoolean("is_available");
    %>
                    <p>Are you sure you want to delete the following room?</p>
                    <ul>
                        <li><strong>Room ID:</strong> <%= roomId %></li>
                        <li><strong>Room Number:</strong> <%= roomNumber %></li>
                        <li><strong>Room Type:</strong> <%= roomType %></li>
                        <li><strong>Price per Night:</strong> <%= price %></li>
                        <li><strong>Is Available:</strong> <%= isAvailable ? "Yes" : "No" %></li>
                    </ul>
                    <form action="deleteRoom.jsp" method="post">
                        <input type="hidden" name="roomId" value="<%= roomId %>">
                        <button type="submit" class="confirm-button">Yes</button>
                    </form>
                    <a href="viewRoomsForDeletion.jsp" class="cancel-button">No</a>
    <%
                } else {
                    out.println("<p>Room not found.</p>");
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            out.println("<p>No room ID provided.</p>");
        }
    %>
</div>

</body>
</html>
