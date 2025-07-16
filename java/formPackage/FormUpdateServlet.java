package formPackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/FormUpdateServlet")
public class FormUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		 String id = request.getParameter("id");
		 String name = request.getParameter("name");
	     String email = request.getParameter("email");
	     String phone = request.getParameter("phone");;
	     String ePackage = request.getParameter("ePackage");
	     String ePlanner = request.getParameter("ePlanner");
	     String eDate = request.getParameter("eDate");
	     String eLocation = request.getParameter("eLocation");
	     int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));
	     String specialRequirements = request.getParameter("specialRequirements");
	     
	     boolean isTrue;
			
			isTrue = FormController.updatedataForm(id, name, email, phone, ePackage, ePlanner, eDate, eLocation, numberOfGuests, specialRequirements);
			
			if(isTrue == true) {
				
				List<FormModel> formdetails = FormController.getById(id);
				request.setAttribute("formdetails", formdetails);
				
				String alertMassage = "Form Update Successful";
				response.getWriter().println("<script> alert('"+alertMassage+"'); window.location.href='FormGetAllServlet'</script>");
				
			}
			else {
				RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
				dis2.forward(request, response);
			}
	     
	}

}
