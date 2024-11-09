<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AUCA Library - User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
      body {
        padding-top: 56px;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
      }
      .form-section {
        padding: 25px;
      }
      .form-section h5 {
        margin-bottom: 20px;
      }
      .footer {
        background-color: #1a237e;
        color: white;
        padding: 10px;
        text-align: center;
        border-top: 1px solid #0a58ca;
      }
      .form-container {
        background-image: url("https://lh3.googleusercontent.com/p/AF1QipOd6Zb2PELARZfRRY7g0IjycSWq6NX5lQA4Ov4z=s1360-w1360-h1020");
        background-size: cover;
        background-position: center;
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
      }
      .card-container {
        background-color: rgba(255, 255, 255, 0.95);
        border: none;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        width: 90%;
        max-width: 1000px;
        margin: 30px auto;
      }
      .card-header {
        background-color: #007bff;
        color: white;
        border-radius: 10px 10px 0 0;
      }
      .btn-primary {
        padding: 10px 30px;
        margin: 20px;
        border-radius: 5px;
      }
      .navbar {
        background-color: #1a237e !important;
      }
    </style>
  </head>
  <body>
    <!-- Include Header -->
    <jsp:include page="common/header.jsp" />

    <!-- Main Content -->
    <div class="form-container">
      <div class="card-container">
        <div class="card">
          <div class="card-header">
            <h4>User Registration Form</h4>
          </div>

          <!-- Add error/success message display section -->
          <% if(request.getParameter("error") != null) { %>
          <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
            <%= request.getParameter("error") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          <% } %> <% if(request.getParameter("message") != null) { %>
          <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
            <%= request.getParameter("message") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          <% } %>

          <div class="card-body">
            <!-- Update form action to point to RegisterServlet -->
            <form action="register_servlet" method="POST" id="registrationForm">
              <div class="row">
                <div class="col-md-6 form-section">
                  <h5>Personal Information</h5>
                  <div class="form-group mb-3">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required />
                    <div class="invalid-feedback">Please enter a username.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required />
                    <div class="invalid-feedback">Please enter a password.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="firstName">First Name</label>
                    <input type="text" class="form-control" id="firstName" name="firstName" required />
                    <div class="invalid-feedback">Please enter your first name.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="lastName">Last Name</label>
                    <input type="text" class="form-control" id="lastName" name="lastName" required />
                    <div class="invalid-feedback">Please enter your last name.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="gender">Gender</label>
                    <select class="form-select" id="gender" name="gender" required>
                      <option value="">Select Gender</option>
                      <option value="MALE">Male</option>
                      <option value="FEMALE">Female</option>
                    </select>
                    <div class="invalid-feedback">Please select your gender.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="role">Role</label>
                    <select class="form-select" id="role" name="role" required>
                      <option value="">Select Role</option>
                      <option value="STUDENT">Student</option>
                      <option value="MANAGER">Manager</option>
                      <option value="TEACHER">Teacher</option>
                      <option value="DEAN">Dean</option>
                      <option value="HOD">HOD</option>
                      <option value="LIBRARIAN">Librarian</option>
                    </select>
                    <div class="invalid-feedback">Please select a role.</div>
                  </div>
                </div>
                <div class="col-md-6 form-section">
                  <h5>Contact and Location Information</h5>
                  <div class="form-group mb-3">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required />
                    <div class="invalid-feedback">Please enter your phone number.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="province">Province</label>
                    <input type="text" class="form-control" id="province" name="province" required />
                    <div class="invalid-feedback">Please enter your province.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="district">District</label>
                    <input type="text" class="form-control" id="district" name="district" required />
                    <div class="invalid-feedback">Please enter your district.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="sector">Sector</label>
                    <input type="text" class="form-control" id="sector" name="sector" required />
                    <div class="invalid-feedback">Please enter your sector.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="cell">Cell</label>
                    <input type="text" class="form-control" id="cell" name="cell" required />
                    <div class="invalid-feedback">Please enter your cell.</div>
                  </div>
                  <div class="form-group mb-3">
                    <label for="village">Village</label>
                    <input type="text" class="form-control" id="village" name="village" required />
                    <div class="invalid-feedback">Please enter your village.</div>
                  </div>
                </div>
              </div>
              <button type="submit" class="btn btn-primary">Register</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="common/footer.jsp" />

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"
    ></script>
    <script>
      // Example of simple form validation using JavaScript
      const form = document.getElementById("registrationForm");
      form.addEventListener("submit", (e) => {
        if (!form.checkValidity()) {
          e.preventDefault();
          e.stopPropagation();
        }
        form.classList.add("was-validated");
      });
    </script>
  </body>
</html>
