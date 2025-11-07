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
    <title>Service Detail</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f5f7fa; }
        .header { background: #007BFF; color: #fff; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px;}
        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }

        .frame { max-width: 700px; width: 90%; margin: 24px auto; background: #fff; border: 2px solid #007BFF; border-radius: 10px; padding: 22px; }
        .frame h2 { color: #007BFF; margin-top: 0; }
        .row { margin: 10px 0; }
        .label { font-weight: bold; }
        .btn { display: inline-block; margin-top: 14px; padding: 8px 14px; background: #0d6efd; color: #fff; border: none; border-radius: 6px; text-decoration: none; cursor: pointer; }
        .btn:hover { background: #0b5ed7; }
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
    <h2>Service Detail</h2>

    <c:if test="${empty service}">
        <p>Service not found.</p>
    </c:if>
    <c:if test="${not empty service}">
        <div class="row"><span class="label">ID:</span> ${service.idService}</div>
        <div class="row"><span class="label">Service name:</span> ${service.name}</div>
        <div class="row"><span class="label">Description:</span> ${service.description}</div>
        <div class="row"><span class="label">Price:</span> ${service.price.intValue()} VND</div>

        <a class="btn" href="serviceAndPart">Return list</a>
    </c:if>
</div>
</body>
</html>