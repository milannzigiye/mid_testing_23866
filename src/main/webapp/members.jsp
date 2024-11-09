<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>
<c:set var="pageTitle" value="Members Management" scope="request" />
<c:set var="currentPage" value="members" scope="request" />
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

  <!-- Search and Filter -->
  <div class="card mb-4">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Search and Filter Members</h5>
    </div>
    <div class="card-body">
      <div class="row g-3">
        <div class="col-md-4">
          <input
            type="text"
            id="searchName"
            class="form-control"
            placeholder="Search by name..."
            onkeyup="filterMembers()"
          />
        </div>
        <div class="col-md-4">
          <select id="membershipStatus" class="form-select" onchange="filterMembers()">
            <option value="">All Membership Status</option>
            <option value="APPROVED">Approved</option>
            <option value="PENDING">Pending</option>
            <option value="REJECTED">Rejected</option>
          </select>
        </div>
      </div>
    </div>
  </div>

  <!-- Members List -->
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Members List</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Role</th>
              <th>Village</th>
              <th>Membership Code</th>
              <th>Expiry Date</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="member" items="${members}">
              <tr>
                <td>${member.user.id}</td>
                <td>${member.user.firstName} ${member.user.lastName}</td>
                <td>${member.user.role}</td>
                <td>${member.user.village.locationName}</td>
                <td>${member.membershipCode}</td>
                <td>${member.expiringDate}</td>
                <td>
                  <span
                    class="badge ${member.membershipStatus == 'APPROVED' ? 'bg-success' : member.membershipStatus == 'PENDING' ? 'bg-warning' : 'bg-danger'}"
                  >
                    ${member.membershipStatus}
                  </span>
                </td>
                <td>
                  <button
                    class="btn btn-primary btn-sm"
                    onclick="showStatusUpdateForm('${member.id}', '${member.membershipStatus}')"
                  >
                    <i class="fas fa-edit"></i> Update Status
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

<!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Update Member Status</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form id="updateStatusForm" action="membership_servlet" method="post">
          <input type="hidden" id="memberId" name="memberId" />
          <div class="mb-3">
            <label for="newStatus" class="form-label">New Status</label>
            <select class="form-select" id="newStatus" name="newStatus" required>
              <option value="APPROVED">Approved</option>
              <option value="PENDING">Pending</option>
              <option value="REJECTED">Rejected</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="updateMemberStatus()">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
  function filterMembers() {
    const searchText = document.getElementById("searchName").value.toLowerCase();
    const statusFilter = document.getElementById("membershipStatus").value;
    const rows = document.querySelectorAll("table tbody tr");

    rows.forEach((row) => {
      const name = row.querySelector("td:nth-child(2)").textContent.toLowerCase();
      const status = row.querySelector("td:nth-child(7)").textContent.trim();

      const nameMatch = name.includes(searchText);
      const statusMatch = !statusFilter || status === statusFilter;

      row.style.display = nameMatch && statusMatch ? "" : "none";
    });
  }

  function showStatusUpdateForm(memberId, currentStatus) {
    document.getElementById("memberId").value = memberId;
    document.getElementById("newStatus").value = currentStatus;
    new bootstrap.Modal(document.getElementById("updateStatusModal")).show();
  }

  function updateMemberStatus() {
    document.getElementById("updateStatusForm").submit();
  }
</script>

<%@ include file="common/footer.jsp" %>
