package adminControl;

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

@WebServlet("/OverviewStatsServlet")
public class OverviewStatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DBconnector.getConnection()) {
            int totalBookings = getCount(conn, "SELECT COUNT(*) FROM userBooking");
            int totalUsers = getCount(conn, "SELECT COUNT(*) FROM users");
            int totalPlans = getCount(conn, "SELECT COUNT(*) FROM user_plans");
            int totalPlanners = getCount(conn, "SELECT COUNT(*) FROM eventPlanner");

            // Manually construct valid JSON
            String json = "{"
                + "\"totalBookings\":" + totalBookings + ","
                + "\"totalUsers\":" + totalUsers + ","
                + "\"totalPlans\":" + totalPlans + ","
                + "\"totalPlanners\":" + totalPlanners
                + "}";

            response.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
            String errorJson = "{\"error\":\"Database error: " + e.getMessage().replace("\"", "\\\"") + "\"}";
            response.getWriter().write(errorJson);
        }
    }

    private int getCount(Connection conn, String query) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}