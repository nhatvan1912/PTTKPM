<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - GaraMan</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); width: 350px; }
        h2 { text-align: center; color: #333; margin-bottom: 30px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background: #007BFF; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn:hover { background: #0056b3; }
        .error { color: red; text-align: center; margin-bottom: 15px; font-weight: bold; }
        .hint { text-align: center; font-size: 12px; color: #777; margin-top: 15px; }
    </style>
</head>
<body>
<div class="login-box">
    <h2>🔐 GaraMan Login</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <form method="post" action="login">
        <label>Username</label>
        <input type="text" name="username" required autofocus>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" class="btn">Login</button>
    </form>
    <p class="hint">Demo accounts:<br><b>customer1</b> / <b>nhatvan1912</b> (warehouse)<br>Password: <b>123456</b></p>
</div>
</body>
</html>