<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.garaman.model.ImportReceipt" %>
<%
    ImportReceipt receipt = (ImportReceipt) request.getAttribute("receipt");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Purchase Receipt</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .frame { max-width: 800px; margin: auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background: #007BFF; color: white; }
    </style>
</head>
<body>
<div class="frame">
    <h2>Purchase Receipt</h2>
    <p><b>Receipt ID:</b> <%= receipt != null ? receipt.getIdReceipt() : "" %></p>
    <p><b>Supplier:</b> <%= receipt != null && receipt.getSupplier() != null ? receipt.getSupplier().getName() : "" %></p>
    <p><b>Total:</b> <%= receipt != null ? receipt.getTotalPrice() : "" %> VND</p>

    <h3>Details</h3>
    <table>
        <tr><th>Part</th><th>Quantity</th><th>Unit Cost</th><th>Subtotal</th></tr>
        <%
            if (receipt != null && receipt.getDetails() != null) {
                receipt.getDetails().forEach(d -> {
                    try {
        %>
        <tr>
            <td><%= d.getPart().getName() %></td>
            <td><%= d.getQuantity() %></td>
            <td><%= d.getUnitCost() %></td>
            <td><%= d.getTotal() %></td>
        </tr>
        <%
                    } catch (Exception e) { e.printStackTrace(); }
                });
            }
        %>
    </table>
    <br>
    <button onclick="location.href='home'">Back to Home</button>
</div>
</body>
</html>