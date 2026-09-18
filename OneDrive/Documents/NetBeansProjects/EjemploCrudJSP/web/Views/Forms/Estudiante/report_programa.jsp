<%-- 
    Document   : report_programa
    Created on : 17 sep 2026, 10:57:22?p.m.
    Author     : sjara
--%>

<%@page import="java.util.List"%>
<%@page import="Domain.Model.Estudiante"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reporte: Estudiantes por Programa</title>
</head>
<body>
    <h1>Reporte: Estudiantes por Programa</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=reportPrograma" method="post">
        <label for="programa">Programa a consultar:</label><br>
        <input type="text" id="programa" name="programa" required
               value="<%= request.getAttribute("filtroPrograma") != null ? request.getAttribute("filtroPrograma") : "" %>">
        <input type="submit" value="Consultar">
    </form>

    <% List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes"); %>
    <% if (estudiantes != null) { %>
        <table border="1">
            <thead>
                <tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Programa</th><th>Universidad</th></tr>
            </thead>
            <tbody>
                <% if (estudiantes.isEmpty()) { %>
                    <tr><td colspan="5">No hay estudiantes en ese programa</td></tr>
                <% } else { %>
                    <% for (Estudiante e : estudiantes) { %>
                        <tr>
                            <td><%= e.getId() %></td>
                            <td><%= e.getNombre() %></td>
                            <td><%= e.getApellido() %></td>
                            <td><%= e.getPrograma() %></td>
                            <td><%= e.getUniversidad() %></td>
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
