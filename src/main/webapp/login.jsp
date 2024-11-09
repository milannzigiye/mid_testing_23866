<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Add this at the top of the file, after the taglib declarations
    if (session.getAttribute("user") != null) {
        String role = (String) session.getAttribute("role");
        if ("LIBRARIAN".equals(role)) {
            response.sendRedirect("book_servlet");
            return;
        } else if ("STUDENT".equals(role) || "TEACHER".equals(role)) {
            response.sendRedirect("home");
            return;
        }
    }
%>

<c:set var="pageTitle" value="Login" scope="request" />
<%@ include file="common/header.jsp" %>

<!-- Main Content -->
<div class="container mt-4">
  <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      ${error}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <c:if test="${not empty message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
      <div class="card">
        <div class="card-body p-4">
          <h2 class="text-center mb-4">Login Into AUCA Library</h2>

          <form action="login_servlet" method="post">
            <div class="mb-3">
              <label for="username" class="form-label">Username</label>
              <input type="text" class="form-control" id="username" name="username" required />
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password" required />
            </div>
            <div class="mb-3 form-check">
              <input type="checkbox" class="form-check-input" id="remember" />
              <label class="form-check-label" for="remember">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
          </form>

          <div class="text-center mt-3">
            <p class="mb-0">Don't have an account? <a href="register.jsp">Register here</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="common/footer.jsp" %>
