package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Hostel and Guest House Booking System</title>\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            background-color: #f4f4f4;\n");
      out.write("            display: flex;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            height: 100vh;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            width: 100%;\n");
      out.write("            max-width: 600px;\n");
      out.write("            margin: 0 auto;\n");
      out.write("            background-color: #fff;\n");
      out.write("            padding: 20px;\n");
      out.write("            box-shadow: 0 0 10px rgba(0,0,0,0.1);\n");
      out.write("        }\n");
      out.write("        h2 {\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("        form {\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("        label {\n");
      out.write("            display: block;\n");
      out.write("            margin: 10px 0 5px;\n");
      out.write("        }\n");
      out.write("        input[type=\"text\"], input[type=\"password\"], select {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 10px;\n");
      out.write("            margin-bottom: 10px;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            border-radius: 5px;\n");
      out.write("        }\n");
      out.write("        input[type=\"submit\"] {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 10px;\n");
      out.write("            background-color: #28a745;\n");
      out.write("            border: none;\n");
      out.write("            color: #fff;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            cursor: pointer;\n");
      out.write("        }\n");
      out.write("        input[type=\"submit\"]:hover {\n");
      out.write("            background-color: #218838;\n");
      out.write("        }\n");
      out.write("        .toggle-login {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-top: 20px;\n");
      out.write("        }\n");
      out.write("        .toggle-login a {\n");
      out.write("            color: #007bff;\n");
      out.write("            text-decoration: none;\n");
      out.write("        }\n");
      out.write("        .toggle-login a:hover {\n");
      out.write("            text-decoration: underline;\n");
      out.write("        }\n");
      out.write("        .hidden {\n");
      out.write("            display: none;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("    <script>\n");
      out.write("        function toggleLoginFields() {\n");
      out.write("            const userType = document.getElementById(\"user-type\").value;\n");
      out.write("            const guestFields = document.getElementById(\"guest-fields\");\n");
      out.write("            const adminFields = document.getElementById(\"admin-fields\");\n");
      out.write("\n");
      out.write("            if (userType === \"guest\") {\n");
      out.write("                guestFields.classList.remove(\"hidden\");\n");
      out.write("                adminFields.classList.add(\"hidden\");\n");
      out.write("            } else if (userType === \"admin\") {\n");
      out.write("                guestFields.classList.add(\"hidden\");\n");
      out.write("                adminFields.classList.remove(\"hidden\");\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        function prepareForm() {\n");
      out.write("            const userType = document.getElementById(\"user-type\").value;\n");
      out.write("\n");
      out.write("            if (userType === \"guest\") {\n");
      out.write("                // Rename guest fields for form submission\n");
      out.write("                document.getElementById(\"guest-username\").name = \"username\";\n");
      out.write("                document.getElementById(\"guest-password\").name = \"password\";\n");
      out.write("                // Ensure admin fields are not submitted\n");
      out.write("                document.getElementById(\"admin-username\").name = \"\";\n");
      out.write("                document.getElementById(\"admin-password\").name = \"\";\n");
      out.write("            } else if (userType === \"admin\") {\n");
      out.write("                // Rename admin fields for form submission\n");
      out.write("                document.getElementById(\"admin-username\").name = \"username\";\n");
      out.write("                document.getElementById(\"admin-password\").name = \"password\";\n");
      out.write("                // Ensure guest fields are not submitted\n");
      out.write("                document.getElementById(\"guest-username\").name = \"\";\n");
      out.write("                document.getElementById(\"guest-password\").name = \"\";\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        // Ensure fields are properly shown/hidden on page load\n");
      out.write("        window.onload = function() {\n");
      out.write("            toggleLoginFields();\n");
      out.write("        };\n");
      out.write("    </script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>Hostel Room Booking System</h2>\n");
      out.write("\n");
      out.write("    <!-- User Login Form -->\n");
      out.write("    <form action=\"login.jsp\" method=\"post\" onsubmit=\"prepareForm()\">\n");
      out.write("        <h3>Select Login Type</h3>\n");
      out.write("        <label for=\"user-type\">Choose User Type:</label>\n");
      out.write("        <select id=\"user-type\" name=\"user-type\" onchange=\"toggleLoginFields()\" required>\n");
      out.write("            <option value=\"\" disabled selected>Select your option</option>\n");
      out.write("            <option value=\"guest\">Guest</option>\n");
      out.write("            <option value=\"admin\">Admin</option>\n");
      out.write("        </select>\n");
      out.write("        \n");
      out.write("        <!-- Admin Login Fields -->\n");
      out.write("        <div id=\"admin-fields\" class=\"hidden\">\n");
      out.write("            <h3>Admin Login</h3>\n");
      out.write("            <label for=\"admin-username\">Admin Username:</label>\n");
      out.write("            <input type=\"text\" id=\"admin-username\" placeholder=\"Enter admin username\">\n");
      out.write("            \n");
      out.write("            <label for=\"admin-password\">Admin Password:</label>\n");
      out.write("            <input type=\"password\" id=\"admin-password\" placeholder=\"Enter admin password\">\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Guest Login Fields -->\n");
      out.write("        <div id=\"guest-fields\" class=\"hidden\">\n");
      out.write("            <h3>Guest Login</h3>\n");
      out.write("            <label for=\"guest-username\">Username:</label>\n");
      out.write("            <input type=\"text\" id=\"guest-username\" placeholder=\"Enter your username\">\n");
      out.write("            \n");
      out.write("            <label for=\"guest-password\">Password:</label>\n");
      out.write("            <input type=\"password\" id=\"guest-password\" placeholder=\"Enter your password\">\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <input type=\"submit\" value=\"Login\">\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    <!-- Registration Link for Guests -->\n");
      out.write("    <div class=\"toggle-login\">\n");
      out.write("        <p>Don't have an account? <a href=\"register.jsp\">Register as Guest</a></p>\n");
      out.write("    </div>\n");
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
