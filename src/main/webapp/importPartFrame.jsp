<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.garaman.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String staffName = user != null ? user.getFullName() : "Unknown";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Import Spare Parts</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f5f7fa; }
        .header { background: #28a745; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .user-badge { background: white; color: #28a745; padding: 8px 15px; border-radius: 20px; font-weight: bold; }
        .frame { max-width: 900px; margin: 30px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        label { font-weight: bold; display: block; margin-top: 15px; }
        select, input { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px; }
        .inline { display: flex; gap: 10px; }
        button { padding: 10px 20px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #218838; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background: #28a745; color: white; }
    </style>
</head>
<body>
<div class="header">
    <h2>📦 Import Spare Parts</h2>
    <div class="user-badge">👷 <%= staffName %></div>
</div>

<div class="frame">
    <label>Supplier</label>
    <div class="inline">
        <select id="supplier" style="flex:1;">
            <option value="">-- Select Supplier --</option>
            <c:forEach var="s" items="${suppliers}">
                <option value="${s.idSupplier}">${s.name}</option>
            </c:forEach>
        </select>
        <button onclick="location.href='addSupplier'" style="width:180px;">+ New Supplier</button>
    </div>

    <label>Spare Part</label>
    <div class="inline">
        <select id="part" style="flex:1;">
            <option value="">-- Select Part --</option>
            <c:forEach var="p" items="${parts}">
                <option value="${p.idPart}" data-name="${p.name}">${p.name}</option>
            </c:forEach>
        </select>
        <button onclick="location.href='addPart'" style="width:180px;">+ New Part</button>
    </div>

    <label>Quantity</label>
    <input type="number" id="quantity" min="1" placeholder="Enter quantity">

    <label>Unit Price</label>
    <input type="number" id="unitPrice" min="0" step="0.01" placeholder="Enter unit price">

    <button onclick="addToList()">➕ Add to List</button>

    <h3>Import List</h3>
    <table id="partTable">
        <tr><th>Part ID</th><th>Part Name</th><th>Quantity</th><th>Unit Price</th><th>Total</th><th>Action</th></tr>
    </table>

    <button onclick="confirmImport()">✅ Confirm Import</button>
    <button onclick="location.href='home'">❌ Cancel</button>
</div>

<script>
let importList = [];

function addToList() {
    let partSelect = document.getElementById("part");
    let partId = partSelect.value;
    let partName = partSelect.options[partSelect.selectedIndex].getAttribute("data-name");
    let quantity = parseInt(document.getElementById("quantity").value);
    let unitPrice = parseFloat(document.getElementById("unitPrice").value);

    if (!partId || !quantity || !unitPrice) {
        alert("Please fill all fields!");
        return;
    }

    let total = quantity * unitPrice;
    importList.push({ idPart: partId, name: partName, quantity, unitPrice, total });

    let table = document.getElementById("partTable");
    let row = table.insertRow(-1);
    row.innerHTML = `<td>${partId}</td><td>${partName}</td><td>${quantity}</td><td>${unitPrice}</td><td>${total}</td>
                     <td><button onclick="removeRow(this)">Remove</button></td>`;

    document.getElementById("quantity").value = "";
    document.getElementById("unitPrice").value = "";
}

function removeRow(btn) {
    let row = btn.parentNode.parentNode;
    let idx = row.rowIndex - 1;
    importList.splice(idx, 1);
    row.remove();
}

function confirmImport() {
    let supplierId = document.getElementById("supplier").value;
    if (!supplierId) { alert("Please select a supplier!"); return; }
    if (importList.length === 0) { alert("No parts in list!"); return; }

    let form = document.createElement("form");
    form.method = "POST";
    form.action = "purchaseReceipt";

    let inp1 = document.createElement("input");
    inp1.type = "hidden"; inp1.name = "supplierId"; inp1.value = supplierId; form.appendChild(inp1);

    let mapped = importList.map(d => ({ part: { idPart: d.idPart, name: d.name }, quantity: d.quantity, unitCost: d.unitPrice }));
    let inp2 = document.createElement("input");
    inp2.type = "hidden"; inp2.name = "details"; inp2.value = JSON.stringify(mapped); form.appendChild(inp2);

    // staffId from session/user - fallback to 0
    let inp3 = document.createElement("input");
    inp3.type = "hidden"; inp3.name = "staffId"; inp3.value = "<%= session.getAttribute("userId") %>"; form.appendChild(inp3);

    document.body.appendChild(form);
    form.submit();
}
</script>
</body>
</html>