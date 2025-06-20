# 🏢 Complaint Management System

A full-stack web application built using **JSP**, **Servlets**, and **MySQL**, designed to manage and track public complaints. The system features user registration/login, complaint submission, editing, deletion, and admin-level monitoring.

---

## 📌 Features

- 🔐 **User Authentication**: Secure sign-up and login flow.
- 📝 **Complaint Submission**: Users can add complaints with a subject, category, description, and optional file attachment.
- 🎯 **Role-Based Dashboards**:
  - **User Dashboard**: View and manage personal complaints.
  - **Admin Dashboard**: View all complaints and update statuses.
- 📊 **Dynamic UI**: Responsive, styled with Bootstrap 5.
- ⚡ **Form Validation**: Both client-side and server-side validation for username, email, and password.
- 🔁 **Connection Pooling**: Managed using Apache DBCP for better performance.

---

## 🧱 Tech Stack

| Layer             | Technology                         |
|------------------|------------------------------------|
| **Backend**       | Java (Servlets, JSP)               |
| **Frontend**      | HTML, CSS, Bootstrap, JavaScript   |
| **Database**      | MySQL                              |
| **Connection Pool** | Apache DBCP                     |
| **Server**        | Apache Tomcat                      |
| **IDE**           | IntelliJ IDEA                      |

---

## 🚀 Getting Started

### Prerequisites

- Java 17+ (or compatible version)
- Apache Tomcat 10+
- MySQL Server
- IntelliJ IDEA or any Java IDE
- Maven (if using)

---

### 🛠️ Configuration Steps

1. **Clone the Repository**
   
   git clone https://github.com/your-username/complaint-management-system.git
2.Change the credentials
   ds.setUrl("jdbc:mysql://localhost:3306/complaint_db");
ds.setUsername("your_mysql_username");
ds.setPassword("your_mysql_password");
