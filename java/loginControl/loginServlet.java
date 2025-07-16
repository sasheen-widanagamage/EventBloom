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

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
            return;
        }

        try {
            List<User> uDEtails = UserDBUtil.validate(username, password);
            if (uDEtails.isEmpty()) {
                request.setAttribute("errorMessage", "Invalid username or password.");
                RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
                dis.forward(request, response);
            } else {
                // Store user details in session
                HttpSession session = request.getSession();
                session.setAttribute("userDetails", uDEtails);
                session.setAttribute("username", username);
                request.setAttribute("uDEtails", uDEtails);
                System.out.println("User " + username + " logged in. Session initialized with: " + uDEtails);
                RequestDispatcher dis = request.getRequestDispatcher("userProfile.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            String username = (String) session.getAttribute("username");
            List<User> uDEtails = (List<User>) session.getAttribute("userDetails");

            // If session data is missing or empty, fetch from database
            if (uDEtails == null || uDEtails.isEmpty()) {
                uDEtails = UserDBUtil.getUserDetails(username);
                session.setAttribute("userDetails", uDEtails);
            }

            // If user details are still empty, redirect to login
            if (uDEtails == null || uDEtails.isEmpty()) {
                System.out.println("No user details found for " + username + ". Redirecting to login.");
                response.sendRedirect("login.jsp");
                return;
            }

            request.setAttribute("uDEtails", uDEtails);
            System.out.println("User " + username + " accessed profile via GET. Displaying: " + uDEtails);
            RequestDispatcher dis = request.getRequestDispatcher("userProfile.jsp");
            dis.forward(request, response);
        } else {
            System.out.println("No active session. Redirecting to login.");
            response.sendRedirect("login.jsp");
        }
    }
}