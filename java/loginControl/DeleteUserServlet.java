package loginControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		
		 boolean isTrue;
	        
	        isTrue = UserDBUtil.deleteUser(username);
	        
	        if (isTrue) {
	        	
	        	List<User> uDEtails= UserDBUtil.getUserDetails(username);
	        	request.setAttribute("uDEtails", uDEtails);
	        	
	            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
	            dis.forward(request, response);
	        } else {
	            RequestDispatcher dis = request.getRequestDispatcher("userProfile.jsp");
	            dis.forward(request, response);
	        }
		
	}

}
