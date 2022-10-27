package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DBWork {

    // PostGreSql bağlantısı methodu.
    public Connection connect_to_db(String dbname, String user, String password) {

        Connection con = null;

        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/" + dbname, user, password);
            if (con != null) {
                System.out.println("Bağlantı Sağlandı");
            } else {
                System.out.println("Bağlantı Sağlanamadı");
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }

    //Yeni table oluşturma methodu
    public void createTable(Connection con, String tableName) {
        //Statement objesi oluştur.
        Statement statement;

        try {
            String query = "CREATE TABLE " + tableName + "(empId SERIAL, name VARCHAR(200), email VARCHAR(200), salary INTEGER, PRIMARY KEY(empId))";
            statement = con.createStatement();
            statement.executeUpdate(query);
            System.out.println("Table oluşturuldu.");

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
