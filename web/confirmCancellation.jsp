<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Cancellation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
        .room-details {
            margin-bottom: 20px;
            text-align: center;
        }
        .confirm-button {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            align-items: center;
            justify-content: center;
            margin: 5px;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }
        .cancel-button {
            background-color: #228B22;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            align-items: center;
            justify-content: center;
            margin: 5px;
            transition: background-color 0.3s ease;
        }
        .confirm-button:hover{
            background-color: #FF4433;
        }
        .cancel-button {
            background-color: #228B22;
        }
        .cancel-button:hover {
            background-color: #00A36C;
        }
        .confirm-button i, .cancel-button i {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Confirm Cancellation</h2>
    <%
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String roomNumber = request.getParameter("roomNumber");
    %>
    <div class='room-details'>
        <p><strong>Booking ID:</strong> <%= bookingId %></p>
        <p><strong>Room Number:</strong> <%= roomNumber %></p>
    </div>
    <p>Are you sure you want to cancel this booking?</p>
    <form action="cancelBooking.jsp" method="post">
        <input type="hidden" name="bookingId" value="<%= bookingId %>">
        <input type="hidden" name="roomNumber" value="<%= roomNumber %>">
        <button type="submit" class="confirm-button"><i class="fas fa-check"></i> Yes, Cancel</button>
    </form>
    <a href="viewMyBookings.jsp" class="cancel-button"><i class="fas fa-times"></i> No, Go Back</a>
</div>

</body>
</html>
