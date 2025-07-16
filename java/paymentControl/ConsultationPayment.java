package paymentControl;

public class ConsultationPayment {
    private int id;
    private String name;
    private String cardNumber;
    private String cvv;
    private String expiryMonth;
    private String expiryYear;
    private String password;
    private String paymentTimestamp;
    private String paymentMethod;
    private double amount;
    private String paymentStatus;

    public ConsultationPayment(int id, String name, String cardNumber, String cvv, String expiryMonth,
                              String expiryYear, String password, String paymentTimestamp, String paymentMethod,
                              double amount, String paymentStatus) {
        this.id = id;
        this.name = name;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.expiryMonth = expiryMonth;
        this.expiryYear = expiryYear;
        this.password = password;
        this.paymentTimestamp = paymentTimestamp;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.paymentStatus = paymentStatus != null ? paymentStatus : "Pending";
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getCardNumber() { return cardNumber; }
    public String getCvv() { return cvv; }
    public String getExpiryMonth() { return expiryMonth; }
    public String getExpiryYear() { return expiryYear; }
    public String getPassword() { return password; }
    public String getPaymentTimestamp() { return paymentTimestamp; }
    public String getPaymentMethod() { return paymentMethod; }
    public double getAmount() { return amount; }
    public String getPaymentStatus() { return paymentStatus; }

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    public void setCvv(String cvv) { this.cvv = cvv; }
    public void setExpiryMonth(String expiryMonth) { this.expiryMonth = expiryMonth; }
    public void setExpiryYear(String expiryYear) { this.expiryYear = expiryYear; }
    public void setPassword(String password) { this.password = password; }
    public void setPaymentTimestamp(String paymentTimestamp) { this.paymentTimestamp = paymentTimestamp; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public void setAmount(double amount) { this.amount = amount; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public boolean validatePayment() {
        boolean isValid = true;
        if (name == null || name.trim().isEmpty()) {
            System.out.println("Validation failed: Name is empty");
            isValid = false;
        }
        if (cardNumber == null || !cardNumber.matches("\\d{12,20}")) {
            System.out.println("Validation failed: Card number invalid - " + cardNumber);
            isValid = false;
        }
        if (cvv == null || !cvv.matches("\\d{3,4}")) {
            System.out.println("Validation failed: CVV invalid - " + cvv);
            isValid = false;
        }
        if (expiryMonth == null || !expiryMonth.matches("^(0[1-9]|1[0-2])$")) {
            System.out.println("Validation failed: Expiry month invalid - " + expiryMonth);
            isValid = false;
        }
        if (expiryYear == null || !expiryYear.matches("\\d{2}")) {
            System.out.println("Validation failed: Expiry year invalid - " + expiryYear);
            isValid = false;
        }
        if (password == null || password.trim().isEmpty()) {
            System.out.println("Validation failed: Password is empty");
            isValid = false;
        }
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            System.out.println("Validation failed: Payment method is empty");
            isValid = false;
        }
        if (amount <= 0) {
            System.out.println("Validation failed: Amount is <= 0 - " + amount);
            isValid = false;
        }
        return isValid;
    }

    public boolean processPayment() {
        if (validatePayment()) {
            setPaymentStatus("Completed");
            return true;
        } else {
            setPaymentStatus("Failed");
            return false;
        }
    }
}