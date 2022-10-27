package jdbc;

import java.sql.Connection;
import java.sql.Statement;

public class main {
    public static void main(String[] args) {

        // DBWork objesini oluştur.
        DBWork db = new DBWork();

        //Connection methodu çağır.
        Connection con = db.connect_to_db("techproed","postgres","34533453");

        //Yeni table oluşturma methodunu çağır.
        db.createTable(con,"employees");

    }

}
