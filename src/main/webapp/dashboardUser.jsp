<%@ page import="java.util.List" %>
<%@ page import="org.exampl.municipalitdivision.DTO.ComplainDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --gray: #6c757d;
            --light-gray: #e9ecef;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            color: #333;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .navbar-brand i {
            color: var(--primary);
        }

        .stat-card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .stat-card .card-body {
            padding: 1.5rem;
        }

        .stat-icon {
            font-size: 2rem;
            opacity: 0.8;
        }

        .badge-status {
            padding: 0.35em 0.65em;
            font-weight: 500;
            border-radius: 50px;
            font-size: 0.75rem;
            text-transform: capitalize;
        }

        .badge-pending {
            background-color: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .badge-processing {
            background-color: rgba(72, 149, 239, 0.1);
            color: var(--info);
        }

        .badge-resolved {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .badge-rejected {
            background-color: rgba(249, 65, 68, 0.1);
            color: var(--danger);
        }

        .complaint-card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
            overflow: hidden;
            background-color: white;
        }

        .complaint-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        .complaint-card .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .complaint-card .card-body {
            padding: 1.5rem;
        }

        .complaint-card .card-footer {
            background-color: white;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            padding: 1rem 1.5rem;
        }

        .complaint-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark);
        }

        .complaint-meta {
            font-size: 0.85rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
        }

        .complaint-description {
            color: var(--gray);
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .complaint-actions .btn {
            padding: 0.375rem 0.75rem;
            font-size: 0.85rem;
            border-radius: 8px;
        }

        .category-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .category-icon i {
            font-size: 1.25rem;
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
            color: var(--gray);
        }

        .search-box {
            position: relative;
            max-width: 400px;
        }

        .search-box input {
            padding-left: 2.5rem;
            border-radius: 8px;
            border: 1px solid var(--light-gray);
        }

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            border-radius: 8px;
            padding: 0.5rem 1.25rem;
            font-weight: 500;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .filter-btn {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            margin-right: 0.5rem;
            border: 1px solid var(--light-gray);
            background-color: white;
        }

        .filter-btn.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .modal-content {
            border-radius: 12px;
            border: none;
        }

        .modal-header {
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .modal-footer {
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        .detail-item {
            margin-bottom: 1rem;
        }

        .detail-label {
            font-weight: 500;
            color: var(--gray);
            margin-bottom: 0.25rem;
            font-size: 0.9rem;
        }

        .detail-value {
            font-size: 1rem;
            color: var(--dark);
        }

        .attachment-thumb {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            background-color: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            margin-bottom: 1rem;
        }

        .attachment-thumb i {
            font-size: 1.5rem;
            color: var(--gray);
        }

        .empty-state {
            text-align: center;
            padding: 3rem 0;
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--light-gray);
            margin-bottom: 1rem;
        }

        .empty-state h4 {
            color: var(--gray);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--gray);
            margin-bottom: 1.5rem;
        }

        .top-bar {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            padding: 1rem 0;
            margin-bottom: 1.5rem;
            border-radius: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .stat-card {
                margin-bottom: 1rem;
            }

            .search-box {
                max-width: 100%;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Top Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-exclamation"></i> CMS
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                        <i class="bi bi-plus-circle me-1"></i> New Complaint
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <div class="user-avatar">
                            <%= session.getAttribute("userName").toString().charAt(0) %>
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/MunicipalITDivision_war_exploded/signin.jsp"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">
    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-6 col-lg-3">
            <div class="stat-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase text-muted mb-2">Pending</h6>
                            <h3 class="mb-0">
                                <% List<ComplainDTO> allComplaints = (List<ComplainDTO>) session.getAttribute("complaints");%>
                                <%= allComplaints != null ? allComplaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("pending")).count() : 0 %>
                            </h3>
                        </div>
                        <div class="stat-icon text-warning">
                            <i class="bi bi-hourglass"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="stat-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase text-muted mb-2">Processing</h6>
                            <h3 class="mb-0">
                                <%= allComplaints != null ? allComplaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("processing")).count() : 0 %>
                            </h3>
                        </div>
                        <div class="stat-icon text-info">
                            <i class="bi bi-gear"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="stat-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase text-muted mb-2">Resolved</h6>
                            <h3 class="mb-0">
                                <%= allComplaints != null ? allComplaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("resolved")).count() : 0 %>
                            </h3>
                        </div>
                        <div class="stat-icon text-success">
                            <i class="bi bi-check-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="stat-card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase text-muted mb-2">Rejected</h6>
                            <h3 class="mb-0">

                                <%= allComplaints != null ? allComplaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("rejected")).count() : 0 %>
                            </h3>
                        </div>
                        <div class="stat-icon text-danger">
                            <i class="bi bi-x-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Complaint List Section -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="mb-0">My Complaints</h4>
                        <div class="d-flex">
                            <div class="search-box me-3">
                                <i class="bi bi-search"></i>
                                <input type="text" class="form-control" placeholder="Search complaints...">
                            </div>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                                <i class="bi bi-plus-lg me-1"></i> New Complaint
                            </button>
                        </div>
                    </div>

                    <!-- Filter Buttons -->
                    <div class="mb-4">
                        <button class="filter-btn active" data-filter="all">All</button>
                        <button class="filter-btn" data-filter="pending">Pending</button>
                        <button class="filter-btn" data-filter="processing">Processing</button>
                        <button class="filter-btn" data-filter="resolved">Resolved</button>
                        <button class="filter-btn" data-filter="rejected">Rejected</button>
                    </div>

                    <!-- Complaints List -->
                    <div class="row" id="complaintsContainer">
                        <%
                            System.out.println("dashboard : " + allComplaints);
                            if (allComplaints != null && !allComplaints.isEmpty()) {
                                for (ComplainDTO complainDTO : allComplaints) {
                                    String status = complainDTO.getStatus().toLowerCase();
                                    String category = complainDTO.getCategory().toLowerCase();
                                    String badgeClass = "";
                                    String iconClass = "";

                                    if (status.equals("pending")) {
                                        badgeClass = "badge-pending";
                                        iconClass = "bi-hourglass";
                                    } else if (status.equals("processing")) {
                                        badgeClass = "badge-processing";
                                        iconClass = "bi-gear";
                                    } else if (status.equals("resolved")) {
                                        badgeClass = "badge-resolved";
                                        iconClass = "bi-check-circle";
                                    } else {
                                        badgeClass = "badge-rejected";
                                        iconClass = "bi-x-circle";
                                    }

                                    String categoryClass = "other";
                                    String categoryIcon = "bi-question-circle";

                                    if (category.contains("maintenance")) {
                                        categoryClass = "maintenance";
                                        categoryIcon = "bi-tools";
                                    } else if (category.contains("noise")) {
                                        categoryClass = "noise";
                                        categoryIcon = "bi-volume-up";
                                    } else if (category.contains("parking")) {
                                        categoryClass = "parking";
                                        categoryIcon = "bi-p-square";
                                    } else if (category.contains("security")) {
                                        categoryClass = "security";
                                        categoryIcon = "bi-shield-lock";
                                    }
                        %>
                        <div class="col-md-6 col-lg-4 complaint-item" data-status="<%= status %>">
                            <div class="complaint-card">
                                <div class="card-header">
                                    <div class="d-flex align-items-center">
                                        <div class="category-icon <%= categoryClass %>">
                                            <i class="bi <%= categoryIcon %>"></i>
                                        </div>
                                        <div>
                                                <span class="badge badge-status <%= badgeClass %>">
                                                    <i class="bi <%= iconClass %> me-1"></i> <%= complainDTO.getStatus() %>
                                                </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h5 class="complaint-title"><%= complainDTO.getObject() %></h5>
                                    <div class="complaint-meta">
                                        <span><i class="bi bi-calendar me-1"></i> <%= complainDTO.getDate() %></span>
                                        <%if(complainDTO.getLastUpdate()!=null){ %>
                                        <span><i class="bi bi-calendar me-1"></i> Last Updated Date : <%= complainDTO.getLastUpdate() %></span>
                                        <%  }
                                        %>
                                        <span class="ms-2"><i class="bi bi-tag me-1"></i> <%= complainDTO.getCategory() %></span>
                                    </div>
                                    <p class="complaint-description"><%= complainDTO.getDescription() %></p>
<%--                                    newly added--%>
                                    <div class="mb-3">
                                        <h6 class="text-muted">Admin Comments</h6>
                                        <% if (complainDTO.getComment() != null && !complainDTO.getComment().isEmpty()) { %>
                                        <div class="comment-bubble">
                                            <p class="complaint-description">
                                                <%= complainDTO.getComment() %>
                                            </p>

                                        </div>
                                        <% } else { %>
                                        <p class="complaint-description">No comments yet</p>
                                        <% } %>
                                    </div>
<%--                                    //end--%>
                                </div>
                                <div class="card-footer">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-muted small">ID: <%= complainDTO.getComplainId() %></span>
                                        <div class="complaint-actions">
                                            <button class="btn btn-sm btn-outline-primary me-1"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#complaintDetailModal"
                                                    data-id="<%= complainDTO.getComplainId() %>"
                                                    data-subject="<%= complainDTO.getObject() %>"
                                                    data-category="<%= complainDTO.getCategory() %>"
                                                    data-date="<%= complainDTO.getDate() %>"
                                                    data-status="<%= complainDTO.getStatus() %>"
                                                    data-comment="<%= complainDTO.getComment()!=null?complainDTO.getComment():"" %>"
                                                    data-description="<%= complainDTO.getDescription() %>">
                                                <i class="bi bi-eye"></i> View
                                            </button>
                                            <% if (!status.equals("resolved") && !status.equals("rejected")) { %>
                                            <button class="btn btn-sm btn-outline-warning me-1"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editComplaintModal"
                                                    data-id="<%= complainDTO.getComplainId() %>"
                                                    data-subject="<%= complainDTO.getObject() %>"
                                                    data-category="<%= complainDTO.getCategory() %>"
                                                    data-date="<%= complainDTO.getDate() %>"
                                                    data-status="<%= complainDTO.getStatus() %>"
                                                    data-description="<%= complainDTO.getDescription() %>">
                                                <i class="bi bi-pencil"></i> Edit
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#deleteComplaintModal"
                                                    data-id="<%= complainDTO.getComplainId() %>">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}
                        } else { %>
                        <div class="col-12">
                            <div class="empty-state">
                                <i class="bi bi-inbox"></i>
                                <h4>No complaints found</h4>
                                <p>You haven't submitted any complaints yet.</p>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newComplaintModal">
                                    <i class="bi bi-plus-lg me-1"></i> Create New Complaint
                                </button>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Complaint Detail Modal -->
<div class="modal fade" id="complaintDetailModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Complaint Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Complaint ID</div>
                            <div class="detail-value" id="detail-id"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Subject</div>
                            <div class="detail-value" id="detail-subject"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Category</div>
                            <div class="detail-value" id="detail-category"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="detail-item">
                            <div class="detail-label">Date Submitted</div>
                            <div class="detail-value" id="detail-date"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Status</div>
                            <div class="detail-value">
                                <span class="badge-status" id="detail-status-badge"></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">Description</div>
                    <div class="detail-value">
                        <div class="card bg-light p-3">
                            <p id="detail-description"></p>
                        </div>
                    </div>
                </div>
<%--                newly added--%>
                <div class="detail-item">
                    <div class="detail-label">Comment</div>
                    <div class="detail-value">
                        <div class="card bg-light p-3">
                            <p id="detail-comment" aria-readonly="true"></p>
                        </div>
                    </div>
                </div>
<%--                end--%>
                <div class="detail-item">
                    <div class="detail-label">Attachments</div>
                    <div class="detail-value">
                        <div class="d-flex flex-wrap">
                            <div class="attachment-thumb">
                                <i class="bi bi-file-earmark-text"></i>
                            </div>
                            <div class="attachment-thumb">
                                <i class="bi bi-image"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="detail-edit-btn">Edit</button>
                <button type="button" class="btn btn-danger" id="detail-delete-btn">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- New Complaint Modal (Keep your existing modal) -->
<div class="modal fade" id="newComplaintModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">New Complaint</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="newComplaintForm" action="<%=request.getContextPath()%>/dashboardUser" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Subject</label>
                        <input type="text" class="form-control" name="subject" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <select class="form-select" name="category" required>
                            <option value="">Select category</option>
                            <option>Maintenance</option>
                            <option>Noise</option>
                            <option>Parking</option>
                            <option>Security</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" rows="4" name="description" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Attachment (Optional)</label>
                        <input type="file" class="form-control" name="attachment">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" name="action" value="save" onclick="clicked()">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Complaint Modal (Keep your existing modal) -->
<%--<div class="modal fade" id="editComplaintModal" tabindex="-1">--%>
    <div class="modal fade" id="editComplaintModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Complaint</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editComplaintForm" action="<%=request.getContextPath()%>/dashboardUser" method="POST">
                        <input type="hidden" name="complaintId" id="edit-complaint-id">
                        <div class="mb-3">
                            <label class="form-label">Compain ID :</label>
                            <input type="text" class="form-control" name="compainId" id="edit-id" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Subject</label>
                            <input type="text" class="form-control" name="subject" id="edit-subject" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="category" id="edit-category" required>
                                <option value="">Select category</option>
                                <option>Maintenance</option>
                                <option>Noise</option>
                                <option>Parking</option>
                                <option>Security</option>
                                <option>Other</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="4" name="description" id="edit-description" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Current Attachment</label>
                            <div class="d-flex align-items-center">
                                <i class="bi bi-file-earmark-image fs-4 me-2"></i>
                                <span>leakage_photo.jpg</span>
                                <button class="btn btn-sm btn-outline-danger ms-2">
                                    <i class="bi bi-trash"></i> Remove
                                </button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">New Attachment (Optional)</label>
                            <input type="file" class="form-control" name="attachment">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" name="action" value="update">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<!-- Delete Complaint Modal (Keep your existing modal) -->
<div class="modal fade" id="deleteComplaintModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Delete Complaint</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this complaint?</p>
                <p><strong>ID:</strong> <span id="delete-complaint-id"></span></p>
                <p><strong>Subject:</strong> <span id="delete-complaint-subject"></span></p>
<%--                <p class="text-danger">This action cannot be undone.</p>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a id="delete-link" href="#">
                    <button type="button" class="btn btn-danger" id="confirm-delete">Delete</button>
                </a>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize modals and set up event listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Complaint Detail Modal
        const detailModal = document.getElementById('complaintDetailModal');
        if (detailModal) {
            detailModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const subject = button.getAttribute('data-subject');
                const category = button.getAttribute('data-category');
                const date = button.getAttribute('data-date');
                const status = button.getAttribute('data-status');
                const description = button.getAttribute('data-description');
                const comment=button.getAttribute('data-comment');

                document.getElementById('detail-id').textContent = id;
                document.getElementById('detail-subject').textContent = subject;
                document.getElementById('detail-category').textContent = category;
                document.getElementById('detail-date').textContent = date;
                document.getElementById('detail-description').textContent = description;
                document.getElementById('detail-comment').textContent = comment;
                console.log(id, subject, category, date, status)

                // Set status badge
                const statusBadge = document.getElementById('detail-status-badge');
                statusBadge.textContent = status;
                statusBadge.className = 'badge-status ';

                if (status.toLowerCase() === 'pending') {
                    statusBadge.classList.add('badge-pending');
                    statusBadge.innerHTML = '<i class="bi bi-hourglass me-1"></i>' + status;
                } else if (status.toLowerCase() === 'processing') {
                    statusBadge.classList.add('badge-processing');
                    statusBadge.innerHTML = '<i class="bi bi-gear me-1"></i>' + status;
                } else if (status.toLowerCase() === 'resolved') {
                    statusBadge.classList.add('badge-resolved');
                    statusBadge.innerHTML = '<i class="bi bi-check-circle me-1"></i>' + status;
                } else {
                    statusBadge.classList.add('badge-rejected');
                    statusBadge.innerHTML = '<i class="bi bi-x-circle me-1"></i>' + status;
                }


            });
        }
        // Set up edit and delete buttons
        document.getElementById('detail-edit-btn').onclick = function() {
            // Find the edit button for this complaint and click it
            const editBtn = document.querySelector(`button[data-bs-target="#editComplaintModal"][data-id="${id}"]`);
            if (editBtn) editBtn.click();
        };
        // Edit Complaint Modal
        // Edit Complaint Modal

        document.getElementById('detail-delete-btn').onclick = function() {
            // Find the delete button for this complaint and click it
            const deleteBtn = document.querySelector(`button[data-bs-target="#deleteComplaintModal"][data-id="${id}"]`);
            if (deleteBtn) deleteBtn.click();
        };
        // Edit Complaint Modal
        const editModal = document.getElementById('editComplaintModal');
        if (editModal) {
            editModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const subject = button.getAttribute('data-subject');
                const category = button.getAttribute('data-category');
                const description = button.getAttribute('data-description');

                console.log('Edit complaint id', id, subject, category, description);
                // Set the form values
                const form = editModal.querySelector('form');
                form.querySelector('input[name="compainId"]').value = id;
                form.querySelector('input[name="subject"]').value = subject;
                form.querySelector('select[name="category"]').value = category;
                form.querySelector('textarea[name="description"]').value = description;

                // You can store the complaint ID in a hidden field if needed for submission
                // form.querySelector('input[name="complaintId"]')?.value = id;
            });
        }
        // Delete Complaint Modal
        const deleteModal = document.getElementById('deleteComplaintModal');
        if (deleteModal) {
            deleteModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const complaintCard = button.closest('.complaint-card');
                const subject = complaintCard ? complaintCard.querySelector('.complaint-title').textContent : '';

                document.getElementById('delete-complaint-id').textContent = id;
                document.getElementById('delete-complaint-subject').textContent = subject;

                // Set up confirm delete button
                document.getElementById('confirm-delete').onclick = function() {
                    // In a real app, you would make an AJAX call or form submission here
                    alert(`Complaint ${id} would be deleted in a real application`);
                    const modal = bootstrap.Modal.getInstance(deleteModal);
                    modal.hide();

                    // Remove the complaint card from the UI
                    if (complaintCard) {
                        complaintCard.closest('.complaint-item').remove();
                    }
                };

                document.getElementById('detail-edit-btn').onclick = function() {
                    // Find the edit button for this complaint and click it
                    const editBtn = document.querySelector(`button[data-bs-target="#editComplaintModal"][data-id="${id}"]`);

                    if (editBtn) editBtn.click(  );
                };
            });
        }
        document.getElementById("confirm-delete").addEventListener("click", function () {
            var complaintId = document.getElementById("delete-complaint-id").innerText.trim();
            var deleteLink = document.getElementById("delete-link");

            // Set the href with the actual ID from the span
            deleteLink.href = "dashboardUser?deleteID=" + encodeURIComponent(complaintId);
        });
        // Filter buttons
        const filterButtons = document.querySelectorAll('.filter-btn');
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                const filter = this.getAttribute('data-filter');

                // Update active state
                filterButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');

                // Filter complaints
                const complaints = document.querySelectorAll('.complaint-item');
                complaints.forEach(complaint => {
                    if (filter === 'all' || complaint.getAttribute('data-status') === filter) {
                        complaint.style.display = 'block';
                    } else {
                        complaint.style.display = 'none';
                    }
                });
            });
        });
    });

    function clicked() {
        console.log('clicked submit');
    }
</script>
</body>
</html>