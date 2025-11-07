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
    <title>GaraMan - Services & Spare Parts</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f0f2f5; }
        .header { background: #007BFF; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0;}
        .user-info { display: flex; align-items: center; gap: 15px; }
        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px; }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }

        .card {
            background: #fff;
            border-radius: 10px;
            border: 2px solid #007BFF;
            padding: 20px;
            display: flex;
            flex-direction: column;
            max-height: 550px;
            min-height: 400px;
        }
        .card h2 { margin: 0 0 12px; color: #007BFF; }
        .search { margin-bottom: 12px; margin-right: 20px;}
        .search input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; }

        .table-scroll {
            flex: 1 1 auto;
            min-height: 0;
            overflow: auto;
            -webkit-overflow-scrolling: touch;
            border-radius: 6px;
            background: #ffffff;
        }

        table { width: 100%; border-collapse: collapse; }
        table td:last-child {
            text-align: center;
        }
        th, td { border: 1px solid #e5e7eb; padding: 10px; text-align: left; }
        th {
            background: #f8fafc;
            position: sticky;
            top: 0;
            padding: 12px 10px;
            z-index: 1;
        }

        .btn { padding: 6px 12px; background: #0d6efd; color: #fff; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn:hover { background: #0b5ed7; }
        .footer-actions { margin-top: 20px; display: flex; justify-content: flex-start; }
        .btn-secondary { padding: 10px 12px; }

        @media (max-width: 1100px) {
            .grid { grid-template-columns: 1fr; }
            .header h1 {font-size: 20px;}
        }
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
    <div class="grid">
        <!-- Service List -->
        <div class="card">
            <h2>Service List</h2>
            <div class="search">
                <input id="serviceSearch" type="text" name="keyService" value="${param.keyService}" placeholder="Search service by name...">
            </div>

            <div class="table-scroll">
                <table id="serviceTable">
                    <thead>
                    <tr>
                        <th style="width:40px;">ID</th>
                        <th>Name</th>
                        <th style="width:100px;">Price(đ)</th>
                        <th style="width:90px;">Detail</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="s" items="${services}">
                        <tr data-search="${s.name}">
                            <td>${s.idService}</td>
                            <td>${s.name}</td>
                            <td>${s.price.intValue()}</td>
                            <td><a class="btn" href="serviceDetail?id=${s.idService}">Show</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Spare Part List -->
        <div class="card">
            <h2>Spare Part List</h2>
            <div class="search">
                <input id="partSearch" type="text" name="keyPart" value="${param.keyPart}" placeholder="Search spare part by name...">
            </div>

            <div class="table-scroll">
                <table id="partTable">
                    <thead>
                    <tr>
                        <th style="width:40px;">ID</th>
                        <th>Name</th>
                        <th style="width:100px;">Price(đ)</th>
                        <th style="width:90px;">Detail</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${parts}">
                        <tr data-search="${p.name}">
                            <td>${p.idPart}</td>
                            <td>${p.name}</td>
                            <td>${p.sellPrice.intValue()}</td>
                            <td><a class="btn" href="sparePartDetail?id=${p.idPart}">Show</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="footer-actions">
        <button class="btn btn-secondary" onclick="location.href='home'">Return</button>
    </div>
</div>

<script>
    function removeVietnameseTones(str) {
        return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replace(/đ/g, "d").replace(/Đ/g, "D")
            .toLowerCase()
            .trim();
    }

    function filterTable(inputId, tableId) {
        const keyword = removeVietnameseTones(document.getElementById(inputId).value);
        const rows = document.querySelectorAll("#" +tableId+ " tbody tr");

        rows.forEach(row => {
            const name = removeVietnameseTones(row.dataset.search);
            row.style.display = name.includes(keyword) ? "" : "none";
        });
    }

    document.getElementById("serviceSearch").addEventListener("input", function() {
        filterTable("serviceSearch", "serviceTable");
    });

    document.getElementById("partSearch").addEventListener("input", function() {
        filterTable("partSearch", "partTable");
    });
</script>

</body>
</html>