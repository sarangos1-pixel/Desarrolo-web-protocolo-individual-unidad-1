package Infraestructure.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDbMySql {

    private static final String DB_HOST = getEnvOrDefault("MYSQLHOST", "localhost");
    private static final String DB_PORT = getEnvOrDefault("MYSQLPORT", "3306");
    private static final String DB_NAME = getEnvOrDefault("MYSQLDATABASE", "EjemploCrudJSP");
    private static final String DB_USER = getEnvOrDefault("MYSQLUSER", "root");
    private static final String DB_PASSWORD = getEnvOrDefault("MYSQLPASSWORD", "");

    private static final String URL =
            "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME
            + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static String getEnvOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value == null || value.isEmpty()) ? defaultValue : value;
    }

    // Método que devuelve una conexión a la base de datos
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
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
