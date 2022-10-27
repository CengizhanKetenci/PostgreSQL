package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Execute01 {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        // 1. adım : Driver'a kaydol
        Class.forName("org.postgresql.Driver");

        // 2. adım : Database'e baglan.
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/techproed","postgres","34533453");

        // 3.adım : Statement oluştur.
        Statement st = con.createStatement();

        // 4. adım : Query çalıştır.
        
        //1.Örnek: "workers" adında bir table oluşturup "worker_id,worker_name, worker_salary" sütunlarını ekleyin.
        String sql1 = "CREATE TABLE workers(worker_id VARCHAR(50), worker_name VARCHAR(50), worker_salary INT)";
        boolean result = st.execute(sql1);
        System.out.println("result = " + result); // false return eder. cunku data çağrılmadı.

        //2.Örnek: Alter table by adding worker_address column into the workers table
        //2.Örnek: Table'a worker_address sütunu ekleyerek alter yapın.

        String sql2 = "ALTER TABLE workers ADD worker_adress VARCHAR(80)";
        boolean result2 = st.execute(sql2);
        System.out.println("result2 = " + result2);

        //3.Örnek: Drop workers table
        String sql3 = "DROP TABLE workers";
        boolean result3= st.execute(sql3);
        System.out.println("result3 = " + result3);

        // 5.Adım : Bağlantı ve Statement'ı kapat.
        con.close();
        st.close();

    }
}



/*
Statement  : Statik bir SQL ifadesi yürütmek ve ürettiği sonuçları döndürmek için kullanılan nesne.
Varsayılan olarak, aynı anda Statement nesnesi başına yalnızca bir ResultSet nesnesi açılabilir.
Bu nedenle, bir ResultSet nesnesinin okuması diğerinin okumasıyla aralanmışsa,
her biri farklı Statement nesneleri tarafından oluşturulmuş olmalıdır. Açık bir varsa,
Statement arabirimindeki tüm yürütme yöntemleri, ifadenin geçerli bir ResultSet nesnesini örtük olarak kapatır.
 */