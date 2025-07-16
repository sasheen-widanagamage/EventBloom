package paymentControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdatePaymentServlet")
public class UpdatePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String cardNumber = request.getParameter("cardNumber");
        String cvv = request.getParameter("cvv");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String password = request.getParameter("password");
        String paymentMethod = request.getParameter("paymentMethod");
        double amount = Double.parseDouble(request.getParameter("amount").replaceAll("[^0-9.]", ""));

        boolean isTrue = PaymentDBUtil.updatePayment(id, name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentMethod, amount);

        if (isTrue) {
            List<ConsultationPayment> paymentDetails = PaymentDBUtil.getPaymentDetailsById(id); // Updated to use getPaymentDetailsById
            request.setAttribute("paymentDetails", paymentDetails);
            RequestDispatcher dis = request.getRequestDispatcher("confirmPayment.jsp");
            dis.forward(request, response);
        } else {
            RequestDispatcher dis = request.getRequestDispatcher("editPayment.jsp");
            dis.forward(request, response);
        }
    }
}