<%-- 
    Document   : find_edit_delete
    Created on : 17 sep 2026, 10:56:51?p.m.
    Author     : sjara
--%>
<%@page import="Domain.Model.Estudiante"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buscar, Editar o Eliminar Estudiante</title>
    <script>
        function enableButtons() {
            document.getElementById("editBtn").disabled = false;
            document.getElementById("deleteBtn").disabled = false;
        }
        function disableButtons() {
            document.getElementById("editBtn").disabled = true;
            document.getElementById("deleteBtn").disabled = true;
        }
        function setActionAndSubmit(action, confirmMessage) {
            if (confirmMessage) {
                if (!confirm(confirmMessage)) {
                    return;
                }
            }
            document.getElementById("actionInput").value = action;
            document.getElementById("estudianteForm").submit();
        }
    </script>
</head>
<body onload="<%= (session.getAttribute("searchedEstudiante") != null) ? "enableButtons()" : "disableButtons()" %>">
    <h1>Buscar, Editar o Eliminar Estudiante</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <form id="estudianteForm" action="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp" method="post">
        <input type="hidden" id="actionInput" name="action" value="search">

        <label for="id">ID del estudiante:</label><br>
        <input type="text" id="id" name="id" required
               value="<%= session.getAttribute("searchedEstudiante") != null
                    ? ((Estudiante) session.getAttribute("searchedEstudiante")).getId()
                    : "" %>">
        <br><br>

        <% Estudiante sessionEstudiante = (Estudiante) session.getAttribute("searchedEstudiante"); %>

        <% if (sessionEstudiante != null) { %>
            <h3>Detalles del Estudiante</h3>
            <p><strong>ID:</strong> <%= sessionEstudiante.getId() %></p>

            <label for="nombre">Nombre:</label><br>
            <input type="text" id="nombre" name="nombre" value="<%= sessionEstudiante.getNombre() %>" required>
            <br><br>

            <label for="apellido">Apellido:</label><br>
            <input type="text" id="apellido" name="apellido" value="<%= sessionEstudiante.getApellido() %>" required>
            <br><br>

            <label for="fechaNacimiento">Fecha de Nacimiento:</label><br>
            <input type="date" id="fechaNacimiento" name="fechaNacimiento" value="<%= sessionEstudiante.getFechaNacimiento() %>" required>
            <br><br>

            <label for="semestre">Semestre:</label><br>
            <input type="number" id="semestre" name="semestre" value="<%= sessionEstudiante.getSemestre() %>" required>
            <br><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value="<%= sessionEstudiante.getEmail() %>" required>
            <br><br>

            <label for="genero">Género:</label><br>
            <input type="text" id="genero" name="genero" value="<%= sessionEstudiante.getGenero() %>" required>
            <br><br>

            <label for="telefono">Teléfono:</label><br>
            <input type="text" id="telefono" name="telefono" value="<%= sessionEstudiante.getTelefono() %>" required>
            <br><br>

            <label for="programa">Programa:</label><br>
            <input type="text" id="programa" name="programa" value="<%= sessionEstudiante.getPrograma() %>" required>
            <br><br>

            <label for="universidad">Universidad:</label><br>
            <input type="text" id="universidad" name="universidad" value="<%= sessionEstudiante.getUniversidad() %>" required>
            <br><br>
        <% } else { %>
            <p>No se ha buscado ningún estudiante aún o no fue encontrado.</p>
        <% } %>

        <br>

        <button type="submit" onclick="setActionAndSubmit('search')" id="searchBtn">Buscar Estudiante</button>
        <button type="button" id="editBtn" disabled
                onclick="setActionAndSubmit('update', '¿Seguro que deseas editar este estudiante?')">
            Editar Estudiante
        </button>
        <button type="button" id="deleteBtn" disabled
                onclick="setActionAndSubmit('delete', '¿Seguro que deseas eliminar este estudiante?')">
            Eliminar Estudiante
        </button>

    </form>

    <br>
    <a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>

