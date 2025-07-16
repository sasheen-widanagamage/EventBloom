package paymentControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InsertPaymentServlet")
public class InsertPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String cardNumber = request.getParameter("cardNumber").replaceAll("[^0-9]", ""); // Remove spaces and non-digits
        String cvv = request.getParameter("cvv");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String password = request.getParameter("password");
        String paymentMethod = request.getParameter("paymentMethod");
        double amount = Double.parseDouble(request.getParameter("amount").replaceAll("[^0-9.]", ""));

        boolean isTrue = PaymentDBUtil.insertPayment(name, cardNumber, cvv, expiryMonth, expiryYear, password, paymentMethod, amount);

        if (isTrue) {
            List<ConsultationPayment> paymentDetails = PaymentDBUtil.getLatestPaymentDetails();
            request.setAttribute("paymentDetails", paymentDetails);
            RequestDispatcher dispatcher = request.getRequestDispatcher("confirmPayment.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("insertSuccess", "false");
            RequestDispatcher dispatcher = request.getRequestDispatcher("consultationPayment.jsp");
            dispatcher.forward(request, response);
        }
    }
}