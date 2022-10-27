package jdbc;

import java.sql.*;

public class CallableStatement01 {

    /*


     */
    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        // 1. adım : Driver'a kaydol
        Class.forName("org.postgresql.Driver");

        // 2. adım : Database'e baglan.
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/techproed","postgres","34533453");

        // 3.adım : Statement oluştur.
        Statement st = con.createStatement();
        // 1.Örnek : iki paremetre (x ve y)ile çalışıp bunları toplayıp return yapan bir fonksyon oluşturalım.
        // 1. adım : Fonksyon kodunu yaz.
        String sql1 = "CREATE OR REPLACE FUNCTION addf(x NUMERIC, y NUMERIC)\n" +
                "RETURNS NUMERIC\n" +
                "LANGUAGE plpgsql\n" +
                "AS\n" +
                "$$\n" +
                "BEGIN\n" +
                "\n" +
                "RETURN x+y;\n" +
                "\n" +
                "END\n" +
                "$$";
        // 2. adım : Fonksyon'u çalıştır.
        st.execute(sql1);

        // 3. adım : Fonksyon'u çağır.
        CallableStatement cst1 = con.prepareCall("{? = call addf(?,?)}");

        // 4. adım : Return için registerOutParameter() methodunu, parametreler için set() methodlarından uygun olanları kullan.
        cst1.registerOutParameter(1,Types.NUMERIC);
        cst1.setInt(2,15);
        cst1.setInt(3,25);

        // 5. adım : Fonksyon'u çalıştırmak için Execute methodunu kullan.
        cst1.execute();

        // 6. adım : Sonucu çağırmak için Return data tipine göre "get" method'larından uygun olanı kullanacağız.
        cst1.getBigDecimal(1);
        System.out.println(cst1.getBigDecimal(1));

        // ------------------
        //2. Örnek: Koninin hacmini hesaplayan bir function yazın.

        // 1. adım : Fonksyon kodunu yaz.
        String sql2 = "CREATE OR REPLACE FUNCTION koniHacmi(r NUMERIC, h NUMERIC)\n" +
                "RETURNS NUMERIC\n" +
                "LANGUAGE plpgsql\n" +
                "AS\n" +
                "$$\n" +
                "BEGIN\n" +
                "\n" +
                "RETURN 3.14*r*r*h/3;\n" +
                "\n" +
                "END\n" +
                "$$";
        // 2. adım : Fonksyon'u çalıştır.
        st.execute(sql2);

        // 3. adım : Fonksyon'u çağır.
        CallableStatement cst2 = con.prepareCall("{? = call koniHacmi(?,?)}");

        // 4. adım : Return için registerOutParameter() methodunu, parametreler için set() methodlarından uygun olanları kullan.
        cst2.registerOutParameter(1,Types.NUMERIC);
        cst2.setInt(2,1);
        cst2.setInt(3,1);

        // 5. adım : Fonksyon'u çalıştırmak için Execute methodunu kullan.
        cst2.execute();

        // 6. adım : Sonucu çağırmak için Return data tipine göre "get" method'larından uygun olanı kullanacağız.
        cst2.getBigDecimal(1);
        System.out.println(cst2.getBigDecimal(1));

        con.close();
        st.close();


    }
}
