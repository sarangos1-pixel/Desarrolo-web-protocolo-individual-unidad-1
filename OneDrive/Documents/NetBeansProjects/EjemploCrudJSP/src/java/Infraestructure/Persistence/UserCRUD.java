/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infraestructure.Persistence;

/**
 *
 * @author sjara
 */
import Business.Exception.DuplicateUserException;
import Business.Exception.UserNotFoundException;
import Domain.Model.User;
import Infraestructure.Database.ConnectionDbMySql;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserCRUD {

    // Método para obtener todos los usuarios
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM Users";
        try {
            Connection con = ConnectionDbMySql.getConnection();

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getString("code"),
                                rs.getString("password"),
                                rs.getString("name"),
                                rs.getString("email"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    // Método para agregar un nuevo usuario
    public void addUser(User user) throws SQLException, DuplicateUserException {
        String query = "INSERT INTO Users (code, password, name, email) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, user.getCode());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getEmail());

            stmt.executeUpdate();
        } catch (SQLException e) {
            // Aquí manejamos una posible excepción de clave duplicada
            if (e.getErrorCode() == 1062) { // Código de error de clave duplicada en MySQL
                throw new DuplicateUserException("El usuario con el código o email ya existe.");
            } else {
                throw e; // Propagamos la excepción SQLException para que la maneje el servicio
            }
        }
    }

    // Método para actualizar un usuario
    public void updateUser(User user) throws SQLException, UserNotFoundException {
        String query = "UPDATE Users SET password=?, name=?, email=? WHERE code=?";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getCode());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserNotFoundException("El usuario con el código " + user.getCode() + " no existe.");
            }
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
    }

    // Método para eliminar un usuario
    public void deleteUser(String code) throws SQLException, UserNotFoundException {
        String query = "DELETE FROM Users WHERE code=?";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, code);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserNotFoundException("El usuario con el código " + code + " no existe.");
            }
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
    }

    // Método para obtener un usuario por código
    public User getUserByCode(String code) throws SQLException, UserNotFoundException {
        String query = "SELECT * FROM Users WHERE code=?";
        User user = null;

        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(rs.getString("code"), rs.getString("password"), rs.getString("name"), rs.getString("email"));
            } else {
                throw new UserNotFoundException("El usuario con el código " + code + " no existe.");
            }
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
        return user;
    }

    // Método para autenticar un usuario por email y contraseña (Login)
    public User getUserByEmailAndPassword(String email, String password) throws UserNotFoundException {
        User user = null;
        String query = "SELECT * "
                + "FROM Usuarios "
                + "WHERE email=? AND password=?";
        try {
            Connection con = ConnectionDbMySql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getString("code"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("email")
                );
            } else {
                var message = "Credenciales incorrectas. No se encontró el usuario.";
                throw new UserNotFoundException(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Método para obtener un usuario por email
    public User getUserByEmail(String email) throws SQLException, UserNotFoundException {
        User user = null;
        String query = "SELECT * FROM Users WHERE email=?";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(rs.getString("code"), rs.getString("password"), rs.getString("name"), rs.getString("email"));
            } else {
                throw new UserNotFoundException("El usuario con el email " + email + " no existe.");
            }
        }
        return user;
    }

    // Método para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * "
                + "FROM Usuarios "
                + "WHERE name LIKE ? OR email LIKE ?";
        try {
            Connection con = ConnectionDbMySql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);

            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getString("code"),
                                rs.getString("password"),
                                rs.getString("name"),
                                rs.getString("email"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
}

