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
        input[type="text"], input[type="password"], select {
            width: 100%;
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
        .hidden {
            display: none;
        }
    </style>
    <script>
        function toggleLoginFields() {
            const userType = document.getElementById("user-type").value;
            const guestFields = document.getElementById("guest-fields");
            const adminFields = document.getElementById("admin-fields");

            if (userType === "guest") {
                guestFields.classList.remove("hidden");
                adminFields.classList.add("hidden");
            } else if (userType === "admin") {
                guestFields.classList.add("hidden");
                adminFields.classList.remove("hidden");
            }
        }

        function prepareForm() {
            const userType = document.getElementById("user-type").value;

            if (userType === "guest") {
                // Rename guest fields for form submission
                document.getElementById("guest-username").name = "username";
                document.getElementById("guest-password").name = "password";
                // Ensure admin fields are not submitted
                document.getElementById("admin-username").name = "";
                document.getElementById("admin-password").name = "";
            } else if (userType === "admin") {
                // Rename admin fields for form submission
                document.getElementById("admin-username").name = "username";
                document.getElementById("admin-password").name = "password";
                // Ensure guest fields are not submitted
                document.getElementById("guest-username").name = "";
                document.getElementById("guest-password").name = "";
            }
        }

        // Ensure fields are properly shown/hidden on page load
        window.onload = function() {
            toggleLoginFields();
        };
    </script>
</head>
<body>

<div class="container">
    <h2>Hostel Room Booking System</h2>

    <!-- User Login Form -->
    <form action="login.jsp" method="post" onsubmit="prepareForm()">
        <h3>Select Login Type</h3>
        <label for="user-type">Choose User Type:</label>
        <select id="user-type" name="user-type" onchange="toggleLoginFields()" required>
            <option value="" disabled selected>Select your option</option>
            <option value="guest">Guest</option>
            <option value="admin">Admin</option>
        </select>
        
        <!-- Admin Login Fields -->
        <div id="admin-fields" class="hidden">
            <h3>Admin Login</h3>
            <label for="admin-username">Admin Username:</label>
            <input type="text" id="admin-username" placeholder="Enter admin username">
            
            <label for="admin-password">Admin Password:</label>
            <input type="password" id="admin-password" placeholder="Enter admin password">
        </div>

        <!-- Guest Login Fields -->
        <div id="guest-fields" class="hidden">
            <h3>Guest Login</h3>
            <label for="guest-username">Username:</label>
            <input type="text" id="guest-username" placeholder="Enter your username">
            
            <label for="guest-password">Password:</label>
            <input type="password" id="guest-password" placeholder="Enter your password">
        </div>

        <input type="submit" value="Login">
    </form>

    <!-- Registration Link for Guests -->
    <div class="toggle-login">
        <p>Don't have an account? <a href="register.jsp">Register as Guest</a></p>
    </div>
</div>

</body>
</html>
