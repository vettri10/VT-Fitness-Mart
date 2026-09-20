package com.vt.vtmart.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static HikariDataSource dataSource;

    public static synchronized void initializePool() {
        if (dataSource == null) {
            // Permission safe user home directory (C:/Users/Bhara/vtmart_db)
            String dbDir = System.getProperty("user.home") + File.separator + "vtmart_db";
            File dir = new File(dbDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String dbPath = dbDir + File.separator + "vtmart";
            // Forward slashes for JDBC URL compatibility
            dbPath = dbPath.replace("\\", "/");

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:h2:file:" + dbPath + ";DB_CLOSE_DELAY=-1;AUTO_SERVER=TRUE");
            config.setDriverClassName("org.h2.Driver");
            config.setUsername("sa");
            config.setPassword("");
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(30000);
            config.setConnectionTimeout(30000);

            dataSource = new HikariDataSource(config);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
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
