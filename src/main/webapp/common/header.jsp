<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AUCA Library - ${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
      .navbar {
        background-color: #1a237e !important;
      }
      /* Add padding to body to prevent content from hiding behind fixed navbar */
      body {
        padding-top: 56px;
      }
      .card {
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }
      .table th {
        background-color: #f8f9fa;
      }
      .btn-action {
        margin: 0 2px;
      }
      .footer {
        background-color: #1a237e;
        color: white;
        position: fixed;
        bottom: 0;
        width: 100%;
      }
    </style>
  </head>
  <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">AUCA Library</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <c:if test="${sessionScope.user.role == 'LIBRARIAN'}">
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'rooms' ? 'active' : ''}" href="room_servlet">Rooms</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'shelves' ? 'active' : ''}" href="shelf_servlet">Shelves</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'books' ? 'active' : ''}" href="book_servlet">Books</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'membership-types' ? 'active' : ''}" href="membership_type_servlet"
                  >Membership Types</a
                >
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'members' ? 'active' : ''}" href="membership_servlet">Members</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'users' ? 'active' : ''}" href="user_servlet">Users</a>
              </li>
            </c:if>
            <c:if
              test="${not empty sessionScope.user && (sessionScope.user.role == 'STUDENT' || sessionScope.user.role == 'TEACHER')}"
            >
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'home' ? 'active' : ''}" href="home">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link ${currentPage == 'location' ? 'active' : ''}" href="location">Find Province</a>
              </li>
            </c:if>
          </ul>

          <!-- user info and logout button -->
          <ul class="navbar-nav">
            <c:if test="${not empty sessionScope.user}">
              <li class="nav-item">
                <span class="nav-link">
                  <i class="fas fa-user me-1"></i>
                  ${sessionScope.user.firstName} (${sessionScope.user.role})
                </span>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="logout"> <i class="fas fa-sign-out-alt me-1"></i>Logout </a>
              </li>
            </c:if>
          </ul>
        </div>
      </div>
    </nav>
  </body>
</html>
