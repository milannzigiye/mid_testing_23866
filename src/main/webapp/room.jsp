<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>

<c:set var="pageTitle" value="Room Management" scope="request" />
<c:set var="currentPage" value="rooms" scope="request" />
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

  <!-- Add Room Card -->
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Add New Room</h5>
    </div>
    <div class="card-body">
      <form id="addRoomForm" action="room_servlet" method="POST">
        <div class="row">
          <div class="col-md-12">
            <div class="mb-3">
              <label for="roomCode" class="form-label">Room Code</label>
              <input type="text" class="form-control" id="roomCode" name="roomCode" required />
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Room</button>
      </form>
    </div>
  </div>

  <!-- Rooms List -->
  <div class="card mt-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Room List</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Room Code</th>
              <th>Shelves</th>
              <th>Total Books</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${rooms}" var="room" varStatus="status">
              <tr>
                <td>${room.roomCode}</td>
                <td>${room.shelves.size()}</td>
                <td>${totalBooks[status.index]}</td>
                <td>
                  <a href="room_servlet?action=edit&id=${room.id}" class="btn btn-warning btn-sm">
                    <i class="fas fa-edit"></i>
                  </a>
                  <button onclick="deleteRoom('${room.id}')" class="btn btn-danger btn-sm">
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
  function deleteRoom(roomId) {
    if (confirm("Are you sure you want to delete this room?")) {
      fetch("room_servlet?id=" + roomId, {
        method: "DELETE",
      }).then((response) => {
        if (response.ok) {
          window.location.reload();
        } else {
          alert("Error deleting room");
        }
      });
    }
  }

  // Form validation
  document.getElementById("addRoomForm").addEventListener("submit", function (e) {
    if (!this.checkValidity()) {
      e.preventDefault();
      e.stopPropagation();
    }
    this.classList.add("was-validated");
  });
</script>

<%@ include file="common/footer.jsp" %>
