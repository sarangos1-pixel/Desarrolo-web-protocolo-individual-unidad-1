<%-- 
    Document   : forgot_password
    Created on : 18 sep 2026, 7:45:31 p.m.
    Author     : sjara
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Recuperar Contraseña</title>
</head>
<body>
    <h1>Recuperar Contraseña</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=forgotPassword" method="post">
        <label for="email">Ingresa tu correo registrado:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        <input type="submit" value="Enviar nueva contraseña">
    </form>

    <br>
    <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=login">Volver al login</a>
</body>
</html>