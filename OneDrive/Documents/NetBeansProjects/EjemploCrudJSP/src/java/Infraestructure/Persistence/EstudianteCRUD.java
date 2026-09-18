/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infraestructure.Persistence;

/**
 *
 * @author sjara
 */
import Business.Exception.DuplicateEstudianteException;
import Business.Exception.EstudianteNotFoundException;
import Domain.Model.Estudiante;
import Infraestructure.Database.ConnectionDbMySql;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EstudianteCRUD {

    // Método para obtener todos los estudiantes
    public List<Estudiante> getAllEstudiantes() throws SQLException {
        List<Estudiante> lista = new ArrayList<>();
        String query = "SELECT * FROM Estudiantes";
        try (Connection con = ConnectionDbMySql.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                lista.add(mapResultSetToEstudiante(rs));
            }
        }
        return lista;
    }

    // Método para agregar un nuevo estudiante
    public void addEstudiante(Estudiante e) throws SQLException, DuplicateEstudianteException {
        String query = "INSERT INTO Estudiantes (id, nombre, apellido, fechaNacimiento, semestre, email, genero, telefono, programa, universidad) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, e.getId());
            stmt.setString(2, e.getNombre());
            stmt.setString(3, e.getApellido());
            stmt.setString(4, e.getFechaNacimiento());
            stmt.setInt(5, e.getSemestre());
            stmt.setString(6, e.getEmail());
            stmt.setString(7, e.getGenero());
            stmt.setString(8, e.getTelefono());
            stmt.setString(9, e.getPrograma());
            stmt.setString(10, e.getUniversidad());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            
            if (ex.getErrorCode() == 1062) {
                throw new DuplicateEstudianteException("El estudiante con el id " + e.getId() + " o el email ya existe.");
            } else {
                throw ex;
            }
        }
    }

    // Método para actualizar un estudiante
    public void updateEstudiante(Estudiante e) throws SQLException, EstudianteNotFoundException {
        String query = "UPDATE Estudiantes SET nombre=?, apellido=?, fechaNacimiento=?, semestre=?, email=?, genero=?, telefono=?, programa=?, universidad=? WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, e.getNombre());
            stmt.setString(2, e.getApellido());
            stmt.setString(3, e.getFechaNacimiento());
            stmt.setInt(4, e.getSemestre());
            stmt.setString(5, e.getEmail());
            stmt.setString(6, e.getGenero());
            stmt.setString(7, e.getTelefono());
            stmt.setString(8, e.getPrograma());
            stmt.setString(9, e.getUniversidad());
            stmt.setString(10, e.getId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new EstudianteNotFoundException("El estudiante con el id " + e.getId() + " no existe.");
            }
        }
    }

    // Método para eliminar un estudiante
    public void deleteEstudiante(String id) throws SQLException, EstudianteNotFoundException {
        String query = "DELETE FROM Estudiantes WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new EstudianteNotFoundException("El estudiante con el id " + id + " no existe.");
            }
        }
    }

    // Método para obtener un estudiante por id
    public Estudiante getEstudianteById(String id) throws SQLException, EstudianteNotFoundException {
        String query = "SELECT * FROM Estudiantes WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEstudiante(rs);
                } else {
                    throw new EstudianteNotFoundException("El estudiante con el id " + id + " no existe.");
                }
            }
        }
    }

    // Reporte parametrizado 1: estudiantes filtrados por semestre
    public List<Estudiante> getEstudiantesPorSemestre(int semestre) throws SQLException {
        List<Estudiante> lista = new ArrayList<>();
        String query = "SELECT * FROM Estudiantes WHERE semestre=?";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, semestre);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToEstudiante(rs));
                }
            }
        }
        return lista;
    }

    // Reporte parametrizado 2: estudiantes filtrados por programa (búsqueda parcial)
    public List<Estudiante> getEstudiantesPorPrograma(String programa) throws SQLException {
        List<Estudiante> lista = new ArrayList<>();
        String query = "SELECT * FROM Estudiantes WHERE programa LIKE ?";
        try (Connection con = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, "%" + programa + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToEstudiante(rs));
                }
            }
        }
        return lista;
    }

    private Estudiante mapResultSetToEstudiante(ResultSet rs) throws SQLException {
        return new Estudiante(
                rs.getString("id"),
                rs.getString("nombre"),
                rs.getString("apellido"),
                rs.getString("fechaNacimiento"),
                rs.getInt("semestre"),
                rs.getString("email"),
                rs.getString("genero"),
                rs.getString("telefono"),
                rs.getString("programa"),
                rs.getString("universidad"));
    }
}
