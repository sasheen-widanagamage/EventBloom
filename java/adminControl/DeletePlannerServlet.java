package adminControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeletePlannerServlet")
public class DeletePlannerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
	    boolean isTrue;

	    isTrue = AdminDBUtil.deletePlanner(id);

	    if (isTrue == true) {
	        String alertMessage = "Data Delete Successful";
	        response.getWriter().println("<script>alert('" + alertMessage + "');" + "window.location='GetAllPlannerServlet'</script>");
	    } else 
	    {
	        List<EventPlanner> plannerDetails = AdminDBUtil.getPlannerById(id);
	        request.setAttribute("plannerDetails", plannerDetails);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("addPlanner.jsp");
	        dispatcher.forward(request, response);
	    }
	}

}





















