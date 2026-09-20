package com.vt.vtmart.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.stream.Collectors;

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

    private static void initDatabaseSchema() {
        if (schemaInitialized) return;
        try (Connection conn = dataSource.getConnection();
             InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("schema.sql")) {
            
            if (is != null) {
                String sql = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))
                        .lines().collect(Collectors.joining("\n"));
                
                try (Statement stmt = conn.createStatement()) {
                    stmt.execute(sql);
                    schemaInitialized = true;
                    System.out.println("VTMart Database schema and gym products initialized successfully!");
                }
            } else {
                System.err.println("schema.sql not found in classpath!");
            }
        } catch (Exception e) {
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
