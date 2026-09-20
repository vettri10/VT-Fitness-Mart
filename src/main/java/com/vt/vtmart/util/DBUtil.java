package com.vt.vtmart.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.h2.tools.RunScript;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static volatile HikariDataSource dataSource;
    private static boolean schemaInitialized = false;

    public static synchronized void initializePool() {
        if (dataSource == null || dataSource.isClosed()) {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:h2:mem:vtmart_db;DB_CLOSE_DELAY=-1;MODE=MySQL");
            config.setDriverClassName("org.h2.Driver");
            config.setUsername("sa");
            config.setPassword("");
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(30000);
            config.setConnectionTimeout(30000);

            dataSource = new HikariDataSource(config);
            initDatabaseSchema();
        }
    }

    private static synchronized void initDatabaseSchema() {
        if (schemaInitialized) return;
        try (Connection conn = dataSource.getConnection();
             InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("schema.sql")) {

            if (is != null) {
                RunScript.execute(conn, new InputStreamReader(is, StandardCharsets.UTF_8));
                schemaInitialized = true;
                System.out.println("VTMart Database initialized with all tables and gym products via RunScript!");
            } else {
                System.err.println("CRITICAL: schema.sql NOT found in classpath!");
            }
        } catch (Exception e) {
            System.err.println("Failed to initialize database schema: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null || dataSource.isClosed()) {
            initializePool();
        }
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}
