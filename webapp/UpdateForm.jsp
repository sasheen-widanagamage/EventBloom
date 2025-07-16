<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    public String isSelected(String optionValue, String currentValue) {
        if(optionValue.equalsIgnoreCase(currentValue)) {
            return "selected";
        }
        return "";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Event</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: radial-gradient(circle at top left, #e3f2fd, #d1c4e9);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        form {
            background-color: #ffffff;
            padding: 3rem 2.5rem;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 720px;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 2rem;
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.6rem;
            font-weight: 600;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px 14px;
            font-size: 15px;
            border: 1px solid #ccd6dd;
            border-radius: 10px;
            background-color: #f5f7fa;
            transition: all 0.25s ease;
        }

        input:focus,
        select:focus {
            background-color: #fff;
            border-color: #4a90e2;
            box-shadow: 0 0 8px rgba(74, 144, 226, 0.3);
            outline: none;
        }

        input[readonly] {
            background-color: #eaeaea;
            cursor: not-allowed;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            background: linear-gradient(135deg, #42a5f5, #478ed1);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #1e88e5, #1565c0);
            transform: scale(1.02);
        }

        @media (max-width: 600px) {
            form {
                padding: 2rem 1.5rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String ePackage = request.getParameter("ePackage");
    String ePlanner = request.getParameter("ePlanner");
    String eDate = request.getParameter("eDate");
    String eLocation = request.getParameter("eLocation");
    int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));
    String specialRequirements = request.getParameter("specialRequirements");
%>

<form action="FormUpdateServlet" method="post">
    <h2>Update Event Booking</h2>

    <div class="form-group">
        <label>ID</label>
        <input type="text" name="id" value="<%=id%>" readonly>
    </div>

    <div class="form-group">
        <label>Name</label>
        <input type="text" name="name" value="<%=name%>" required>
    </div>

    <div class="form-group">
        <label>Email</label>
        <input type="email" name="email" value="<%=email%>" readonly>
    </div>

    <div class="form-group">
        <label>Phone</label>
        <input type="text" name="phone" value="<%=phone%>" required>
    </div>

    <div class="form-group">
        <label>Event Package</label>
        <select name="ePackage" required>
            <optgroup label="Weddings">
                <option value="poruwe ceremony" <%= isSelected("poruwe ceremony", ePackage) %>>Poruwe Ceremony</option>
                <option value="church wedding" <%= isSelected("church wedding", ePackage) %>>Church Wedding</option>
                <option value="indian wedding" <%= isSelected("indian wedding", ePackage) %>>Indian Wedding</option>
            </optgroup>
            <optgroup label="Birthday Parties">
                <option value="indoor party" <%= isSelected("indoor party", ePackage) %>>Indoor Party</option>
                <option value="outdoor party" <%= isSelected("outdoor party", ePackage) %>>Outdoor Party</option>
                <option value="pool party" <%= isSelected("pool party", ePackage) %>>Pool Party</option>
            </optgroup>
            <optgroup label="Corporate Events">
                <option value="award ceremonies" <%= isSelected("award ceremonies", ePackage) %>>Award Ceremonies</option>
                <option value="annual meetings" <%= isSelected("annual meetings", ePackage) %>>Annual Meetings</option>
                <option value="product launch" <%= isSelected("product launch", ePackage) %>>Product Launch</option>
            </optgroup>
        </select>
    </div>

    <div class="form-group">
        <label>Event Planner</label>
        <input type="text" name="ePlanner" value="<%=ePlanner%>" required>
    </div>

    <div class="form-group">
        <label>Event Date</label>
        <input type="date" name="eDate" value="<%=eDate%>" required>
    </div>

    <div class="form-group">
        <label>Event Location</label>
        <input type="text" name="eLocation" value="<%=eLocation%>" required>
    </div>

    <div class="form-group">
        <label>Number of Guests</label>
        <input type="number" name="numberOfGuests" value="<%=numberOfGuests%>" required>
    </div>

    <div class="form-group">
        <label>Special Requirements</label>
        <input type="text" name="specialRequirements" value="<%=specialRequirements%>" required>
    </div>

    <input type="submit" class="submit-btn" value="Update Event">
</form>

</body>
</html>
