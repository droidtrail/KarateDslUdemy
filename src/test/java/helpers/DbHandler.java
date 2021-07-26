package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbHandler {
    private static String connectionUrl = "jdbc:sqlserver://localhost:14330;database=Pubs;user=sa;password=PaSSw0d";

    public static void addNewJobWithName(String jobName) {
        try (Connection connection = DriverManager.getConnection(connectionUrl)) {
        connection.createStatement().execute("INSERT INTO [Pubs].[dbo].[jobs] (job_desc, min_lvl, max_lvl)VALUES ('"+jobName+"', 50, 100)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
