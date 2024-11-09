<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'LIBRARIAN'}">
  <c:redirect url="/login.jsp" />
</c:if>

<c:set var="pageTitle" value="Membership Types Management" scope="request" />
<c:set var="currentPage" value="membership-types" scope="request" />
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

    <!-- Create Form -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Create New Membership Type</h5>
        </div>
        <div class="card-body">
            <form action="membership_type_servlet" method="post">
                <input type="hidden" name="action" value="create">
                <div class="row">
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Name:</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Max Books:</label>
                            <input type="number" name="maxBooks" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="mb-3">
                            <label class="form-label">Price:</label>
                            <input type="number" name="price" class="form-control" required>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Create</button>
            </form>
        </div>
    </div>

    <!-- List -->
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Membership Types List</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Max Books</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="type" items="${membershipTypes}">
                            <tr>
                                <td>${type.id}</td>
                                <td>${type.name}</td>
                                <td>${type.maxBooks}</td>
                                <td>${type.price}</td>
                                <td>
                                    <button class="btn btn-primary btn-sm" onclick="showUpdateForm('${type.id}', '${type.name}', '${type.maxBooks}', '${type.price}')">
                                        <i class="fas fa-edit"></i> Update
                                    </button>
                                    <form action="membership_type_servlet" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${type.id}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Membership Type</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="membership_type_servlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="updateId">
                    <div class="mb-3">
                        <label class="form-label">Name:</label>
                        <input type="text" name="name" id="updateName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Max Books:</label>
                        <input type="number" name="maxBooks" id="updateMaxBooks" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price:</label>
                        <input type="number" name="price" id="updatePrice" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function showUpdateForm(id, name, maxBooks, price) {
        document.getElementById('updateId').value = id;
        document.getElementById('updateName').value = name;
        document.getElementById('updateMaxBooks').value = maxBooks;
        document.getElementById('updatePrice').value = price;
        new bootstrap.Modal(document.getElementById('updateModal')).show();
    }
</script>

<%@ include file="common/footer.jsp" %> 