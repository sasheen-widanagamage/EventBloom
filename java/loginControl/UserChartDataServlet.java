package loginControl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;
import adminControl.DBconnector;

@WebServlet("/UserChartDataServlet")
public class UserChartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Map<String, Object> jsonResponse = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            if (username == null) {
                jsonResponse.put("error", "User not logged in");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                sendJsonResponse(response, jsonResponse);
                return;
            }

            // Get user ID from username
            con = DBconnector.getConnection();
            String userSql = "SELECT id FROM users WHERE username = ?";
            ps = con.prepareStatement(userSql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (!rs.next()) {
                jsonResponse.put("error", "User not found");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                sendJsonResponse(response, jsonResponse);
                return;
            }
            int userId = rs.getInt("id");

            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}

            // Fetch booking data for 2025
            List<String> labels = new ArrayList<>();
            List<Integer> bookingCounts = new ArrayList<>();
            String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
            String sql = "SELECT month_name, booking_count FROM user_bookings WHERE user_id = ? AND year = ? " +
                         "ORDER BY FIELD(month_name, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')";
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, 2025);
            rs = ps.executeQuery();

            // Initialize counts for all months
            int[] counts = new int[12];
            while (rs.next()) {
                String month = rs.getString("month_name");
                int count = rs.getInt("booking_count");
                for (int i = 0; i < months.length; i++) {
                    if (months[i].equals(month)) {
                        counts[i] = count;
                        break;
                    }
                }
            }

            // Populate labels and counts
            for (String month : months) {
                labels.add(month);
            }
            for (int count : counts) {
                bookingCounts.add(count);
            }

            jsonResponse.put("labels", labels);
            jsonResponse.put("bookingCounts", bookingCounts);

            // Fetch statistics
            int totalBookings = UserDBUtil.getTotalBookings(userId);
            double engagementRate = UserDBUtil.getEngagementRate(userId, 2025);
            int activePlans = UserDBUtil.getActivePlans(userId);

            jsonResponse.put("totalBookings", totalBookings);
            jsonResponse.put("engagementRate", Math.round(engagementRate * 10) / 10.0); // Round to 1 decimal
            jsonResponse.put("activePlans", activePlans);

            // Set response
            sendJsonResponse(response, jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("error", "Failed to fetch chart data: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            sendJsonResponse(response, jsonResponse);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> jsonResponse) throws IOException {
        response.setContentType("application/json");
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(jsonResponse));
    }
}