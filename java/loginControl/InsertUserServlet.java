package loginControl;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InsertUserServlet")
public class InsertUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String membership = request.getParameter("membership");
        boolean remember = request.getParameter("remember") != null;

        // Validate parameters
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            address == null || address.trim().isEmpty() ||
            dob == null || dob.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            membership == null || membership.trim().isEmpty()) {
            System.out.println("Invalid input: One or more fields are empty.");
            request.setAttribute("errorMessage", "All fields are required.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        System.out.println("Registering user: " + username + ", DOB: " + dob + ", Gender: " + gender + ", Membership: " + membership);

        // Call UserDBUtil.registerUser
        try {
            String result = UserDBUtil.registerUser(username, password, email, address, dob, gender, membership, remember);
            if (result.equals("success")) {
                request.setAttribute("successMessage", "Registration successful! Please log in.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("afterRegister.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errorMessage", result);
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed due to an unexpected error.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        }
    }
}