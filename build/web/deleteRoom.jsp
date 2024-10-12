<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Room</title>
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
        h3 { 
            color: #333; 
            font-size: 22px; 
            margin-bottom: 20px;
        }
        .message { 
            font-size: 18px; 
            color: #666; 
            margin-bottom: 20px;
        }
        .back-button { 
            padding: 12px 30px; 
            font-size: 16px; 
            color: white; 
            background-color: #007bff; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
            text-decoration: none; 
            transition: background-color 0.3s;
        }
        .back-button:hover { 
            background-color: #0056b3; 
        }
        .container.success { 
            border-left: 5px solid #28a745; 
        }
        .container.error { 
            border-left: 5px solid #dc3545; 
        }
    </style>
</head>
<body>

<div class="container">
    <%
        // Initialize the rowsAffected variable at the start
        int rowsAffected = 0;
        String roomId = request.getParameter("roomId");
        
        if (roomId != null) {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
                PreparedStatement ps = con.prepareStatement("DELETE FROM Room WHERE room_id = ?");
                ps.setInt(1, Integer.parseInt(roomId));

                rowsAffected = ps.executeUpdate(); // Assign the result to rowsAffected
                if (rowsAffected > 0) {
                    out.println("<h3>Room deleted successfully.</h3>");
                } else {
                    out.println("<h3>Error: Room could not be deleted.</h3>");
                }
                con.close();
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        } else {
            out.println("<h3>No room ID provided.</h3>");
        }
    %>
    <a href="viewRoomsForDeletion.jsp" class="back-button">Back to Room List</a>
</div>

</body>
</html>
