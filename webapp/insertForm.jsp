<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Booking Form</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #667eea, #764ba2);
            display: flex;
            flex-direction: column; /* Stack header and form vertically */
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 1rem;
        }
        
        nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            background: rgba(0, 0, 0, 0.3);
            width: 100%;
        }

        nav a {
            text-decoration: none;
            color: inherit;
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            color: white;
        }

        span {
            color: #B0C6D9;
        }

        nav ul li {
            list-style-type: none;
            display: inline-block;
            padding: 10px 20px;
        }

        nav ul li a {
            color: white;
            font-size: 18px;
            text-decoration: none;
            font-weight: bold;
        }

        nav ul li a:hover {
            color: #2A4359;
            transition: .3s;
        }

        button {
            border: none;
            background: linear-gradient(45deg, #2A4359, #76adde);
            padding: 12px 30px;
            border-radius: 30px;
            color: white;
            font-weight: bold;
        }

        button:hover {
            transform: scale(1.1);
            cursor: pointer;
        }
        
        .hero {
            width: 100%;
            /* Removed position: absolute to keep in document flow */
        }

        form {
            background-color: #ffffff;
            padding: 2rem 2.5rem;
            border-radius: 16px;
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 550px;
            animation: fadeIn 0.6s ease;
            margin-top: 100px; /* Added to push form below header */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 2rem;
            margin-bottom: 1.8rem;
        }

        .form-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: 600;
            color: #444;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.25s ease;
            background-color: #f9fafb;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #7c3aed;
            box-shadow: 0 0 0 4px rgba(124, 58, 237, 0.15);
            background-color: #ffffff;
            outline: none;
        }

        .submit-btn {
            width: 100%;
            padding: 0.85rem;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .submit-btn:hover {
            background: linear-gradient(to right, #5a0fbd, #1a62e2);
            transform: translateY(-2px);
        }

        @media (max-width: 600px) {
            form {
                padding: 1.5rem;
            }

            h2 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation bar -->
    <div class="hero">
        <nav>
            <h2 class="logo">Event<span>Bloom</span></h2>
            <ul>
                <li><a href="home.html">Home</a></li>
                <li><a href="aboutUs.html">About Us</a></li>
                <li><a href="eventsInfo.html">Events</a></li>
                <li><a href="contactus.jsp">Contact</a></li>
                <li><a href="faq.html">FAQ</a></li>
            </ul>
            <button type="button"><a href="register.jsp">Sign Up</a></button>
        </nav>
    </div>
    
    <form action="InsertFormServlet" method="post">
        <h2>Book Your Event</h2>

        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" name="name" id="name" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" name="phone" id="phone" required>
        </div>

        <div class="form-group">
            <label for="ePackage">Event Package</label>
            <select name="ePackage" id="ePackage" required>
                <optgroup label="Weddings">
                    <option value="poruwe ceremony">Poruwe Ceremony</option>
                    <option value="church wedding">Church Wedding</option>
                    <option value="indian wedding">Indian Wedding</option>
                </optgroup>
                <optgroup label="Birthday Parties">
                    <option value="indoor party">Indoor Party</option>
                    <option value="outdoor party">Outdoor Party</option>
                    <option value="pool party">Pool Party</option>
                </optgroup>
                <optgroup label="Corporate Events">
                    <option value="award ceremonies">Award Ceremonies</option>
                    <option value="annual meetings">Annual Meetings</option>
                    <option value="product launch">Product Launch</option>
                </optgroup>
            </select>
        </div>

        <div class="form-group">
            <label for="ePlanner">Event Planner</label>
            <input type="text" name="ePlanner" id="ePlanner" required>
        </div>

        <div class="form-group">
            <label for="eDate">Event Date</label>
            <input type="date" name="eDate" id="eDate" required>
        </div>

        <div class="form-group">
            <label for="eLocation">Event Location</label>
            <input type="text" name="eLocation" id="eLocation" required>
        </div>

        <div class="form-group">
            <label for="numberOfGuests">Number of Guests</label>
            <input type="number" name="numberOfGuests" id="numberOfGuests" required>
        </div>

        <div class="form-group">
            <label for="specialRequirements">Special Requirements</label>
            <input type="text" name="specialRequirements" id="specialRequirements" required>
        </div>

        <button type="submit" class="submit-btn">Submit Form</button>
    </form>
</body>
</html>