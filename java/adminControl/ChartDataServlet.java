package adminControl;

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
import com.google.gson.Gson;

@WebServlet("/ChartDataServlet")
public class ChartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            con = DBconnector.getConnection();

            // Fetch event types for pie chart
            List<String> eventLabels = new ArrayList<>();
            List<Integer> eventCounts = new ArrayList<>();
            String eventSql = "SELECT type_name, event_count FROM event_types ORDER BY type_name";
            ps = con.prepareStatement(eventSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                eventLabels.add(rs.getString("type_name"));
                eventCounts.add(rs.getInt("event_count"));
            }
            jsonResponse.put("eventLabels", eventLabels);
            jsonResponse.put("eventCounts", eventCounts);

            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}

            // Fetch monthly revenue for bar chart (year 2025)
            List<String> revenueLabels = new ArrayList<>();
            List<Double> revenues = new ArrayList<>();
            String revenueSql = "SELECT month_name, revenue FROM monthly_revenue WHERE year = ? " +
                               "ORDER BY FIELD(month_name, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')";
            ps = con.prepareStatement(revenueSql);
            ps.setInt(1, 2025);
            rs = ps.executeQuery();
            while (rs.next()) {
                revenueLabels.add(rs.getString("month_name"));
                revenues.add(rs.getDouble("revenue"));
            }
            jsonResponse.put("revenueLabels", revenueLabels);
            jsonResponse.put("revenues", revenues);

            // Set response
            response.setContentType("application/json");
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(jsonResponse));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to fetch chart data: " + e.getMessage() + "\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}