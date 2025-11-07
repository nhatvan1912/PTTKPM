<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.garaman.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String role = user.getRole().name();
%>
<!DOCTYPE html>
<html>
<head>
    <title>GaraMan - Home</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f0f2f5; }
        .header { background: #007BFF; color: white; padding: 5px 30px; display: flex; justify-content: space-between; align-items: center; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
        .container { max-width: 1000px; margin: 50px auto; text-align: center; }
        .btn { padding: 20px 40px; margin: 15px; font-size: 18px; cursor: pointer; background: #28a745; color: white; border: none; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.2); transition: all 0.3s; }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.3); }
        .btn-secondary { background: #17a2b8; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px; }
    </style>
</head>
<body>
<div class="header">
    <h1>🚗 GaraMan System</h1>
    <div class="user-info">
        <span><b><%= user.getFullName() %></b> <span class="badge"><%= role %></span></span>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Welcome, <%= user.getFullName() %>!</h2>
    <p>Select a module:</p>

    <button class="btn" onclick="location.href='serviceAndPart'">
        🔍 Search Service & Spare Parts
    </button>

    <% if ("WAREHOUSE_STAFF".equals(role)) { %>
        <button class="btn btn-secondary" onclick="location.href='importPart'">
            📦 Import Spare Parts
        </button>
    <% } %>
</div>
</body>
</html>