import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GenerateReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment;filename=bookings_report.csv");
        
        PrintWriter out = response.getWriter();

        // Database connection setup
        String dbURL = "jdbc:derby://localhost:1527/user";
        String dbUser = "narmu";
        String dbPass = "1234";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            // SQL query to get the bookings
            String sql = "SELECT b.booking_id, b.room_number, r.room_type, b.checkin_date, b.checkout_date, b.booking_date, b.username FROM bookings b JOIN room r ON b.room_number = r.room_number";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // Write the header row for CSV
            out.println("Booking ID,Room Number,Room Type,Check-in Date,Check-out Date,Booking Date,Username");

            // Iterate over the result set and write data to the CSV
            while (rs.next()) {
                int bookingId = rs.getInt("booking_id");
                String roomNumber = rs.getString("room_number");
                String roomType = rs.getString("room_type");
                String checkinDate = rs.getString("checkin_date");
                String checkoutDate = rs.getString("checkout_date");
                String bookingDate = rs.getString("booking_date");
                String username = rs.getString("username");

                // Write data row
                out.println(bookingId + "," + roomNumber + "," + roomType + "," + checkinDate + "," + checkoutDate + "," + bookingDate + "," + username);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
