<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>

<c:set var="pageTitle" value="Shelf Management" scope="request" />
<c:set var="currentPage" value="shelves" scope="request" />
<%@ include file="common/header.jsp" %>

<div class="container mt-4 mb-5">
  <!-- Messages -->
  <c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show">
      ${error}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>
  <c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show">
      ${success}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <!-- Add Shelf Form -->
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Add New Shelf</h5>
    </div>
    <div class="card-body">
      <form action="shelf_servlet" method="POST">
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="room" class="form-label">Select Room</label>
              <select class="form-select" id="room" name="roomId" required>
                <option value="">Choose a room...</option>
                <c:forEach items="${rooms}" var="room">
                  <option value="${room.id}">${room.roomCode}</option>
                </c:forEach>
              </select>
            </div>
            <div class="mb-3">
              <label for="shelfName" class="form-label">Shelf Name</label>
              <input type="text" class="form-control" id="shelfName" name="name" required />
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="bookCategory" class="form-label">Book Category</label>
              <input type="text" class="form-control" id="bookCategory" name="bookCategory" required />
            </div>
            <div class="mb-3">
              <label for="initialStock" class="form-label">Initial Stock</label>
              <input type="number" class="form-control" id="initialStock" name="initialStock" required />
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Shelf</button>
      </form>
    </div>
  </div>

  <!-- Shelves List -->
  <div class="card mt-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Shelves List</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Room</th>
              <th>Shelf Name</th>
              <th>Category</th>
              <th>Available Stock</th>
              <th>Initial Stock</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${shelves}" var="shelf">
              <tr>
                <td>${shelf.room.roomCode}</td>
                <td>${shelf.name}</td>
                <td>${shelf.bookCategory}</td>
                <td>${shelf.availableStock}</td>
                <td>${shelf.initialStock}</td>
                <td>
                  <a href="shelf_servlet?action=edit&id=${shelf.id}" class="btn btn-warning btn-sm">
                    <i class="fas fa-edit"></i>
                  </a>
                  <button onclick="deleteShelf('${shelf.id}')" class="btn btn-danger btn-sm">
                    <i class="fas fa-trash"></i>
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  function deleteShelf(shelfId) {
    if (confirm("Are you sure you want to delete this shelf?")) {
      fetch("shelf_servlet?id=" + shelfId, {
        method: "DELETE",
      }).then((response) => {
        if (response.ok) {
          window.location.reload();
        } else {
          alert("Error deleting shelf");
        }
      });
    }
  }
</script>

<%@ include file="common/footer.jsp" %>
