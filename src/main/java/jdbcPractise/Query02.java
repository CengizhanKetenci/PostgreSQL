package jdbcPractise;

import java.sql.*;

public class Query02 {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        Class.forName("org.postgresql.Driver");

        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/techproed",

                "postgres",
                "34533453");

        Statement st = con.createStatement();

        // ögrenciler tablosundaki erkeke ogrencileri listeleyiniz.
        ResultSet data = st.executeQuery("select * from ogrenciler where cinsiyet='E'");
        while (data.next()) {
          //  System.out.println(data.getInt(1)+" "+data.getString(2)+" "+ data.getString(3)+" "+ data.getString(4));
            // print F ile.
            System.out.printf("%-6d %-15.15s %-8s %-8s\n", data.getInt(1), data.getString(2), data.getString(3), data.getString(4));
        }
        // Kapatma.
        con.close();
        st.close();
        data.close();



    }
}
