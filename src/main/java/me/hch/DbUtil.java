package me.hch;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created with IntelliJ IDEA.
 * User: hch
 * Date: 14-3-12
 * Time: 下午8:28
 * To change this template use File | Settings | File Templates.
 */
public class DbUtil {
    public static void main(String[] args) {


    }

    public static void initH2Database() {
        String dir = System.getProperty("web.root");
        
        Class.forName("org.h2.Driver");
        Connection conn = DriverManager.getConnection("jdbc:h2:~/term_project", "sa", "");
        // add application code here
        conn.close();
    }
}
