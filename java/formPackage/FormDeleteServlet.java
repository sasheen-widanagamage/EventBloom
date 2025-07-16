package formPackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/FormDeleteServlet")
public class FormDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		boolean isTrue;		
		isTrue = FormController.deletedataform(id);		
		if(isTrue == true) {
			 
			String alertMassage = "User Account Delete Successful";
			response.getWriter().println("<script> alert('"+alertMassage+"');"+"window.location.href='FormGetAllServlet'</script>");
			
		}     
		else {
			
			List<FormModel>moviedetails = FormController.getById(id);
		    request.setAttribute("moviedetails",moviedetails);
		    
			RequestDispatcher dispacher = request.getRequestDispatcher("wrong.jsp");
			dispacher.forward(request, response);
		}
		
	}

}
