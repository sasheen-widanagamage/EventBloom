package loginControl;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import paymentControl.ConsultationPayment; // Correct import
import paymentControl.PaymentDBUtil;

@WebServlet("/LoadUserServlet")
public class LoadUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String page = request.getParameter("page");
        RequestDispatcher dispatcher;

        switch (page) {
            case "consultationPayment":
                dispatcher = request.getRequestDispatcher("consultationPayment.jsp");
                break;
            case "consultation":
                dispatcher = request.getRequestDispatcher("consultation.jsp");
                break;
            case "paymentHistory":
                List<ConsultationPayment> paymentHistory = PaymentDBUtil.getPaymentDetails(username); // Use PaymentDBUtil
                // Debug: Log payment history size
                System.out.println("Payment history size for user " + username + ": " + (paymentHistory != null ? paymentHistory.size() : "null"));
                request.setAttribute("paymentHistory", paymentHistory); // Use request attribute
                dispatcher = request.getRequestDispatcher("paymentHistory.jsp");
                break;
            case "userNotification":
                dispatcher = request.getRequestDispatcher("userNotification.jsp");
                break;
            default:
                dispatcher = request.getRequestDispatcher("userProfile.jsp");
                break;
        }

        dispatcher.forward(request, response);
    }
}