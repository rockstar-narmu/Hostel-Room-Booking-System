<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Cancellation Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 100%;
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
        }
        .success {
            color: #28a745; /* Green for success messages */
            border: 1px solid #c3e6cb; /* Light green border */
            background-color: #d4edda; /* Light green background */
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .error {
            color: #dc3545; /* Red for error messages */
            border: 1px solid #f5c6cb; /* Light red border */
            background-color: #f8d7da; /* Light red background */
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        a {
            display: inline-block;
            background-color: #007bff;
            color: #fff;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Booking Cancellation Result</h1>
        <%
            String message = request.getParameter("message");
            String type = request.getParameter("type");
        %>
        <div class="<%= type %>">
            <%= message %>
        </div>

        <a href="viewMyBookings.jsp">Back to My Bookings</a>
    </div>
</body>
</html>
