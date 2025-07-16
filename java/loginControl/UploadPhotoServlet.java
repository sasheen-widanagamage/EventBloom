package loginControl;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet to handle user profile photo uploads.
 */
@WebServlet("/UploadPhotoServlet")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max file size
public class UploadPhotoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png"};

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get username from session
            String username = (String) session.getAttribute("username");
            System.out.println("Uploading photo for username: " + username);

            // Get user details to retrieve userId
            List<User> userDetails = UserDBUtil.getUserDetails(username);
            if (userDetails == null || userDetails.isEmpty()) {
                session.setAttribute("photoError", "User not found.");
                response.sendRedirect("userProfile.jsp");
                return;
            }
            int userId = userDetails.get(0).getId();
            System.out.println("User ID: " + userId);

            // Get the file part
            Part filePart = request.getPart("photo");
            if (filePart == null) {
                session.setAttribute("photoError", "No file selected.");
                response.sendRedirect("userProfile.jsp");
                return;
            }

            // Validate file type
            String contentType = filePart.getContentType();
            boolean validType = false;
            for (String type : ALLOWED_TYPES) {
                if (type.equals(contentType)) {
                    validType = true;
                    break;
                }
            }
            if (!validType) {
                session.setAttribute("photoError", "Invalid file type. Only JPEG and PNG are allowed.");
                response.sendRedirect("userProfile.jsp");
                return;
            }

            // Read file into byte array
            InputStream inputStream = filePart.getInputStream();
            byte[] photoData = inputStream.readAllBytes();
            inputStream.close();
            if (photoData == null || photoData.length == 0) {
                session.setAttribute("photoError", "Empty or invalid photo data.");
                System.out.println("Error: Photo data is empty or null.");
                response.sendRedirect("userProfile.jsp");
                return;
            }
            System.out.println("Photo data length: " + photoData.length);

            // Update photo in database
            boolean success = UserDBUtil.updateUserPhoto(userId, photoData);
            System.out.println("Update photo success: " + success);
            if (success) {
                // Refresh user details in session
                List<User> updatedDetails = UserDBUtil.getUserDetails(username);
                System.out.println("Updated user details size: " + (updatedDetails != null ? updatedDetails.size() : 0));
                if (updatedDetails != null && !updatedDetails.isEmpty() && updatedDetails.get(0).getPhoto() != null) {
                    System.out.println("Refreshed photo length: " + updatedDetails.get(0).getPhoto().length);
                } else {
                    System.out.println("Warning: Refreshed user details missing photo.");
                }
                session.setAttribute("userDetails", updatedDetails);
                session.setAttribute("photoSuccess", "Profile photo updated successfully!");
            } else {
                session.setAttribute("photoError", "Failed to update profile photo in database.");
                System.out.println("Error: Database update failed for userId: " + userId);
            }

            response.sendRedirect("userProfile.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("photoError", "Error uploading photo: " + e.getMessage());
            System.out.println("Exception during photo upload: " + e.getMessage());
            response.sendRedirect("userProfile.jsp");
        }
    }
}