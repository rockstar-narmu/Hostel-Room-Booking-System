package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class viewMyBookings_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>My Bookings</title>\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            background-color: #f4f4f4;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            min-height: 100vh;\n");
      out.write("            margin: 0;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            width: 100%;\n");
      out.write("            max-width: 800px;\n");
      out.write("            background-color: #fff;\n");
      out.write("            padding: 20px;\n");
      out.write("            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n");
      out.write("            border-radius: 10px;\n");
      out.write("        }\n");
      out.write("        h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            color: #333;\n");
      out.write("        }\n");
      out.write("        table {\n");
      out.write("            width: 100%;\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("            border-collapse: collapse;\n");
      out.write("        }\n");
      out.write("        th, td {\n");
      out.write("            padding: 10px;\n");
      out.write("            border-bottom: 1px solid #ddd;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("        th {\n");
      out.write("            background-color: #007b77;\n");
      out.write("            color: #fff;\n");
      out.write("        }\n");
      out.write("        td {\n");
      out.write("            background-color: #f9f9f9;\n");
      out.write("        }\n");
      out.write("        .back-button, .cancel-button {\n");
      out.write("            background-color: #007bff;\n");
      out.write("            color: #fff;\n");
      out.write("            text-decoration: none;\n");
      out.write("            padding: 10px 20px;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            display: inline-block;\n");
      out.write("            margin-top: 20px;\n");
      out.write("            transition: background-color 0.3s ease;\n");
      out.write("            border: none; /* Remove border */\n");
      out.write("            cursor: pointer; /* Change cursor to pointer */\n");
      out.write("        }\n");
      out.write("        .back-button:hover {\n");
      out.write("            background-color: #0056b3;\n");
      out.write("        }\n");
      out.write("        .cancel-button {\n");
      out.write("            background-color: #dc3545; /* Red color for Cancel button */\n");
      out.write("            margin: 0; /* Remove margin to fit in table cell */\n");
      out.write("            padding: 8px 15px; /* Slightly smaller padding */\n");
      out.write("        }\n");
      out.write("        .cancel-button:hover {\n");
      out.write("            background-color: #c82333; /* Darker red on hover */\n");
      out.write("        }\n");
      out.write("        form {\n");
      out.write("            margin: 0; /* Remove margin for forms */\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>My Bookings</h2>\n");
      out.write("    ");

        // Check if the user is logged in
        String username = (String) session.getAttribute("username");

        if (username == null) {
            // Redirect to login page if not logged in
            response.sendRedirect("index.jsp");
            return;
        }

        // Database connection setup
        String dbURL = "jdbc:derby://localhost:1527/user"; // Adjust the DB URL if necessary
        String dbUser = "narmu"; // Database user
        String dbPass = "1234";   // Database password

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Creating a scrollable and read-only result set
            pstmt = conn.prepareStatement(
                "SELECT b.booking_id, b.room_number, r.room_type, b.checkin_date, b.checkout_date, b.booking_date " +
                "FROM bookings b JOIN room r ON b.room_number = r.room_number " +
                "WHERE b.username = ?",
                ResultSet.TYPE_SCROLL_INSENSITIVE, 
                ResultSet.CONCUR_READ_ONLY
            );
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            // Check if the result set has any rows
            if (!rs.isBeforeFirst()) { // Moves cursor before the first row, returns false if the ResultSet is empty
                out.println("<p>No bookings found for you, " + username + ".</p>");
            } else {
                // Display the bookings in a table
    
      out.write("\n");
      out.write("                <table>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Booking ID</th>\n");
      out.write("                        <th>Room Number</th>\n");
      out.write("                        <th>Room Type</th>\n");
      out.write("                        <th>Check-in Date</th>\n");
      out.write("                        <th>Check-out Date</th>\n");
      out.write("                        <th>Booking Date</th>\n");
      out.write("                        <th>Action</th> <!-- Add a new column for the Cancel button -->\n");
      out.write("                    </tr>\n");
      out.write("    ");

                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String roomNumber = rs.getString("room_number");
                    String roomType = rs.getString("room_type");
                    Date checkinDate = rs.getDate("checkin_date");
                    Date checkoutDate = rs.getDate("checkout_date");
                    Timestamp bookingDate = rs.getTimestamp("booking_date");
    
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td>");
      out.print( bookingId );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print( roomNumber );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print( roomType );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print( checkinDate );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print( checkoutDate );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print( bookingDate );
      out.write("</td>\n");
      out.write("                        <td>\n");
      out.write("                            <form action=\"confirmCancellation.jsp\" method=\"post\" style=\"display:inline;\">\n");
      out.write("                                <input type=\"hidden\" name=\"bookingId\" value=\"");
      out.print( bookingId );
      out.write("\">\n");
      out.write("                                <input type=\"hidden\" name=\"roomNumber\" value=\"");
      out.print( roomNumber );
      out.write("\">\n");
      out.write("                                <input type=\"submit\" class=\"cancel-button\" value=\"Cancel Booking\"\">\n");
      out.write("                            </form>\n");
      out.write("                        </td>\n");
      out.write("                    </tr>\n");
      out.write("    ");

                }
    
      out.write("\n");
      out.write("                </table>\n");
      out.write("\n");
      out.write("    ");

            }
        } catch (Exception e) {
            out.println("<p>An error occurred while fetching your bookings: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    
      out.write("\n");
      out.write("\n");
      out.write("    <!-- Back to Dashboard Button -->\n");
      out.write("    <a href=\"welcome.jsp\" class=\"back-button\">Back to Dashboard</a>\n");
      out.write("    <!-- Download Report Button -->\n");
      out.write("    <a href=\"GenerateReportServlet\" class=\"back-button\" style=\"margin-top: 20px;\">Download Report</a>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
