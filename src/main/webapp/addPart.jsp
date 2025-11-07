<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.garaman.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String role = user.getRole().name();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Spare Part</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f5f7fa; }
        .header { background: #007BFF; color: #fff; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px;}

        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
        .frame { border: 2px solid #007BFF; border-radius: 10px; padding: 20px; background: #fff; max-width: 600px; margin: 20px auto; width: 90%}
        h2 { color: #007BFF; text-align: center; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input, button { width: 100%; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px; }
        .btn { margin-top: 15px; padding: 10px; font-size: 16px; font-weight: bold; cursor: pointer; }
        .btn-confirm { background: #28a745; color: white; }
        .btn-cancel { background: #dc3545; color: white; }
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

<div class="frame">
    <h2>Add Spare Part</h2>
    <form method="post" action="addPart">
        <label>Name</label>
        <input type="text" name="name" required>
        <label>Quantity</label>
        <input type="number" name="quantity" min="1" required>
        <label>Unit Price</label>
        <input type="number" name="unitPrice" step="0.01" required>
        <label>Sell Price</label>
        <input type="number" name="sellPrice" step="0.01" required>
        <button type="submit" class="btn btn-confirm">Save Spare Part</button>
        <button type="button" class="btn btn-cancel" onclick="history.back()">Cancel</button>
    </form>
</div>
</body>
</html>