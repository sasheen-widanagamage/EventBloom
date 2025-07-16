<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Form Submissions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            padding: 1rem;
            margin: 0;
        }
        
        nav {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: rgba(0, 0, 0, 0.3);
}

nav a {
    text-decoration: none;
    color: inherit; /* optional: makes the link inherit button text color */
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
        

        h2 {
            text-align: center;
            color: #2f3e4d;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }

        #searchInput {
            display: block;
            margin: 0 auto 25px auto;
            width: 350px;
            padding: 10px 15px;
            border-radius: 10px;
            border: 1px solid #bbb;
            font-size: 16px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.07);
            animation: fadeIn 0.4s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
        }

        th {
            background-color: #4a6ee0;
            color: #fff;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.2s ease;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fbff;
        }

        tbody tr:hover {
            background-color: #edf3ff;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-buttons a button,
        .action-buttons form button {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .action-buttons a button {
            background-color: #ffc107;
            color: #fff;
        }

        .action-buttons a button:hover {
            background-color: #e0a800;
            transform: scale(1.05);
        }

        .action-buttons form button {
            background-color: #dc3545;
            color: white;
        }

        .action-buttons form button:hover {
            background-color: #c82333;
            transform: scale(1.05);
        }

        form {
            margin: 0;
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 1rem;
                background-color: #fff;
                border-radius: 10px;
                padding: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            td {
                padding: 8px 10px;
                text-align: right;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 10px;
                text-align: left;
                font-weight: bold;
                color: #555;
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

<h2>All Event Form Submissions</h2>

<input type="text" id="searchInput" placeholder="Search..." />

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Package</th>
            <th>Planner</th>
            <th>Date</th>
            <th>Location</th>
            <th>Guests</th>
            <th>Requirements</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="form" items="${allForms}">
            <tr>
                <td data-label="ID">${form.id}</td>
                <td data-label="Name">${form.name}</td>
                <td data-label="Email">${form.email}</td>
                <td data-label="Phone">${form.phone}</td>
                <td data-label="Package">${form.ePackage}</td>
                <td data-label="Planner">${form.ePlanner}</td>
                <td data-label="Date">${form.eDate}</td>
                <td data-label="Location">${form.eLocation}</td>
                <td data-label="Guests">${form.numberOfGuests}</td>
                <td data-label="Requirements">${form.specialRequirements}</td>
                <td data-label="Action">
                    <div class="action-buttons">
                        <a href="UpdateForm.jsp?id=${form.id}&name=${form.name}&email=${form.email}&phone=${form.phone}&ePackage=${form.ePackage}&ePlanner=${form.ePlanner}&eDate=${form.eDate}&eLocation=${form.eLocation}&numberOfGuests=${form.numberOfGuests}&specialRequirements=${form.specialRequirements}">
                            <button>Update</button>
                        </a>
                        <form action="FormDeleteServlet" method="post">
                            <input type="hidden" name="id" value="${form.id}" /> 
                            <button type="submit">Delete</button>
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
    document.getElementById("searchInput").addEventListener("input", function () {
        const filter = this.value.toUpperCase();
        document.querySelectorAll("table tbody tr").forEach(row => {
            row.style.display = row.textContent.toUpperCase().includes(filter) ? "" : "none";
        });
    });
</script>

</body>
</html>
