<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>
<c:set var="pageTitle" value="Edit Room" scope="request" />
<c:set var="currentPage" value="rooms" scope="request" />
<%@ include file="common/header.jsp" %>

<div class="container mt-4 mb-5">
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Edit Room</h5>
    </div>
    <div class="card-body">
      <form action="room_servlet" method="POST">
        <input type="hidden" name="_method" value="PUT" />
        <input type="hidden" name="id" value="${room.id}" />

        <div class="row">
          <div class="col-md-12">
            <div class="mb-3">
              <label for="roomCode" class="form-label">Room Code</label>
              <input type="text" class="form-control" id="roomCode" name="roomCode" value="${room.roomCode}" required />
            </div>
          </div>
        </div>

        <div class="mt-3">
          <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Room</button>
          <a href="room_servlet" class="btn btn-secondary"> <i class="fas fa-times"></i> Cancel </a>
        </div>
      </form>
    </div>
  </div>
</div>

<%@ include file="common/footer.jsp" %>
