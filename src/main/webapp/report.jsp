<%@ include file="common/header.jsp" %> <%-- Authentication and Role Check --%>
<c:if
  test="${empty sessionScope.user || 
    !(sessionScope.user.role == 'MANAGER' || 
      sessionScope.user.role == 'LIBRARIAN' || 
      sessionScope.user.role == 'DEAN' || 
      sessionScope.user.role == 'HOD')}"
>
  <c:redirect url="/login_servlet" />
</c:if>

<c:set var="pageTitle" value="Library Report" scope="request" />
<c:set var="currentPage" value="report" scope="request" />

<div class="container mt-4">
  <!-- Books Report -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">Books Report</h5>
      <div class="table-responsive">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>Title</th>
              <th>ISBN</th>
              <th>Publisher</th>
              <th>Publication Year</th>
              <th>Status</th>
              <th>Shelf Location</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${books}" var="book">
              <tr>
                <td>${book.title}</td>
                <td>${book.ISBNCode}</td>
                <td>${book.publisher}</td>
                <td>${book.publicationYear}</td>
                <td>
                  <span class="badge ${book.status == 'AVAILABLE' ? 'bg-success' : 'bg-danger'}">${book.status}</span>
                </td>
                <td>${book.shelf.name}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Users Report -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">Users Report</h5>
      <div class="table-responsive">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Role</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${users}" var="user">
              <tr>
                <td>${user.firstName} ${user.lastName}</td>
                <td>${user.username}</td>
                <td>${user.role}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Rooms Report -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">Rooms Report</h5>
      <div class="table-responsive">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>Room ID</th>
              <th>Room Code</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${rooms}" var="room">
              <tr>
                <td>${room.id}</td>
                <td>${room.roomCode}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Shelves Report -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">Shelves Report</h5>
      <div class="table-responsive">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>Shelf Name</th>
              <th>Room</th>
              <th>Capacity</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${shelves}" var="shelf">
              <tr>
                <td>${shelf.name}</td>
                <td>${shelf.room.roomCode}</td>
                <td>${shelf.initialStock}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<%@ include file="common/footer.jsp" %>
