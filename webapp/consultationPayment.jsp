<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="css/consultationPayment.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="dashboard">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 class="logo">Event <span>Bloom</span></h2>
            <ul>
                <li><a href="userProfile.jsp"><i class='bx bxs-user'></i>Profile</a></li>
                <li><a href="home.html"><i class='bx bxs-home'></i>Home</a></li>
                <li><a href="LoadUserServlet?page=consultationPayment"><i class='bx bxs-book'></i>Payment</a></li>
                <li><a href="LoadUserServlet?page=consultation"><i class='bx bxs-calendar'></i>Book Consultation</a></li>
                <c:forEach var="user" items="${uDEtails}">
                  <c:url value="userEdit.jsp" var="updateUser">
                      <c:param name="username" value="${user.username}"/>
                      <c:param name="address" value="${user.address}"/>
                      <c:param name="email" value="${user.email}"/>
                      <c:param name="dob" value="${user.dob}"/>
                      <c:param name="gender" value="${user.gender}"/>
                      <c:param name="membership" value="${user.membership}"/>
                      <c:param name="password" value="${user.password}"/>
                  </c:url>
               <li><a href="${updateUser}"><i class='bx bxs-pen'></i>Edit Profile</a></li>
               </c:forEach>
                <li><a href="LoadUserServlet?page=paymentHistory"><i class='bx bxs-user-detail'></i>Payment History</a></li>
                <li><a href="LoadUserServlet?page=userNotification"><i class='bx bxs-message'></i>Notifications</a></li>
                
                <li><a href="LogoutServlet" onclick="return confirm('Are you sure you want to log out?')"><i class='bx bx-log-out'></i>Logout</a></li>
                <c:forEach var="user" items="${uDEtails}">
                  <c:url value="confirmDelete.jsp" var="deleteUser">
                      <c:param name="username" value="${user.username}"/>
                      <c:param name="address" value="${user.address}"/>
                      <c:param name="email" value="${user.email}"/>
                      <c:param name="dob" value="${user.dob}"/>
                      <c:param name="gender" value="${user.gender}"/>
                      <c:param name="membership" value="${user.membership}"/>
                      <c:param name="password" value="${user.password}"/>
                  </c:url>
                <li class="delete-account"><a href="${deleteUser}"><i class='bx bxs-trash'></i>Delete Account</a></li>
                </c:forEach>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
          <div class="form-section">
            <div class="header">
              <h2>Event Bloom Pay</h2>
              <div class="timer">20:00</div> <!-- Timer -->
            </div>
          
            <form action="InsertPaymentServlet" method="post">
              <!-- Payment Method Selection -->
              <div class="form-group">
                <label for="paymentMethod">Payment Method</label>
                <div class="input-group">
                  <select id="paymentMethod" name="paymentMethod" required>
                    <option value="" disabled selected>Select Payment Method</option>
                    <option value="creditCard">Credit/Debit Card</option>
                    <option value="paypal">PayPal</option>
                    <option value="bankTransfer">Bank Transfer</option>
                  </select>
                  <i class='bx bx-wallet'></i>
                </div>
              </div>

              <!-- Amount Input with Keypad -->
              <div class="form-group">
                <label for="amount">Amount (LKR)</label>
                <div class="input-group">
                  <input type="text" id="amount" name="amount" placeholder="Enter Amount" readonly required>
                  <i class='bx bx-money'></i>
                </div>
                <div class="keypad" id="keypad" style="display: none;">
                  <div class="keypad-row">
                    <button type="button" class="keypad-btn" data-value="1">1</button>
                    <button type="button" class="keypad-btn" data-value="2">2</button>
                    <button type="button" class="keypad-btn" data-value="3">3</button>
                  </div>
                  <div class="keypad-row">
                    <button type="button" class="keypad-btn" data-value="4">4</button>
                    <button type="button" class="keypad-btn" data-value="5">5</button>
                    <button type="button" class="keypad-btn" data-value="6">6</button>
                  </div>
                  <div class="keypad-row">
                    <button type="button" class="keypad-btn" data-value="7">7</button>
                    <button type="button" class="keypad-btn" data-value="8">8</button>
                    <button type="button" class="keypad-btn" data-value="9">9</button>
                  </div>
                  <div class="keypad-row">
                    <button type="button" class="keypad-btn" data-value=".">.</button>
                    <button type="button" class="keypad-btn" data-value="0">0</button>
                    <button type="button" class="keypad-btn backspace">⌫</button>
                  </div>
                  <div class="keypad-row">
                    <button type="button" class="keypad-btn done">Done</button>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label for="name">Name</label>
                <div class="input-group">
                  <input type="text" id="name" name="name" placeholder="Enter your Name" maxlength="21" required>
                  <i class='bx bx-credit-card'></i>
                </div>
              </div>
              <div class="form-group">
                <label for="card-number">Card Number</label>
                <div class="input-group">
                  <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter your card number" maxlength="19" required>
                  <i class='bx bx-credit-card'></i>
                  <span class="card-type" id="cardType"></span>
                </div>
              </div>
              <div class="form-group">
                <label for="cvv">CVV</label>
                <div class="input-group">
                  <input type="text" id="cvv" name="cvv" placeholder="Enter CVV" maxlength="3" required>
                  <i class='bx bx-lock'></i>
                </div>
              </div>
              <div class="form-group">
                <label for="expiry">Expiry Date</label>
                <div class="expiry-input">
                  <input type="text" id="expiryMonth" name="expiryMonth" placeholder="MM" maxlength="2" required>
                  <span>/</span>
                  <input type="text" id="expiryYear" name="expiryYear" placeholder="YY" maxlength="2" required>
                </div>
              </div>
              <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                  <input type="password" id="password" name="password" placeholder="Enter your dynamic password" required>
                  <i class='bx bx-key'></i>
                  <i class='bx bx-show toggle-password' id="togglePassword" style="cursor: pointer;"></i>
                </div>
              </div>
              <button type="submit" class="pay-btn">Pay Now</button>
            </form>      
          </div>
        </div>
    </div>
    
    <script>
      // Timer Countdown (20 minutes)
      let timeLeft = 20 * 60; // 20 minutes in seconds
      const timerDisplay = document.querySelector('.timer');
      const timerInterval = setInterval(() => {
        let minutes = Math.floor(timeLeft / 60);
        let seconds = timeLeft % 60;
        timerDisplay.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
        timeLeft--;
        if (timeLeft < 0) {
          clearInterval(timerInterval);
          timerDisplay.textContent = 'Expired';
          document.querySelector('form').querySelector('button').disabled = true;
          alert('Payment session expired. Please refresh the page to try again.');
        }
      }, 1000);

      // Keypad Functionality
      const amountInput = document.getElementById('amount');
      const keypad = document.getElementById('keypad');
      amountInput.addEventListener('click', () => {
        keypad.style.display = 'block';
      });

      document.querySelectorAll('.keypad-btn').forEach(button => {
        button.addEventListener('click', () => {
          if (button.classList.contains('done')) {
            keypad.style.display = 'none';
          } else if (button.classList.contains('backspace')) {
            amountInput.value = amountInput.value.slice(0, -1);
          } else {
            const value = button.getAttribute('data-value');
            amountInput.value += value;
          }
        });
      });

      // Card Type Detection
      const cardNumberInput = document.getElementById('cardNumber');
      const cardTypeSpan = document.getElementById('cardType');
      cardNumberInput.addEventListener('input', () => {
        let cardNumber = cardNumberInput.value.replace(/\D/g, '');
        cardNumberInput.value = cardNumber.replace(/(.{4})/g, '$1 ').trim();
        let cardType = '';
        if (/^4/.test(cardNumber)) cardType = 'Visa';
        else if (/^5[1-5]/.test(cardNumber)) cardType = 'MasterCard';
        else if (/^3[47]/.test(cardNumber)) cardType = 'Amex';
        else if (/^6(?:011|5)/.test(cardNumber)) cardType = 'Discover';
        cardTypeSpan.textContent = cardType;
      });

      // Toggle Password Visibility
      const togglePassword = document.getElementById('togglePassword');
      const passwordInput = document.getElementById('password');
      togglePassword.addEventListener('click', () => {
        const type = passwordInput.type === 'password' ? 'text' : 'password';
        passwordInput.type = type;
        togglePassword.classList.toggle('bx-show');
        togglePassword.classList.toggle('bx-hide');
      });

      // Form Validation
      document.querySelector("form").addEventListener("submit", function(e) {
        const name = document.getElementById("name").value.trim();
        const amount = document.getElementById("amount").value.trim();
        const cardNumber = document.getElementById("cardNumber").value.trim();
        const cvv = document.getElementById("cvv").value.trim();
        const expiryMonth = document.getElementById("expiryMonth").value.trim();
        const expiryYear = document.getElementById("expiryYear").value.trim();
        const password = document.getElementById("password").value.trim();
        const paymentMethod = document.getElementById("paymentMethod").value;

        const amountRegex = /^\d+(\.\d{1,2})?$/;
        const cvvRegex = /^\d{3}$/;
        const monthRegex = /^(0[1-9]|1[0-2])$/;
        const yearRegex = /^\d{2}$/;

        if (paymentMethod === "") {
          alert("Please select a payment method.");
          e.preventDefault();
          return;
        }

        if (!amountRegex.test(amount) || parseFloat(amount) <= 0) {
          alert("Please enter a valid amount (e.g., 2500 or 2500.00).");
          e.preventDefault();
          return;
        }

        if (name === "") {
          alert("Name is required.");
          e.preventDefault();
          return;
        }

        if (!cvvRegex.test(cvv)) {
          alert("CVV must be 3 digits.");
          e.preventDefault();
          return;
        }

        if (!monthRegex.test(expiryMonth)) {
          alert("Expiry month must be between 01 and 12.");
          e.preventDefault();
          return;
        }

        if (!yearRegex.test(expiryYear)) {
          alert("Expiry year must be 2 digits.");
          e.preventDefault();
          return;
        }

        if (password === "") {
          alert("Password is required.");
          e.preventDefault();
          return;
        }
      });
    </script>
</body>
</html>