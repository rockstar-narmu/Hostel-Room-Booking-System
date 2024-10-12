import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GenerateRoomsReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set the response type to CSV
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment;filename=rooms_report.csv");

        // Initialize PrintWriter to write the CSV content
        PrintWriter out = response.getWriter();

        try {
            // Connect to the database
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/user", "narmu", "1234");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT room_id, room_number, room_type, price_per_night, is_available FROM Room");

            // Write CSV header
            out.println("Room ID,Room Number,Room Type,Price Per Night,Availability");

            // Loop through the result set and write each row to the CSV
            while (rs.next()) {
                int roomId = rs.getInt("room_id");
                String roomNumber = rs.getString("room_number");
                String roomType = rs.getString("room_type");
                double pricePerNight = rs.getDouble("price_per_night");
                String availability = rs.getBoolean("is_available") ? "Available" : "Booked";

                out.println(roomId + "," + roomNumber + "," + roomType + "," + pricePerNight + "," + availability);
            }

            // Close the database connection
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }
}
