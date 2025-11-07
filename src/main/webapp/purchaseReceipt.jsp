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
    <title>Import Receipt</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f5f7fa; }
        /* Header giống home.jsp */
        .header { background: #007BFF; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }

        .container { max-width: 1000px; margin: 28px auto; padding: 0 16px; }
        .card { background: #fff; border-radius: 10px; border: 2px solid #007BFF; padding: 20px; }
        .card h2 { color: #007BFF; text-align: center; margin: 0 0 16px; }

        .chips { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 14px; }
        .chip { background: #eef2ff; color: #374151; padding: 8px 12px; border-radius: 10px; }
        .chip b { margin-right: 6px; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #e5e7eb; padding: 10px; }
        th { background: #0d6efd; color: #fff; text-align: left; }
        td { background: #fff; }

        .grand { font-size: 18px; font-weight: bold; margin-top: 16px; }
        .btn { width: 100%; padding: 12px; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; }
        .btn-pay { background: #28a745; }
        .btn-pay:hover { background: #218838; }
        .btn-close { background: #dc3545; margin-top: 10px; }
        .btn-close:hover { background: #bb2d3b; }

        .muted { color: #6b7280; }
    </style>
</head>
<body>
<div class="header">
    <h1>Services &amp; Spare Parts Infomation</h1>
    <div class="user-info">
        <span><b><%= user.getFullName() %></b> <span class="badge"><%= role %></span></span>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </div>
</div>

<div class="container">
    <div class="card">
        <h2>Import Receipt</h2>

        <div class="chips">
            <div class="chip"><b>Import Date:</b>
                <span>${receipt.getCreatedAt()}</span>
            </div>

            <div class="chip">
                <b>Supplier:</b>
                <c:choose>
                    <c:when test="${not empty receipt && not empty receipt.supplier}">
                        <span>
                            ${receipt.supplier.name}
                            <span class="muted"> | Phone: ${receipt.supplier.phone}</span>
                            <span class="muted">
                                | Address:
                                <c:if test="${not empty receipt.supplier.address}">
                                    ${receipt.supplier.address.streetNumber} ${receipt.supplier.address.streetName},
                                    ${receipt.supplier.address.ward}, ${receipt.supplier.address.district}, ${receipt.supplier.address.province}
                                </c:if>
                            </span>
                        </span>
                    </c:when>
                    <c:otherwise><span>Unknown supplier</span></c:otherwise>
                </c:choose>
            </div>
        </div>

        <table>
            <thead>
            <tr>
                <th style="width:90px;">Part ID</th>
                <th>Part Name</th>
                <th style="width:120px;">Quantity</th>
                <th style="width:140px;">Unit Price</th>
                <th style="width:140px;">Total</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty receipt && not empty receipt.details}">
                <c:forEach var="d" items="${receipt.details}">
                    <tr>
                        <td>${d.part.idPart}</td>
                        <td>${d.part.name}</td>
                        <td>${d.quantity}</td>
                        <td>${d.unitCost.intValue()}</td>
                        <td>${d.total.intValue()}</td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>

        <p class="grand">Grand Total:
            <c:choose>
                <c:when test="${not empty receipt}">${receipt.totalPrice.intValue()} VND</c:when>
                <c:otherwise>0 VND</c:otherwise>
            </c:choose>
        </p>

        <button class="btn btn-pay" onclick="confirmThen('Confirm paying supplier?', paySupplier)">💰 Pay Supplier</button>
        <button class="btn btn-close" onclick="confirmThen('Close this receipt and return?', closeReceipt)">Close</button>
    </div>
</div>

<script>
    function confirmThen(message, onOk) {
        if (confirm(message)) onOk && onOk();
    }

    function paySupplier() {
        alert('Payment recorded!');
        location.href = 'importPart';
    }

    function closeReceipt() {
        location.href = 'importPart';
    }
</script>
</body>
</html>