package loginControl;

import java.sql.Timestamp;

public class ConsultationPayment {
    private int id;
    private String name;
    private String cardNumber;
    private String expiryMonth;
    private String expiryYear;
    private Timestamp paymentTimestamp;

    public ConsultationPayment(int id, String name, String cardNumber, String expiryMonth, String expiryYear, Timestamp paymentTimestamp) {
        this.id = id;
        this.name = name;
        this.cardNumber = cardNumber;
        this.expiryMonth = expiryMonth;
        this.expiryYear = expiryYear;
        this.paymentTimestamp = paymentTimestamp;
       
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getExpiryMonth() {
        return expiryMonth;
    }

    public String getExpiryYear() {
        return expiryYear;
    }

    public Timestamp getPaymentTimestamp() {
        return paymentTimestamp;
    }

   
}