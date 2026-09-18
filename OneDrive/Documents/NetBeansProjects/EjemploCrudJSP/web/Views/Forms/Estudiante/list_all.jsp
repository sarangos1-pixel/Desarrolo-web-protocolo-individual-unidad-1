<%-- 
    Document   : list_all
    Created on : 17 sep 2026, 10:57:02?p.m.
    Author     : sjara
--%>
<%@page import="java.util.List"%>
<%@page import="Domain.Model.Estudiante"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Estudiantes</title>
</head>
<body>
    <h1>Lista de Todos los Estudiantes</h1>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getAttribute("successMessage") != null) { %>
        <p style="color:green;"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Semestre</th>
                <th>Email</th>
                <th>Programa</th>
                <th>Universidad</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <% List<Estudiante> estudiantes = (List<Estudiante>) request.getAttribute("estudiantes"); %>
            <% if (estudiantes != null && !estudiantes.isEmpty()) { %>
                <% for (Estudiante e : estudiantes) { %>
                    <tr>
                        <td><%= e.getId() %></td>
                        <td><%= e.getNombre() %></td>
                        <td><%= e.getApellido() %></td>
                        <td><%= e.getSemestre() %></td>
                        <td><%= e.getEmail() %></td>
                        <td><%= e.getPrograma() %></td>
                        <td><%= e.getUniversidad() %></td>
                        <td>
                            <a href="EstudianteController.jsp?action=search&id=<%= e.getId() %>">Editar</a> |
                            <a href="EstudianteController.jsp?action=deletefl&id=<%= e.getId() %>"
                               onclick="return confirm('¿Seguro que deseas eliminar este estudiante?');">Eliminar</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="8">No hay estudiantes disponibles</td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <br>
    <a href="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=showCreateForm">Agregar Nuevo Estudiante</a> |
    <a href="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=showReportSemestre">Reporte por Semestre</a> |
    <a href="<%= request.getContextPath() %>/Controllers/EstudianteController.jsp?action=showReportPrograma">Reporte por Programa</a>
    <br><br>
    <a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>

