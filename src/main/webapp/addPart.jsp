<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Spare Part</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f7fa; }
        .frame { border: 2px solid #007BFF; border-radius: 10px; padding: 20px; background: #fff; max-width: 600px; margin: auto; }
        h2 { color: #007BFF; text-align: center; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input, button { width: 100%; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px; }
        .btn { margin-top: 15px; padding: 10px; font-size: 16px; font-weight: bold; cursor: pointer; }
        .btn-confirm { background: #28a745; color: white; }
        .btn-cancel { background: #dc3545; color: white; }
    </style>
</head>
<body>
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