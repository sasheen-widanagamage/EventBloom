package contactUsControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/InsertMessageServlet")
public class InsertMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		    String fname = request.getParameter("fname");
		    String lname = request.getParameter("lname");
		    String email = request.getParameter("email");
		    String mobile = request.getParameter("mobile");
		    String message = request.getParameter("message");
	       

	        boolean isTrue = ContactDBUtil.insertMessage(fname, lname, email, mobile, message);

	        if (isTrue) {
	            
	            List<ContactUs> contactDetails = ContactDBUtil.getLatestMessegeDetails();

	            if (contactDetails != null && !contactDetails.isEmpty()) {
	                request.setAttribute("contactDetails", contactDetails);
	            } else {
	                request.setAttribute("errorMessage", "Messege inserted but no data found.");
	            }

	            // Forward to confirmPayment.jsp to display the details
	            RequestDispatcher dispatcher = request.getRequestDispatcher("confirmContactus.jsp");
	            dispatcher.forward(request, response);

	        } else {
	            // If insertion failed, forward to another page (could be the payment form again)
	            request.setAttribute("insertSuccess", "false");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("contactus.jsp");
	            dispatcher.forward(request, response);
	        }
	}

}
