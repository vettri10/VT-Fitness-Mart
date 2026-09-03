package com.vt.vtmart.listener;

import com.vt.vtmart.util.DBUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import org.h2.tools.RunScript;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            DBUtil.initializePool();
            initDatabase();
        } catch (Exception e) {
            System.err.println("Database initialization failed in listener: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void initDatabase() {
        InputStream in = getClass().getClassLoader().getResourceAsStream("schema.sql");
        if (in == null) {
            in = Thread.currentThread().getContextClassLoader().getResourceAsStream("schema.sql");
        }

        if (in == null) {
            System.err.println("FATAL: schema.sql not found in resources!");
            return;
        }

        try (Connection conn = DBUtil.getConnection();
             InputStreamReader reader = new InputStreamReader(in, StandardCharsets.UTF_8)) {
            RunScript.execute(conn, reader);
            System.out.println("=================================================");
            System.out.println("VTMart Database Schema & Seeds Loaded via RunScript!");
            System.out.println("=================================================");
        } catch (Exception e) {
            System.err.println("Error running schema.sql: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DBUtil.closePool();
    }
}
