<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Supplier</title>
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
    <h2>Add Supplier</h2>
    <form method="post" action="addSupplier">
        <label>Name</label>
        <input type="text" name="name" required>
        <label>Phone</label>
        <input type="text" name="phone" required>
        <label>Street Number</label>
        <input type="text" name="streetNumber">
        <label>Street Name</label>
        <input type="text" name="streetName">
        <label>Ward</label>
        <input type="text" name="ward">
        <label>City</label>
        <input type="text" name="city">
        <label>Province</label>
        <input type="text" name="province">
        <button type="submit" class="btn btn-confirm">Save Supplier</button>
        <button type="button" class="btn btn-cancel" onclick="history.back()">Cancel</button>
    </form>
</div>
</body>
</html>