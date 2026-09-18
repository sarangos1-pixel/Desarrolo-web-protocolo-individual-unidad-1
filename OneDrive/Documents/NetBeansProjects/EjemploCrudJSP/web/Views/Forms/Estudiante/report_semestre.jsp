<%-- 
    Document   : report_semestre
    Created on : 17 sep 2026, 10:57:11?p.m.
    Author     : sjara
--%>
<%@page import="java.util.List"%>
<%@page import="Domain.Model.Estudiante"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reporte: Estudiantes por Semestre</title>
</head>
<body>
    <h1>Reporte: Estudiantes por Semestre</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=reportSemestre" method="post">
        <label for="semestre">Semestre a consultar:</label><br>
        <input type="number" id="semestre" name="semestre" min="1" max="12" required
               value="<%= request.getAttribute("filtroSemestre") != null ? request.getAttribute("filtroSemestre") : "" %>">
        <input type="submit" value="Consultar">
    </form>

    <% List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes"); %>
    <% if (estudiantes != null) { %>
        <table border="1">
            <thead>
                <tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Semestre</th><th>Programa</th></tr>
            </thead>
            <tbody>
                <% if (estudiantes.isEmpty()) { %>
                    <tr><td colspan="5">No hay estudiantes en ese semestre</td></tr>
                <% } else { %>
                    <% for (Estudiante e : estudiantes) { %>
                        <tr>
                            <td><%= e.getId() %></td>
                            <td><%= e.getNombre() %></td>
                            <td><%= e.getApellido() %></td>
                            <td><%= e.getSemestre() %></td>
                            <td><%= e.getPrograma() %></td>
                        </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <br>
    <a href="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=listAll">Volver al listado</a>
</body>
</html>
