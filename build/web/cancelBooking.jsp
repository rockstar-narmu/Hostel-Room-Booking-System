<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
    String roomNumber = request.getParameter("roomNumber");
    String message;
    String messageType;

    // Database connection setup
    String dbURL = "jdbc:derby://localhost:1527/user";
    String dbUser = "narmu";
    String dbPass = "1234";

    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        conn.setAutoCommit(false);

        String deleteBookingSQL = "DELETE FROM bookings WHERE booking_id = ?";
        pstmt1 = conn.prepareStatement(deleteBookingSQL);
        pstmt1.setInt(1, bookingId);
        int rowsDeleted = pstmt1.executeUpdate();

        String updateRoomSQL = "UPDATE room SET is_available = 'true' WHERE room_number = ?";
        pstmt2 = conn.prepareStatement(updateRoomSQL);
        pstmt2.setString(1, roomNumber);
        int rowsUpdated = pstmt2.executeUpdate();

        if (rowsDeleted > 0 && rowsUpdated > 0) {
            conn.commit();
            message = "Booking successfully cancelled and room marked as available.";
            messageType = "success";
        } else {
            conn.rollback();
            message = "Failed to cancel booking. Please try again.";
            messageType = "error";
        }

    } catch (Exception e) {
        message = "An error occurred: " + e.getMessage();
        messageType = "error";
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    } finally {
        try {
            if (pstmt1 != null) pstmt1.close();
            if (pstmt2 != null) pstmt2.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Redirect to the result page with the message and type
    response.sendRedirect("cancelBookingResult.jsp?message=" + message + "&type=" + messageType);
%>
