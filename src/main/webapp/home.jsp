<%@ include file="common/header.jsp" %> <%-- Authentication and Role Check --%>
<c:if test="${empty sessionScope.user || (sessionScope.user.role != 'STUDENT' && sessionScope.user.role != 'TEACHER')}">
  <c:redirect url="/login_servlet" />
</c:if>
<c:set var="pageTitle" value="Home" scope="request" />
<c:set var="currentPage" value="home" scope="request" />
<div class="container mt-4">
  <!-- Error Message Display -->
  <c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      ${sessionScope.errorMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errorMessage" scope="session" />
  </c:if>

  <!-- Success Message Display -->
  <c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      ${sessionScope.successMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="successMessage" scope="session" />
  </c:if>

  <!-- Search and Filter Section -->
  <div class="card">
    <div class="card-body">
      <form action="book_search" method="GET" class="row g-3">
        <!-- Search Bar -->
        <div class="col-md-6">
          <div class="input-group">
            <input
              type="text"
              class="form-control"
              name="searchTerm"
              placeholder="Search by title, ISBN, or publisher..."
            />
            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Search</button>
          </div>
        </div>

        <!-- Filters -->
        <div class="col-md-2">
          <select class="form-select" name="status">
            <option value="">Status</option>
            <option value="AVAILABLE">AVAILABLE</option>
            <option value="BORROWED">BORROWED</option>
            <option value="RESERVED">RESERVED</option>
          </select>
        </div>
        <div class="col-md-2">
          <input type="number" class="form-control" name="year" placeholder="Publication Year" />
        </div>
      </form>
    </div>
  </div>

  <!-- Books List -->
  <div class="card mt-4">
    <div class="card-body">
      <h5 class="card-title">Available Books</h5>
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
              <th>Action</th>
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
                  <span class="badge ${book.status == 'AVAILABLE' ? 'bg-success' : 'bg-danger'}"> ${book.status} </span>
                </td>
                <td>${book.shelf.name}</td>
                <td>
                  <c:if test="${book.status == 'AVAILABLE'}">
                    <button class="btn btn-primary btn-sm" onclick="borrowBook('${book.id}', '${book.title}')">
                      <i class="fas fa-book"></i> Borrow
                    </button>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Membership Registration -->
  <div class="card mt-4">
    <div class="card-body">
      <h5 class="card-title">Membership Registration</h5>
      <button class="btn btn-success" onclick="showMembershipModal()">
        <i class="fas fa-id-card"></i> Register Membership
      </button>
    </div>
  </div>

  <!-- Membership Information -->
  <div class="card mt-4">
    <div class="card-body">
      <h5 class="card-title">Your Memberships</h5>
      <div class="table-responsive">
        <table class="table">
          <thead>
            <tr>
              <th>Membership Code</th>
              <th>Type</th>
              <th>Registration Date</th>
              <th>Expiry Date</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty memberships}">
                <tr>
                  <td colspan="5">No memberships found.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach items="${memberships}" var="membership">
                  <tr>
                    <td>${membership.membershipCode}</td>
                    <td>${membership.membershipType.name}</td>
                    <td>${membership.registrationDate}</td>
                    <td>${membership.expiringDate}</td>
                    <td>
                      <span
                        class="badge ${membership.membershipStatus == 'APPROVED' ? 'bg-success' : membership.membershipStatus == 'PENDING' ? 'bg-warning' : 'bg-danger'}"
                      >
                        ${membership.membershipStatus}
                      </span>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Borrowing Transactions -->
  <div class="card mt-4">
    <div class="card-body">
      <h5 class="card-title">Your Borrowing History</h5>
      <div class="table-responsive">
        <table class="table">
          <thead>
            <tr>
              <th>Book Title</th>
              <th>Pick Up Date</th>
              <th>Due Date</th>
              <th>Return Date</th>
              <th>Fine (RWF)</th>
              <th>Late Charges (RWF)</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty userBorrowingTransactions}">
                <tr>
                  <td colspan="8">No borrowing history found.</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach items="${userBorrowingTransactions}" var="transaction">
                  <tr>
                    <td>${transaction.book.title}</td>
                    <td>${transaction.pickDate}</td>
                    <td>${transaction.dueDate}</td>
                    <td>${transaction.returnDate != null ? transaction.returnDate : 'Not returned'}</td>
                    <td>${transaction.fine}</td>
                    <td>${transaction.lateChargeFees}</td>
                    <td>
                      <span class="badge ${transaction.returnDate == null ? 'bg-warning' : 'bg-success'}">
                        ${transaction.returnDate == null ? 'BORROWED' : 'RETURNED'}
                      </span>
                    </td>
                    <td>
                      <c:if test="${transaction.returnDate == null}">
                        <form action="home" method="POST" style="display: inline">
                          <input type="hidden" name="action" value="return_book" />
                          <input type="hidden" name="transactionId" value="${transaction.id}" />
                          <button type="submit" class="btn btn-success btn-sm">
                            <i class="fas fa-undo"></i> Return
                          </button>
                        </form>
                      </c:if>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Borrow Book Modal -->
<div class="modal fade" id="borrowModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Borrow Book</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form id="borrowForm" action="home" method="POST">
          <input type="hidden" name="action" value="borrow_book" />
          <input type="hidden" id="bookId" name="bookId" />
          <div class="mb-3">
            <label class="form-label">Book Title</label>
            <input type="text" class="form-control" id="bookTitle" name="bookTitle" readonly />
          </div>
          <div class="mb-3">
            <label class="form-label">Select a Date You Will Bring Back The Book</label>
            <input type="date" class="form-control" name="dueDate" required />
          </div>
          <button type="submit" class="btn btn-primary">Confirm Borrowing</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Membership Registration Modal -->
<div class="modal fade" id="membershipModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Register Membership</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form id="membershipForm" action="home" method="POST">
          <input type="hidden" name="action" value="register_membership" />
          <div class="mb-3">
            <label class="form-label">Membership Type</label>
            <select class="form-select" name="membershipTypeId" required>
              <c:forEach items="${membershipTypes}" var="type">
                <option value="${type.id}">
                  ${type.name} - Max Books: ${type.maxBooks} - Price: RWF ${type.price}
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Duration (months)</label>
            <select class="form-select" name="duration" required>
              <option value="3">3 months</option>
              <option value="6">6 months</option>
              <option value="9">9 months</option>
              <option value="12">12 months</option>
            </select>
          </div>
          <button type="submit" class="btn btn-primary">Register Membership</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  function borrowBook(bookId, bookTitle) {
    document.getElementById("bookId").value = bookId;
    document.getElementById("bookTitle").value = bookTitle;
    var borrowModal = new bootstrap.Modal(document.getElementById("borrowModal"));
    borrowModal.show();
  }

  function filterBooks() {
    const searchTerm = document.querySelector('input[name="searchTerm"]').value.toLowerCase();
    const statusFilter = document.querySelector('select[name="status"]').value;
    const yearFilter = document.querySelector('input[name="year"]').value;

    const rows = document.querySelectorAll("table tbody tr");

    rows.forEach((row) => {
      const title = row.cells[0].textContent.toLowerCase();
      const isbn = row.cells[1].textContent.toLowerCase();
      const publisher = row.cells[2].textContent.toLowerCase();
      const year = row.cells[3].textContent;
      const status = row.cells[4].textContent.trim();

      let showRow = true;

      // Check search term
      if (searchTerm) {
        showRow = title.includes(searchTerm) || isbn.includes(searchTerm) || publisher.includes(searchTerm);
      }

      // Check status
      if (showRow && statusFilter) {
        showRow = status.includes(statusFilter);
      }

      // Check year
      if (showRow && yearFilter) {
        showRow = year === yearFilter;
      }

      row.style.display = showRow ? "" : "none";
    });
  }

  // Update the form to use the filter function instead of submitting
  document.querySelector("form").onsubmit = (e) => {
    e.preventDefault();
    filterBooks();
  };

  // Add event listeners for real-time filtering
  document.querySelector('input[name="searchTerm"]').addEventListener("input", filterBooks);
  document.querySelector('select[name="status"]').addEventListener("change", filterBooks);
  document.querySelector('input[name="year"]').addEventListener("input", filterBooks);

  function showMembershipModal() {
    var membershipModal = new bootstrap.Modal(document.getElementById("membershipModal"));
    membershipModal.show();
  }
</script>

<%@ include file="common/footer.jsp" %>
