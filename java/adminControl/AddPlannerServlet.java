package adminControl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddPlannerServlet")
public class AddPlannerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		String nic = request.getParameter("nic");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String district = request.getParameter("district");
		String province = request.getParameter("province");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String password = request.getParameter("password");
		String specialization = request.getParameter("specialization");
		

	    boolean isTrue = AdminDBUtil.registerPlanner(name,nic,phone,email,address,district,province,birthday,gender,password,specialization);

	    if (isTrue==true) {
        	String alertMessage = "Data Insert Successful";
            response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='GetAllPlannerServlet'; </script>");
        } else {
            // Optional: You can also pass a failure message here if needed
            request.setAttribute("insertSuccess", "false");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addPlanner.jsp");
            dispatcher.forward(request, response);
        }
	        
	       
		
	}

}