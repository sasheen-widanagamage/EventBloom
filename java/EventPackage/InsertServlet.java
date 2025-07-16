package EventPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/InsertServlet")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		isTrue = CustomerController.insertdata(cusName, cusEmail, eventDate, noOfParticipants, eventColour, venueType, foodBeverage, musicEntertainment, decorations, other);
		
		if(isTrue == true) {
			String alertMessage = "Data Insert Successful";
			response.getWriter().println("<script> alert('"+alertMessage+"'); window.location.href='GetAllServlet'</script>");
			
		}
		else {
			RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
			dis2.forward(request, response);
		}
		
	}

}
