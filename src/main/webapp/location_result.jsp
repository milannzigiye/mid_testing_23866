<%@ include file="common/header.jsp" %> <%-- Authentication and Role Check --%>
<c:if test="${empty sessionScope.user}">
  <c:redirect url="/login_servlet" />
</c:if>

<c:set var="pageTitle" value="Location Search" scope="request" />
<c:set var="currentPage" value="location" scope="request" />

<div class="container mt-4">
  <!-- Search Form Card -->
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Phone Number Location Search</h5>
      <form action="location" method="get" class="row g-3">
        <div class="col-md-6">
          <div class="input-group">
            <input
              type="text"
              class="form-control"
              id="phoneNumber"
              name="phoneNumber"
              placeholder="Enter phone number..."
              required
            />
            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Search</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- Result Card -->
  <c:if test="${not empty province}">
    <div class="card mt-4">
      <div class="card-body">
        <h5 class="card-title">Search Result</h5>
        <p class="card-text">Province: ${province}</p>
      </div>
    </div>
  </c:if>
</div>

<%@ include file="common/footer.jsp" %>
