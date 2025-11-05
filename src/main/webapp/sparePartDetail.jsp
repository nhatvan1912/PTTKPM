<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Spare Part Detail</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .frame { border: 2px solid #007BFF; border-radius: 8px; padding: 20px; background: #f9f9f9; max-width: 600px; }
        h2 { color: #007BFF; }
        button { padding: 8px 12px; background: #007BFF; color: white; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>
<div class="frame">
    <h2>Spare Part Detail</h2>
    <p><b>ID:</b> ${part.idPart}</p>
    <p><b>Name:</b> ${part.name}</p>
    <p><b>Quantity:</b> ${part.quantity}</p>
    <p><b>Unit Price:</b> ${part.unitPrice} VND</p>
    <p><b>Sell Price:</b> ${part.sellPrice} VND</p>
    <button onclick="history.back()">Back</button>
</div>
</body>
</html>