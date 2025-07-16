package paymentControl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import loginControl.DBconnector;

public class PaymentDBUtil {
    private static boolean isSuccess;
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;

    // Insert payment details
    public static boolean insertPayment(String name, String cardNumber, String cvv, String expiryMonth,
                                       String expiryYear, String password, String paymentMethod, double amount) {
        isSuccess = false;
        try {
            con = DBconnector.getConnection();
            String sql = "INSERT INTO ConsultationPayments (name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentMethod, amount, paymentStatus) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, cardNumber);
            ps.setString(3, cvv);
            ps.setString(4, expiryMonth);
            ps.setString(5, expiryYear);
            ps.setString(6, password);
            ps.setString(7, paymentMethod);
            ps.setDouble(8, amount);
            ps.setString(9, "Pending");

            int result = ps.executeUpdate();
            if (result > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    ConsultationPayment payment = new ConsultationPayment(id, name, cardNumber, cvv, expiryMonth, expiryYear, password, null, paymentMethod, amount, "Pending");
                    isSuccess = payment.processPayment();
                    if (!isSuccess) {
                        System.out.println("Payment processing failed for ID: " + id + " at " + new java.util.Date());
                    }
                    updatePaymentStatus(id, payment.getPaymentStatus());
                } else {
                    System.out.println("Failed to retrieve generated ID at " + new java.util.Date());
                }
            } else {
                System.out.println("Database insertion failed at " + new java.util.Date());
            }
        } catch (Exception e) {
            System.out.println("Exception in insertPayment at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Update payment status
    private static void updatePaymentStatus(int id, String paymentStatus) {
        try {
            String sql = "UPDATE ConsultationPayments SET paymentStatus = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, paymentStatus);
            ps.setInt(2, id);
            int result = ps.executeUpdate();
            if (result > 0) {
                System.out.println("Payment status updated to " + paymentStatus + " for ID: " + id + " at " + new java.util.Date());
            } else {
                System.out.println("Failed to update payment status for ID: " + id + " at " + new java.util.Date());
            }
        } catch (Exception e) {
            System.out.println("Exception in updatePaymentStatus at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Get latest payment
    public static List<ConsultationPayment> getLatestPaymentDetails() {
        ArrayList<ConsultationPayment> paymentDetails = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT * FROM ConsultationPayments ORDER BY paymentTimestamp DESC LIMIT 1";
            PreparedStatement ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String cardNumber = rs.getString("cardNumber");
                String cvv = rs.getString("cvv");
                String expiryMonth = rs.getString("expiryMonth");
                String expiryYear = rs.getString("expiryYear");
                String password = rs.getString("password");
                String paymentTimestamp = rs.getString("paymentTimestamp");
                String paymentMethod = rs.getString("paymentMethod");
                double amount = rs.getDouble("amount");
                String paymentStatus = rs.getString("paymentStatus");

                ConsultationPayment payment = new ConsultationPayment(id, name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentTimestamp, paymentMethod, amount, paymentStatus);
                paymentDetails.add(payment);
            }
        } catch (Exception e) {
            System.out.println("Exception in getLatestPaymentDetails at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return paymentDetails;
    }

    // Update payment details
    public static boolean updatePayment(String id, String name, String cardNumber, String cvv, String expiryMonth,
                                      String expiryYear, String password, String paymentMethod, double amount) {
        int convertedID = Integer.parseInt(id);
        isSuccess = false;
        try {
            con = DBconnector.getConnection();
            String sql = "UPDATE ConsultationPayments SET name=?, cardNumber=?, cvv=?, expiryMonth=?, expiryYear=?, password=?, paymentMethod=?, amount=?, paymentStatus=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, cardNumber);
            ps.setString(3, cvv);
            ps.setString(4, expiryMonth);
            ps.setString(5, expiryYear);
            ps.setString(6, password);
            ps.setString(7, paymentMethod);
            ps.setDouble(8, amount);
            ps.setString(9, "Pending");
            ps.setInt(10, convertedID);

            int result = ps.executeUpdate();
            if (result > 0) {
                ConsultationPayment payment = new ConsultationPayment(convertedID, name, cardNumber, cvv, expiryMonth, expiryYear, password, null, paymentMethod, amount, "Pending");
                isSuccess = payment.processPayment();
                if (!isSuccess) {
                    System.out.println("Payment processing failed during update for ID: " + convertedID + " at " + new java.util.Date());
                }
                updatePaymentStatus(convertedID, payment.getPaymentStatus());
            } else {
                System.out.println("Database update failed for ID: " + convertedID + " at " + new java.util.Date());
            }
        } catch (Exception e) {
            System.out.println("Exception in updatePayment at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Get payment details by username
    public static List<ConsultationPayment> getPaymentDetails(String username) {
        ArrayList<ConsultationPayment> paymentDetails = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT * FROM ConsultationPayments WHERE name = ? ORDER BY paymentTimestamp DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            while (rs.next()) {
                int idVal = rs.getInt("id");
                String name = rs.getString("name");
                String cardNumber = rs.getString("cardNumber");
                String cvv = rs.getString("cvv");
                String expiryMonth = rs.getString("expiryMonth");
                String expiryYear = rs.getString("expiryYear");
                String password = rs.getString("password");
                String paymentTimestamp = rs.getString("paymentTimestamp");
                String paymentMethod = rs.getString("paymentMethod");
                double amount = rs.getDouble("amount");
                String paymentStatus = rs.getString("paymentStatus");

                ConsultationPayment pay = new ConsultationPayment(idVal, name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentTimestamp, paymentMethod, amount, paymentStatus);
                paymentDetails.add(pay);
            }
        } catch (Exception e) {
            System.out.println("Exception in getPaymentDetails for username: " + username + " at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return paymentDetails;
    }

    // Get payment details by ID
    public static List<ConsultationPayment> getPaymentDetailsById(String id) {
        ArrayList<ConsultationPayment> paymentDetails = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT * FROM ConsultationPayments WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            rs = ps.executeQuery();

            while (rs.next()) {
                int idVal = rs.getInt("id");
                String name = rs.getString("name");
                String cardNumber = rs.getString("cardNumber");
                String cvv = rs.getString("cvv");
                String expiryMonth = rs.getString("expiryMonth");
                String expiryYear = rs.getString("expiryYear");
                String password = rs.getString("password");
                String paymentTimestamp = rs.getString("paymentTimestamp");
                String paymentMethod = rs.getString("paymentMethod");
                double amount = rs.getDouble("amount");
                String paymentStatus = rs.getString("paymentStatus");

                ConsultationPayment pay = new ConsultationPayment(idVal, name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentTimestamp, paymentMethod, amount, paymentStatus);
                paymentDetails.add(pay);
            }
        } catch (Exception e) {
            System.out.println("Exception in getPaymentDetailsById for ID: " + id + " at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return paymentDetails;
    }

    // Get all payments
    public static List<ConsultationPayment> getAllPayments() {
        ArrayList<ConsultationPayment> allPayments = new ArrayList<>();
        try {
            con = DBconnector.getConnection();
            String sql = "SELECT * FROM ConsultationPayments ORDER BY paymentTimestamp DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String cardNumber = rs.getString("cardNumber");
                String cvv = rs.getString("cvv");
                String expiryMonth = rs.getString("expiryMonth");
                String expiryYear = rs.getString("expiryYear");
                String password = rs.getString("password");
                String paymentTimestamp = rs.getString("paymentTimestamp");
                String paymentMethod = rs.getString("paymentMethod");
                double amount = rs.getDouble("amount");
                String paymentStatus = rs.getString("paymentStatus");

                ConsultationPayment payment = new ConsultationPayment(id, name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentTimestamp, paymentMethod, amount, paymentStatus);
                allPayments.add(payment);
            }
        } catch (Exception e) {
            System.out.println("Exception in getAllPayments at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return allPayments;
    }

    // Delete payment
    public static boolean deletePayment(String id) {
        int convertedID = Integer.parseInt(id);
        isSuccess = false;
        try {
            con = DBconnector.getConnection();
            String sql = "DELETE FROM ConsultationPayments WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, convertedID);

            int result = ps.executeUpdate();
            if (result > 0) {
                isSuccess = true;
                System.out.println("Payment deleted successfully for ID: " + convertedID + " at " + new java.util.Date());
            } else {
                System.out.println("Failed to delete payment for ID: " + convertedID + " at " + new java.util.Date());
            }
        } catch (Exception e) {
            System.out.println("Exception in deletePayment for ID: " + convertedID + " at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return isSuccess;
    }

    // Close database resources
    private static void closeResources() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            System.out.println("Exception in closeResources at " + new java.util.Date() + ": " + e.getMessage());
            e.printStackTrace();
        }
    }
}