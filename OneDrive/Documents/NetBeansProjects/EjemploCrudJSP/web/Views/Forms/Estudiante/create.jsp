<%-- 
    Document   : create
    Created on : 17 sep 2026, 10:56:38 p.m.
    Author     : sjara
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Agregar Estudiante</title>
</head>
<body>
    <h1>Agregar Estudiante</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=create" method="post">
        <label for="id">ID:</label><br>
        <input type="text" id="id" name="id" required><br><br>

        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="apellido">Apellido:</label><br>
        <input type="text" id="apellido" name="apellido" required><br><br>

        <label for="fechaNacimiento">Fecha de Nacimiento:</label><br>
        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required><br><br>

        <label for="semestre">Semestre:</label><br>
        <input type="number" id="semestre" name="semestre" min="1" max="12" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="genero">Género:</label><br>
        <select id="genero" name="genero" required>
            <option value="Femenino">Femenino</option>
            <option value="Masculino">Masculino</option>
            <option value="Otro">Otro</option>
        </select><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" required><br><br>

        <label for="programa">Programa:</label><br>
        <input type="text" id="programa" name="programa" required><br><br>

        <label for="universidad">Universidad:</label><br>
        <input type="text" id="universidad" name="universidad" required><br><br>

        <input type="submit" value="Agregar Estudiante">
    </form>

    <br>
    <a href="<%= request.getContextPath() %>/index.jsp">Menu Principal</a>
</body>
</html>
