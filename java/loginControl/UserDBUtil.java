package loginControl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UserDBUtil {
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;

    // Validate user
    public static List<User> validate(String username, String password) {
        ArrayList<User> userDetails = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("username");
                String email = rs.getString("email");
                String address = rs.getString("address");
                Date dob = rs.getDate("dob");
                String gender = rs.getString("gender");
                String membership = rs.getString("membership");
                String passU = rs.getString("password");
                boolean remember = rs.getBoolean("remember");
                byte[] photo = rs.getBytes("photo");

                User us = new User(id, name, email, address, dob, gender, membership, passU, remember, photo);
                userDetails.add(us);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return userDetails;
    }

    // Register user
    public static String registerUser(String username, String password, String email, String address, String dob, String gender, String membership, boolean remember) {
        try {
            con = DBconnector.getConnection();
            String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, username);
            ResultSet checkRs = checkPs.executeQuery();
            checkRs.next();
            if (checkRs.getInt(1) > 0) {
                System.out.println("Username " + username + " already exists.");
                return "Username already exists.";
            }

            try {
                java.sql.Date.valueOf(dob);
            } catch (IllegalArgumentException e) {
                System.err.println("Invalid DOB format for user " + username + ": " + dob);
                return "Invalid date of birth format. Use YYYY-MM-DD.";
            }

            String sql = "INSERT INTO users (username, password, email, address, dob, gender, membership, remember, photo) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NULL)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setDate(5, java.sql.Date.valueOf(dob));
            ps.setString(6, gender);
            ps.setString(7, membership);
            ps.setBoolean(8, remember);

            int result = ps.executeUpdate();
            if (result > 0) {
                System.out.println("User registered successfully: " + username);
                return "success";
            } else {
                System.out.println("Failed to insert user: " + username);
                return "Failed to register user.";
            }
        } catch (SQLException e) {
            System.err.println("SQLException registering user " + username + ": " + e.getMessage());
            e.printStackTrace();
            return "Database error: " + e.getMessage();
        } catch (Exception e) {
            System.err.println("Unexpected error registering user " + username + ": " + e.getMessage());
            e.printStackTrace();
            return "Unexpected error: " + e.getMessage();
        } finally {
            closeResources();
        }
    }

    // Update user details
    public static boolean updateUser(String username, String password, String email, String address, String dob, String gender, String membership) {
        boolean isSuccess = false;
        try {
            con = DBconnector.getConnection();
            String sql = "UPDATE users SET username = ?, email = ?, address = ?, dob = ?, gender = ?, membership = ?, password = ? WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, address);
            ps.setDate(4, java.sql.Date.valueOf(dob));
            ps.setString(5, gender);
            ps.setString(6, membership);
            ps.setString(7, password);
            ps.setString(8, username);

            int rs = ps.executeUpdate();
            isSuccess = rs > 0;
            System.out.println("Update for user " + username + " successful: " + isSuccess);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Get user details
    public static List<User> getUserDetails(String username) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBconnector.getConnection();
            if (con == null) {
                System.err.println("Failed to establish database connection for getUserDetails");
                return users;
            }
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                byte[] photo = rs.getBytes("photo");
                System.out.println("Retrieved photo length for " + username + ": " + (photo != null ? photo.length : 0));
                users.add(new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getDate("dob"),
                    rs.getString("gender"),
                    rs.getString("membership"),
                    rs.getString("password"),
                    rs.getBoolean("remember"),
                    photo
                ));
            }
        } catch (SQLException e) {
            System.err.println("SQLException in getUserDetails for username " + username + ": " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error in getUserDetails for username " + username + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return users;
    }

    // Update photo
    public static boolean updateUserPhoto(int userId, byte[] photo) {
        String sql = "UPDATE users SET photo = ? WHERE id = ?";
        try (Connection con = DBconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (photo != null && photo.length > 0) {
                ps.setBytes(1, photo);
            } else {
                ps.setNull(1, java.sql.Types.BLOB);
                System.out.println("Warning: Attempting to set null or empty photo for userId: " + userId);
            }
            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Update photo rows affected for userId " + userId + ": " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQLException in updateUserPhoto for userId " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete user
    public static boolean deleteUser(String username) {
        boolean isSuccess = false;
        try {
            con = DBconnector.getConnection();
            String sql = "DELETE FROM users WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);

            int rs = ps.executeUpdate();
            isSuccess = rs > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Get payment history
    public static List<ConsultationPayment> getPaymentHistory(String username) {
        ArrayList<ConsultationPayment> paymentHistory = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT id, name, cardNumber, expiryMonth, expiryYear, paymentTimestamp FROM ConsultationPayments WHERE name = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String cardNumber = rs.getString("cardNumber");
                String expiryMonth = rs.getString("expiryMonth");
                String expiryYear = rs.getString("expiryYear");
                Timestamp paymentTimestamp = rs.getTimestamp("paymentTimestamp");

                ConsultationPayment payment = new ConsultationPayment(id, name, cardNumber, expiryMonth, expiryYear, paymentTimestamp);
                paymentHistory.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return paymentHistory;
    }

    // Update booking count
    public static boolean updateBookingCount(int userId, String monthName, int year) {
        try (Connection con = DBconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO user_bookings (user_id, month_name, year, booking_count) " +
                 "VALUES (?, ?, ?, 1) " +
                 "ON DUPLICATE KEY UPDATE booking_count = booking_count + 1")) {
            ps.setInt(1, userId);
            ps.setString(2, monthName);
            ps.setInt(3, year);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static int getTotalBookings(int userId) {
        try (Connection con = DBconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT SUM(booking_count) AS total_bookings FROM user_bookings WHERE user_id = ?")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_bookings");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static double getEngagementRate(int userId, int year) {
        try (Connection con = DBconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT (COUNT(*) / 12.0 * 100) AS engagement_rate " +
                 "FROM user_bookings WHERE user_id = ? AND year = ? AND booking_count > 0")) {
            ps.setInt(1, userId);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("engagement_rate");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public static int getActivePlans(int userId) {
        try (Connection con = DBconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT COUNT(*) AS active_plans FROM user_plans " +
                 "WHERE user_id = ? AND status = 'active' AND event_date >= CURDATE()")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("active_plans");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Close database resources
    private static void closeResources() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}