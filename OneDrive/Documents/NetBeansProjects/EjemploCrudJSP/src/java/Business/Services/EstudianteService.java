/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author sjara
 */
import Domain.Model.Estudiante;
import Business.Exception.EstudianteNotFoundException;
import Business.Exception.DuplicateEstudianteException;
import Infraestructure.Persistence.EstudianteCRUD;
import java.sql.SQLException;
import java.util.List;

public class EstudianteService {

    private EstudianteCRUD estudianteCrud;

    public EstudianteService() {
        this.estudianteCrud = new EstudianteCRUD();
    }

    public List<Estudiante> getAllEstudiantes() throws SQLException {
        return estudianteCrud.getAllEstudiantes();
    }

    public void createEstudiante(String id, String nombre, String apellido, String fechaNacimiento, int semestre,
            String email, String genero, String telefono, String programa, String universidad)
            throws DuplicateEstudianteException, SQLException {
        Estudiante e = new Estudiante(id, nombre, apellido, fechaNacimiento, semestre, email, genero, telefono, programa, universidad);
        estudianteCrud.addEstudiante(e);
    }

    public void updateEstudiante(String id, String nombre, String apellido, String fechaNacimiento, int semestre,
            String email, String genero, String telefono, String programa, String universidad)
            throws EstudianteNotFoundException, SQLException {
        Estudiante e = new Estudiante(id, nombre, apellido, fechaNacimiento, semestre, email, genero, telefono, programa, universidad);
        estudianteCrud.updateEstudiante(e);
    }

    public void deleteEstudiante(String id) throws EstudianteNotFoundException, SQLException {
        estudianteCrud.deleteEstudiante(id);
    }

    public Estudiante getEstudianteById(String id) throws EstudianteNotFoundException, SQLException {
        return estudianteCrud.getEstudianteById(id);
    }

    // Reporte 1
    public List<Estudiante> reportePorSemestre(int semestre) throws SQLException {
        return estudianteCrud.getEstudiantesPorSemestre(semestre);
    }

    // Reporte 2
    public List<Estudiante> reportePorPrograma(String programa) throws SQLException {
        return estudianteCrud.getEstudiantesPorPrograma(programa);
    }
}
