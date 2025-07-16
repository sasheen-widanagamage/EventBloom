package contactUsControl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeleteContactServlet")
public class DeleteContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = ContactDBUtil.deleteContactMessage(id);
            
            if (deleted) {
                request.setAttribute("successMessage", "Contact message deleted successfully!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("deleteContact.html");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "Failed to delete contact message.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting contact message: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
	}

}
