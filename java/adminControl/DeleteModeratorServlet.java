package adminControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeleteModeratorServlet")
public class DeleteModeratorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
	    boolean isTrue;

	    isTrue = AdminDBUtil.deleteModerator(id);

	    if (isTrue == true) {
	        String alertMessage = "Data Delete Successful";
	        response.getWriter().println("<script>alert('" + alertMessage + "');" + "window.location='GetAllModeratorServlet'</script>");
	    } else 
	    {
	        List<EventModerator> moderatorDetails = AdminDBUtil.getModeratorById(id);
	        request.setAttribute("moderatorDetails", moderatorDetails);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("addModerator.jsp");
	        dispatcher.forward(request, response);
	    }
	}

}
