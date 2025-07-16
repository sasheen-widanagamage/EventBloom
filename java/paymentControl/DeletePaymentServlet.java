package paymentControl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeletePaymentServlet")
public class DeletePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        // Fetch payment details before deletion
        List<ConsultationPayment> paymentDetails = PaymentDBUtil.getPaymentDetails(id);
        request.setAttribute("paymentDetails", paymentDetails);

        boolean isTrue = PaymentDBUtil.deletePayment(id);

        if (isTrue) {
            RequestDispatcher dis = request.getRequestDispatcher("deleteSucssesspay.jsp");
            dis.forward(request, response);
        } else {
            RequestDispatcher dis = request.getRequestDispatcher("consultationPayment.jsp");
            dis.forward(request, response);
        }
    }
}