<%-- 
    Document   : EstudianteController
    Created on : 18 sep 2026, 1:34:34?a.m.
    Author     : sjara
--%>

<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="jakarta.servlet.ServletException"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="Business.Services.EstudianteService"%>
<%@page import="Domain.Model.Estudiante"%>
<%@page import="Business.Exception.EstudianteNotFoundException"%>
<%@page import="Business.Exception.DuplicateEstudianteException"%>
<%
    EstudianteService estudianteService = new EstudianteService();
    String action = request.getParameter("action");
    if (action == null) {
        action = "listAll";
    }
    switch (action) {
        case "showCreateForm":
            showCreateForm(request, response);
            break;
        case "create":
            handleCreate(request, response, estudianteService);
            break;
        case "showFindForm":
            showFindForm(request, response);
            break;
        case "search":
            handleSearch(request, response, session, estudianteService);
            break;
        case "update":
            handleUpdate(request, response, session, estudianteService);
            break;
        case "delete":
            handleDelete(request, response, session, estudianteService);
            break;
        case "deletefl":
            handleDeleteFromList(request, response, session, estudianteService);
            break;
        case "listAll":
            handleListAll(request, response, estudianteService);
            break;
        case "showReportSemestre":
            showReportSemestreForm(request, response);
            break;
        case "reportSemestre":
            handleReportSemestre(request, response, estudianteService);
            break;
        case "showReportPrograma":
            showReportProgramaForm(request, response);
            break;
        case "reportPrograma":
            handleReportPrograma(request, response, estudianteService);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>
<%!
    // Mostrar formulario de creación
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Estudiante/create.jsp");
    }

    // Crear un nuevo estudiante
    private void handleCreate(HttpServletRequest request, HttpServletResponse response, EstudianteService service)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        int semestre = Integer.parseInt(request.getParameter("semestre"));
        String email = request.getParameter("email");
        String genero = request.getParameter("genero");
        String telefono = request.getParameter("telefono");
        String programa = request.getParameter("programa");
        String universidad = request.getParameter("universidad");
        try {
            service.createEstudiante(id, nombre, apellido, fechaNacimiento, semestre, email, genero, telefono, programa, universidad);
            request.setAttribute("successMessage", "Estudiante creado exitosamente.");
            handleListAll(request, response, service);
        } catch (DuplicateEstudianteException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Estudiante/create.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Inténtelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/create.jsp").forward(request, response);
        }
    }

    // Mostrar formulario de búsqueda/edición/eliminación
    private void showFindForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
    }

    // Buscar un estudiante por id
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, EstudianteService service)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            Estudiante e = service.getEstudianteById(id);
            session.setAttribute("searchedEstudiante", e);
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (EstudianteNotFoundException e) {
            session.removeAttribute("searchedEstudiante");
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Actualizar los datos del estudiante buscado
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, HttpSession session, EstudianteService service)
            throws ServletException, IOException {
        Estudiante searched = (Estudiante) session.getAttribute("searchedEstudiante");
        if (searched == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un estudiante para editar.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String id = searched.getId();
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        int semestre = Integer.parseInt(request.getParameter("semestre"));
        String email = request.getParameter("email");
        String genero = request.getParameter("genero");
        String telefono = request.getParameter("telefono");
        String programa = request.getParameter("programa");
        String universidad = request.getParameter("universidad");
        try {
            service.updateEstudiante(id, nombre, apellido, fechaNacimiento, semestre, email, genero, telefono, programa, universidad);
            request.setAttribute("successMessage", "Estudiante actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (EstudianteNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Eliminar el estudiante buscado (desde el formulario buscar/editar/eliminar)
    private void handleDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session, EstudianteService service)
            throws ServletException, IOException {
        Estudiante searched = (Estudiante) session.getAttribute("searchedEstudiante");
        if (searched == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un estudiante para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
            return;
        }
        try {
            service.deleteEstudiante(searched.getId());
            session.removeAttribute("searchedEstudiante");
            request.setAttribute("successMessage", "Estudiante eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (EstudianteNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Eliminar directamente desde la lista (link "Eliminar")
    private void handleDeleteFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, EstudianteService service)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            service.deleteEstudiante(id);
            session.removeAttribute("searchedEstudiante");
            request.setAttribute("successMessage", "Estudiante eliminado exitosamente.");
            handleListAll(request, response, service);
        } catch (EstudianteNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAll(request, response, service);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListAll(request, response, service);
        }
    }

    // Listar todos los estudiantes
    private void handleListAll(HttpServletRequest request, HttpServletResponse response, EstudianteService service)
            throws ServletException, IOException {
        try {
            List<Estudiante> lista = service.getAllEstudiantes();
            request.setAttribute("estudiantes", lista);
            request.getRequestDispatcher("/Views/Forms/Estudiante/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar estudiantes.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/list_all.jsp").forward(request, response);
        }
    }

    // Reporte 1: mostrar formulario
    private void showReportSemestreForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Estudiante/report_semestre.jsp").forward(request, response);
    }

    // Reporte 1: ejecutar consulta por semestre
    private void handleReportSemestre(HttpServletRequest request, HttpServletResponse response, EstudianteService service)
            throws ServletException, IOException {
        int semestre = Integer.parseInt(request.getParameter("semestre"));
        try {
            List<Estudiante> lista = service.reportePorSemestre(semestre);
            request.setAttribute("estudiantes", lista);
            request.setAttribute("filtroSemestre", semestre);
            request.getRequestDispatcher("/Views/Forms/Estudiante/report_semestre.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/report_semestre.jsp").forward(request, response);
        }
    }

    // Reporte 2: mostrar formulario
    private void showReportProgramaForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Estudiante/report_programa.jsp").forward(request, response);
    }

    // Reporte 2: ejecutar consulta por programa
    private void handleReportPrograma(HttpServletRequest request, HttpServletResponse response, EstudianteService service)
            throws ServletException, IOException {
        String programa = request.getParameter("programa");
        try {
            List<Estudiante> lista = service.reportePorPrograma(programa);
            request.setAttribute("estudiantes", lista);
            request.setAttribute("filtroPrograma", programa);
            request.getRequestDispatcher("/Views/Forms/Estudiante/report_programa.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Estudiante/report_programa.jsp").forward(request, response);
        }
    }
%>

