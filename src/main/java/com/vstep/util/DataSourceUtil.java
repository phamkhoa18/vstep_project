package com.vstep.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.cj.jdbc.MysqlDataSource;

public class DataSourceUtil {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/vstepdb?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "01265737697Khoa";

    private static final String JNDI_NAME = "java:comp/env/jdbc/vstepdb";

    private static volatile DataSource dataSource;

    private DataSourceUtil() {
    }

    public static DataSource getDataSource() {
        if (dataSource == null) {
            synchronized (DataSourceUtil.class) {
                if (dataSource == null) {
                    dataSource = initDataSource();
                }
            }
        }
        return dataSource;
    }

    private static DataSource initDataSource() {
        DataSource jndiDataSource = tryLookupJndi();
        if (jndiDataSource != null && canObtainConnection(jndiDataSource)) {
            return jndiDataSource;
        }
        return createMysqlDataSource();
    }

    private static DataSource tryLookupJndi() {
        try {
            Context ctx = new InitialContext();
            return (DataSource) ctx.lookup(JNDI_NAME);
        } catch (Exception e) {
            return null;
        }
    }

    private static boolean canObtainConnection(DataSource ds) {
        try (Connection ignored = ds.getConnection()) {
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    private static DataSource createMysqlDataSource() {
        MysqlDataSource mysqlDataSource = new MysqlDataSource();
        mysqlDataSource.setURL(JDBC_URL);
        mysqlDataSource.setUser(JDBC_USERNAME);
        mysqlDataSource.setPassword(JDBC_PASSWORD);
        return mysqlDataSource;
    }

    public static Connection getConnection() throws SQLException {
        return getDataSource().getConnection();
    }
}

