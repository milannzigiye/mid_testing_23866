<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>

<c:set var="pageTitle" value="Book Management" scope="request" />
<c:set var="currentPage" value="books" scope="request" />
<%@ include file="common/header.jsp" %>

<div class="container mt-4 mb-5 pb-5">
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

  <!-- Add Book Card -->
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Add New Book</h5>
    </div>
    <div class="card-body">
      <form action="book_servlet" method="post">
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="title" class="form-label">Title</label>
              <input type="text" class="form-control" id="title" name="title" required />
            </div>
            <div class="mb-3">
              <label for="author" class="form-label">Author</label>
              <input type="text" class="form-control" id="author" name="author" required />
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="isbn" class="form-label">ISBN</label>
              <input type="text" class="form-control" id="isbn" name="isbn" required />
            </div>
            <div class="mb-3">
              <label for="publicationYear" class="form-label">Publication Year</label>
              <input type="number" class="form-control" id="publicationYear" name="publicationYear" required />
            </div>
          </div>
          <div class="col-12">
            <div class="mb-3">
              <label for="shelf" class="form-label">Select Shelf</label>
              <select class="form-select" id="shelf" name="shelfId" required>
                <option value="">Choose a shelf...</option>
                <c:forEach items="${shelves}" var="shelf">
                  <c:if test="${shelf.availableStock > 0}">
                    <option value="${shelf.id}">
                      ${shelf.name} (${shelf.room.roomCode}) - Available: ${shelf.availableStock}
                    </option>
                  </c:if>
                </c:forEach>
              </select>
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">Add Book</button>
      </form>
    </div>
  </div>

  <!-- Books List -->
  <div class="card">
    <div class="card-header bg-primary text-white">
      <h5 class="mb-0">Book List</h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Title</th>
              <th>Author</th>
              <th>ISBN</th>
              <th>Publication Year</th>
              <th>Shelf</th>
              <th>Room</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${books}" var="book">
              <tr>
                <td>${book.title}</td>
                <td>${book.publisher}</td>
                <td>${book.ISBNCode}</td>
                <td>${book.publicationYear}</td>
                <td>${book.shelf.name}</td>
                <td>${book.shelf.room.roomCode}</td>
                <td>
                  <span class="badge bg-${book.status eq 'AVAILABLE' ? 'success' : 'danger'}"> ${book.status} </span>
                </td>
                <td>
                  <button class="btn btn-danger btn-sm" onclick="deleteBook('${book.id}')">
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
  function deleteBook(bookId) {
    if (confirm("Are you sure you want to delete this book?")) {
      fetch("book_servlet?id=" + bookId, {
        method: "DELETE",
      }).then((response) => {
        if (response.ok) {
          window.location.reload();
        } else {
          alert("Error deleting book");
        }
      });
    }
  }
</script>

<%@ include file="common/footer.jsp" %>
