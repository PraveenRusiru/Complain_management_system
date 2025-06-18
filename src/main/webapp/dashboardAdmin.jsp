<%@ page import="java.util.List" %>
<%@ page import="org.exampl.municipalitdivision.DTO.ComplainDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Complaint Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --info: #4895ef;
            --warning: #f8961e;
            --danger: #f94144;
            --light: #f8f9fa;
            --dark: #212529;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
        }

        .stat-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .complaint-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .complaint-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .badge-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 500;
        }

        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-processing {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .badge-resolved {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .comment-bubble {
            background-color: #f1f1f1;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 10px;
            position: relative;
        }

        .comment-bubble:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 20px;
            border-width: 10px 10px 0;
            border-style: solid;
            border-color: #f1f1f1 transparent;
        }

        .admin-actions {
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .category-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }

        .maintenance {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .noise {
            background-color: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .parking {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .security {
            background-color: rgba(249, 65, 68, 0.1);
            color: var(--danger);
        }

        .other {
            background-color: rgba(108, 117, 125, 0.1);
            color: #6c757d;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-exclamation"></i> Admin Dashboard
        </a>
        <div class="d-flex">
                <span class="navbar-text me-3">
                    Welcome, <%= session.getAttribute("userName") %>
                </span>
            <a href="/MunicipalITDivision_war_exploded/signin.jsp" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="stat-card h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-2">Total Complaints</h6>
                            <h3 class="mb-0">
                                <% List<ComplainDTO> allComplaints =(List<ComplainDTO>)session.getAttribute("complaints");
                                    System.out.println("dashboardAdmin "+allComplaints.size());
                                %>
                                <%=allComplaints.size() %>
                            </h3>
                        </div>
                        <i class="bi bi-list-check fs-3 text-primary"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="stat-card h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-2">Pending</h6>
                            <h3 class="mb-0">
                                <%= ((List<ComplainDTO>)session.getAttribute("complaints")).stream()
                                        .filter(c -> c.getStatus().equalsIgnoreCase("pending")).count() %>
                            </h3>
                        </div>
                        <i class="bi bi-hourglass fs-3 text-warning"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="stat-card h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-2">Processing</h6>
                            <h3 class="mb-0">
                                <%= ((List<ComplainDTO>)session.getAttribute("complaints")).stream()
                                        .filter(c -> c.getStatus().equalsIgnoreCase("processing")).count() %>
                            </h3>
                        </div>
                        <i class="bi bi-gear fs-3 text-info"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3 mb-3">
            <div class="stat-card h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted mb-2">Resolved</h6>
                            <h3 class="mb-0">
                                <%= ((List<ComplainDTO>)session.getAttribute("complaints")).stream()
                                        .filter(c -> c.getStatus().equalsIgnoreCase("resolved")).count() %>
                            </h3>
                        </div>
                        <i class="bi bi-check-circle fs-3 text-success"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" placeholder="Search complaints...">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="btn-group float-end">
                        <button class="btn btn-outline-secondary active">All</button>
                        <button class="btn btn-outline-secondary">Pending</button>
                        <button class="btn btn-outline-secondary">Processing</button>
                        <button class="btn btn-outline-secondary">Resolved</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Complaints Cards -->
    <div class="row">
        <% List<ComplainDTO> complaints = (List<ComplainDTO>) session.getAttribute("complaints");
            for (ComplainDTO complaint : complaints) {
                String statusClass = "";
                if (complaint.getStatus().equalsIgnoreCase("pending")) {
                    statusClass = "badge-pending";
                } else if (complaint.getStatus().equalsIgnoreCase("processing")) {
                    statusClass = "badge-processing";
                } else if (complaint.getStatus().equalsIgnoreCase("resolved")) {
                    statusClass = "badge-resolved";
                } else {
                    statusClass = "badge-rejected";
                }

                String categoryClass = "other";
                String categoryIcon = "bi-question-circle";
                if (complaint.getCategory().contains("Maintenance")) {
                    categoryClass = "maintenance";
                    categoryIcon = "bi-tools";
                } else if (complaint.getCategory().contains("Noise")) {
                    categoryClass = "noise";
                    categoryIcon = "bi-volume-up";
                } else if (complaint.getCategory().contains("Parking")) {
                    categoryClass = "parking";
                    categoryIcon = "bi-p-square";
                } else if (complaint.getCategory().contains("Security")) {
                    categoryClass = "security";
                    categoryIcon = "bi-shield-lock";
                }
        %>
        <div class="col-md-6 col-lg-4">
            <div class="card complaint-card">
                <div class="card-body position-relative">
                    <div class="admin-actions">
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal"
                                data-bs-target="#updateStatusModal"
                                data-id="<%= complaint.getComplainId() %>">
                            <i class="bi bi-pencil-square"></i> Update
                        </button>
                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal"
                                data-bs-target="#deleteModal"
                                data-id="<%= complaint.getComplainId() %>">
                            <i class="bi bi-trash"></i>
                        </button>
                    </div>

                    <div class="d-flex align-items-center mb-3">
                        <div class="category-icon <%= categoryClass %>">
                            <i class="bi <%= categoryIcon %>"></i>
                        </div>
                        <div>
                            <h5 class="card-title mb-0"><%= complaint.getObject() %></h5>
                            <span class="badge <%= statusClass %>"><%= complaint.getStatus() %></span>
                        </div>
                    </div>

                    <p class="card-text"><%= complaint.getDescription() %></p>

                    <div class="d-flex justify-content-between text-muted small mb-3">
                        <span><i class="bi bi-person"></i> <%= complaint.getUserId() %></span>
                        <span><i class="bi bi-calendar"></i> <%= complaint.getDate() %></span>
                    </div>

                    <!-- Comments Section -->
                    <div class="mb-3">
                        <h6 class="text-muted">Admin Comments</h6>
                        <% if (complaint.getComment() != null && !complaint.getComment().isEmpty()) { %>
                        <div class="comment-bubble">
                            <%= complaint.getComment() %>
                        </div>
                        <% } else { %>
                        <p class="text-muted small">No comments yet</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Complaint Status</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%=request.getContextPath()%>/dashboardAdmin" method="POST">
                <input type="hidden" name="complaintId" id="update-complaint-id">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" name="status" required>
                            <option value="pending">Pending</option>
                            <option value="processing">Processing</option>
                            <option value="resolved">Resolved</option>
                            <option value="rejected">Rejected</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Admin Comments</label>
                        <textarea class="form-control" name="comments" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" name="action" value="update" class="btn btn-primary"  >Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Delete Complaint</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="deleteComplaint" method="POST">
<%--                <input type="hidden" name="complaintId" id="delete-complaint-id">--%>
                <div class="modal-body">
                    <p>Are you sure you want to delete this complaint?</p>
                    <p><strong>ID:</strong> <span id="delete-complaint-id"></span></p>
                    <p class="text-danger">This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                   <a id="delete-link" href="#">
                       <button type="button" id="confirm-delete" class="btn btn-danger">Delete</button>
                   </a>

                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Update Status Modal
    const updateStatusModal = document.getElementById('updateStatusModal');
    if (updateStatusModal) {
        updateStatusModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const complaintId = button.getAttribute('data-id');
            document.getElementById('update-complaint-id').value = complaintId;
        });
    }

    // Delete Modal
    const deleteModal = document.getElementById('deleteModal');
    if (deleteModal) {
        deleteModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const complaintId = button.getAttribute('data-id');
            console.log("delete btn id ",complaintId)
            document.getElementById('delete-complaint-id').textContent = complaintId;
        });
    }

    document.getElementById("confirm-delete").addEventListener("click", function () {
        var complaintId = document.getElementById("delete-complaint-id").innerText.trim();
        console.log(complaintId);
        var deleteLink = document.getElementById("delete-link");

        // Set the href with the actual ID from the span
        deleteLink.href = "dashboardAdmin?deleteID=" + encodeURIComponent(complaintId);
    });
</script>
</body>
</html>