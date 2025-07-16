package EventPackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ValidateLoginServlet")
public class ValidateLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
            return;
        }

        List<User> userDetails = CustomerController.validate(username, password);

        if (!userDetails.isEmpty()) {
            // Login successful, redirect to customizeUI.jsp
            response.sendRedirect("customizeUI.jsp");
        } else {
            // Login failed, forward back to customizeLogin.jsp with error
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
        }
    }
}