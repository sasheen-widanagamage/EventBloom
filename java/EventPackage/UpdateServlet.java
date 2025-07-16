package EventPackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cusId = request.getParameter("cusId");
		String cusName = request.getParameter("cusName");
		String cusEmail = request.getParameter("cusEmail");
		String eventDate = request.getParameter("eventDate");
		int noOfParticipants = Integer.parseInt(request.getParameter("noOfParticipants"));
		String eventColour = request.getParameter("eventColour");
		String venueType = request.getParameter("venueType");
		String foodBeverage = request.getParameter("foodBeverage");
		String musicEntertainment = request.getParameter("musicEntertainment");
		String decorations = request.getParameter("decorations");
		String other = request.getParameter("other");
		
		boolean isTrue;
		isTrue = CustomerController.updatedata(cusName, cusEmail, eventDate, noOfParticipants, eventColour, venueType, foodBeverage, musicEntertainment, decorations, other, cusId);
		
		if(isTrue == true) {
			List<CustomerModel> customerdetails = CustomerController.getById(cusId);
			request.setAttribute("customerdetails", customerdetails);
			
			String alertMessage = "Data Update Successful";
			response.getWriter().println("<script> alert('"+alertMessage+"'); window.location.href='GetAllServlet'</script>");
		
		}
		else {
			RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
			dis2.forward(request, response);
		}
	}

}
