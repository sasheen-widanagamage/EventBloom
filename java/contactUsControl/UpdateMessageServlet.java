package contactUsControl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UpdateMessageServlet")
public class UpdateMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // Retrieve form parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String message = request.getParameter("message");

            // Update the contact message
            boolean updated = ContactDBUtil.updateContactMessage(id, fname, lname, email, mobile, message);
            
            if (updated) {
                // Fetch updated message
            	ContactUs updatedMessage = ContactDBUtil.getContactMessageById(id);
                List<ContactUs> contactDetails = new ArrayList<>();
                contactDetails.add(updatedMessage);
                
                // Set updated details for confirmContactUs.jsp
                request.setAttribute("contactDetails", contactDetails);
                RequestDispatcher dispatcher = request.getRequestDispatcher("confirmContactus.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "Failed to update contact message.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating contact message: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
	}

}
