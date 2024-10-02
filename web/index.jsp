<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hostel and Guest House Booking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="password"] {
            width: 97%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .toggle-login {
            text-align: center;
            margin-top: 20px;
        }
        .toggle-login a {
            color: #007bff;
            text-decoration: none;
        }
        .toggle-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Hostel Room Booking System</h2>

    <!-- User Login Form -->
    <form action="guestLogin.jsp" method="post">
        <h3>Guest Login</h3>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
        
        <input type="submit" value="Login as Guest">
    </form>

    <!-- Admin Login Form -->
    <form action="adminLogin.jsp" method="post">
        <h3>Admin Login</h3>
        <label for="admin-username">Admin Username:</label>
        <input type="text" id="admin-username" name="username" placeholder="Enter admin username" required>
        
        <label for="admin-password">Admin Password:</label>
        <input type="password" id="admin-password" name="password" placeholder="Enter admin password" required>
        
        <input type="submit" value="Login as Admin">
    </form>

    <!-- Registration Link for Guests -->
    <div class="toggle-login">
        <p>Don't have an account? <a href="register.jsp">Register as Guest</a></p>
    </div>
</div>

</body>
</html>