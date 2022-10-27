package jdbcPractise;

import static jdbcPractise.DatabaseUtilty.*;

public class Query06 {

    public static void main(String[] args) {

        createConnection();

        String query = "SELECT * FROM ogrenciler";
        System.out.println("sutun isimleri :  " + getColumnNames(query));

        System.out.println("okul no: "+getColumnData(query, "okul_no"));
        System.out.println("ogrenci ismi: "+getColumnData(query, "ogrenci_ismi"));
        System.out.println("sınıf: "+getColumnData(query, "sinif"));
        System.out.println("Cinsiyet: "+getColumnData(query, "cinsiyet"));

    }
}
