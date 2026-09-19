/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author sjara
 */
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

  
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "sebastianarangospro@gmail.com";       
    private static final String EMAIL_PASSWORD = "2411"; // 

    // Envia un RECORDATORIO de la contraseña actual (no la cambia, solo la reenvia)
    public static void sendPasswordReminderEmail(String toEmail, String userName, String currentPassword) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL_FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Recordatorio de contrasena - Gestion de Usuarios");
        message.setText("Hola " + userName + ",\n\n"
                + "Recibimos una solicitud de recordatorio de tu contrasena.\n"
                + "Tu contrasena registrada es: " + currentPassword + "\n\n"
                + "Si no solicitaste este recordatorio, contacta al administrador.\n\n"
                + "Saludos.");

        Transport.send(message);
    }
}
