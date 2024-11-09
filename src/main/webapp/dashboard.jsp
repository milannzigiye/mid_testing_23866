<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>

<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="currentPage" value="dashboard" scope="request"/>

<!-- Include Header -->
<%@ include file="common/header.jsp" %>

<!-- Main Content -->
<div class="container mt-4 mb-5">
    <h2 class="mb-4">Users List</h2>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users == null) {
            out.println("<div class='alert alert-warning'>No users attribute found in request</div>");
        } else if (users.isEmpty()) {
            out.println("<div class='alert alert-info'>No users found in database</div>");
        } else {
            out.println("<div class='alert alert-success'>Found " + users.size() + " users</div>");
        }
    %>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Role</th>
                    <th>Phone Number</th>
                    <th>Province</th>
                    <th>District</th>
                </tr>
            </thead>
            <tbody>
                <%@ page import="java.util.List" %>
                <%@ page import="model.User" %>
                <% if (users != null) {
                    for (User user : users) { %>
                <tr>
                    <td><%= user.getUsername()%></td>
                    <td><%= user.getFirstName()%></td> 
                    <td><%= user.getLastName()%></td> 
                    <td><%= user.getGender()%></td> 
                    <td><%= user.getRole()%></td> 
                    <td><%= user.getPhoneNumber()%></td>
                    <td><%= user.getVillage().getParent().getParent().getParent().getLocationName()%></td>
                    <td><%= user.getVillage().getParent().getParent().getLocationName()%></td>
                </tr>
                <% }
                } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Include Footer -->
<%@ include file="common/footer.jsp" %>
