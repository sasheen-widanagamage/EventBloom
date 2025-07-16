package loginControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String membership = request.getParameter("membership");

        // Validate input parameters
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username cannot be empty.");
            RequestDispatcher dis = request.getRequestDispatcher("userEdit.jsp");
            dis.forward(request, response);
            return;
        }

        try {
            boolean isTrue = UserDBUtil.updateUser(username, password, email, address, dob, gender, membership);

            if (isTrue) {
                // Fetch updated user details
                List<User> uDEtails = UserDBUtil.getUserDetails(username);
                if (uDEtails.isEmpty()) {
                    request.setAttribute("errorMessage", "Failed to retrieve updated user details.");
                    RequestDispatcher dis = request.getRequestDispatcher("userEdit.jsp");
                    dis.forward(request, response);
                    return;
                }

                // Update session with new user details
                HttpSession session = request.getSession();
                session.setAttribute("userDetails", uDEtails);
                session.setAttribute("username", username);

                // Set request attribute for immediate display
                request.setAttribute("uDEtails", uDEtails);
                System.out.println("User " + username + " updated successfully. Session updated with: " + uDEtails);
                RequestDispatcher dis = request.getRequestDispatcher("userProfile.jsp");
                dis.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                RequestDispatcher dis = request.getRequestDispatcher("userEdit.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the profile.");
            RequestDispatcher dis = request.getRequestDispatcher("userEdit.jsp");
            dis.forward(request, response);
        }
    }
}