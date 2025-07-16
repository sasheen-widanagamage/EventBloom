package EventPackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT id, username, email, address, dob, gender, membership, password, remember FROM users WHERE username = ?";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, storedPassword)) {
                    // Login successful
                    User user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getDate("dob"),
                        rs.getString("gender"),
                        rs.getString("membership"),
                        storedPassword,
                        rs.getBoolean("remember")
                    );
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    response.sendRedirect("customizeUI.jsp");
                } else {
                    // Invalid password
                    request.setAttribute("error", "Invalid username or password.");
                    request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
                }
            } else {
                // User not found
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("customizeLogin.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        
	}

}
