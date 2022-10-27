package jdbc;

import java.sql.*;

public class ExecuteQuery01 {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        // 1. adım : Driver'a kaydol
        Class.forName("org.postgresql.Driver");

        // 2. adım : Database'e baglan.
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/techproed","postgres","34533453");

        // 3.adım : Statement oluştur.
        Statement st = con.createStatement();

        // 1. Örnek : companies tablosundan en yüksek ikinci number_of_employees değeri olan company ve number_of_employees değerlerini çağırın.
        // 1. yol : OFFSET ve FETCH NEXT kullanarak.
        String sql1 = "select company, number_of_employees\n" +
                "from companies\n" +
                "order by number_of_employees desc\n" +
                "OFFSET 1 ROW\n" +
                "FETCH NEXT 1 ROW ONLY";

        st.executeQuery(sql1);

        ResultSet result1= st.executeQuery(sql1);

        while(result1.next()){
            System.out.println(result1.getString("company")+" "+result1.getInt("number_of_employees"));
        }
        System.out.println("\n");

        // 2.YOL : Subquery kullanarak
        String sql2 = "select company, number_of_employees\n" +
                "from companies\n" +
                "where number_of_employees = (select max(number_of_employees)from companies\n" +
                "where number_of_employees < (select max(number_of_employees)from companies))";
        st.executeQuery(sql2);
        ResultSet result2 = st.executeQuery(sql2);

        while(result2.next()){
            System.out.println(result2.getString("company")+" "+result2.getInt("number_of_employees"));
        }
        con.close();
        st.close();
        result1.close();
        result2.close();
    }
}
