/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infraestructure.Database;

/**
 *
 * @author sjara
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDbMySql {

    private static final String URL = "jdbc:mysql://localhost:3306/EjemploCrudJSP";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.jdbc.Driver";

    // Método que devuelve una conexión a la base de datos
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Error: Driver MySQL no encontrado.");
        } catch (SQLException e) {
            e.printStackTrace();
            var message = "Error: No se pudo establecer la conexión con la base de datos.";
            throw new SQLException(message);
        }
        return connection;
    }
}
