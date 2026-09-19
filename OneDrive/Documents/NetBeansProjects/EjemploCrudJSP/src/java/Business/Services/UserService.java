/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author sjara
 */
import Domain.Model.User;
import Business.Exception.UserNotFoundException;
import Business.Exception.DuplicateUserException;
import Infraestructure.Persistence.UserCRUD;
import jakarta.mail.MessagingException;
import java.sql.SQLException;

import java.util.List;

public class UserService {

    private UserCRUD userCrud;

    // Constructor
    public UserService() {
        this.userCrud = new UserCRUD();
    }

    // Método para obtener todos los usuarios
    public List<User> getAllUsers() throws SQLException {
        return userCrud.getAllUsers();
    }

    // Método para agregar un nuevo usuario
    public void createUser(String code, String name, String email, String password)
            throws DuplicateUserException, SQLException {
        User user = new User(code, password, name, email);
        userCrud.addUser(user);
    }

    // Método para actualizar un usuario
    public void updateUser(String code, String name, String email, String password)
            throws UserNotFoundException, SQLException {
        User user = new User(code, password, name, email);
        userCrud.updateUser(user);
    }

    // Método para eliminar un usuario
    public void deleteUser(String code) throws UserNotFoundException, SQLException {
        userCrud.deleteUser(code);
    }

    // Método para obtener un usuario por código
    public User getUserByCode(String code) throws UserNotFoundException, SQLException {
        return userCrud.getUserByCode(code);
    }

    // Método para autenticar un usuario (login)
    public User loginUser(String email, String password) throws UserNotFoundException, SQLException {
        User user = userCrud.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            throw new UserNotFoundException("Credenciales incorrectas. No se encontró el usuario o la contraseña es incorrecta.");
        }
    }

    // Método para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        return userCrud.searchUsers(searchTerm);
    }

    // === Recordatorio de contraseña por correo (no cambia la clave, solo la reenvia) ===
    public void sendPasswordReminder(String email) throws UserNotFoundException, SQLException, MessagingException {
        User user = userCrud.getUserByEmail(email);
        EmailService.sendPasswordReminderEmail(user.getEmail(), user.getName(), user.getPassword());
    }
}