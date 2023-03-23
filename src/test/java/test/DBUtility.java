package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class DBUtility {

	private static final String db_url = "jdbc:mysql://tek-database-server.mysql.database.azure.com:3306/tek_insurance_app?useSSL=true&requireSSL=false";
	private static final String db_userName = "tek_student_user";
	private static final String db_password = "MAY_2022";

	private static Statement getConnectionStatement() {
		try {
			Connection con = DriverManager.getConnection(db_url, db_userName, db_password);
			return con.createStatement();
		} catch (SQLException e) {
			throw new RuntimeException("Error creating statement...");
		}
	}

	public static ResultSet executeQuery(String query) {
		try {
			ResultSet resultSet = getConnectionStatement().executeQuery(query);
			return resultSet;
		} catch (SQLException e) {
			throw new RuntimeException("Error generating result...");
		}
	}

	public static List<Map<String, Object>> queryResult(String query) {
		Statement statement = null;
		try {
			List<Map<String, Object>> list = new LinkedList<>();
			ResultSet resultSet = executeQuery(query);
			statement = resultSet.getStatement();
			ResultSetMetaData metadata = resultSet.getMetaData();
			int columns = metadata.getColumnCount();

			while (resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				for (int i = 1; i <= columns; i++) {
					map.put(metadata.getColumnName(i), resultSet.getObject(i));
				}
				list.add(map);
			}

			return list;
		} catch (SQLException e) {
			throw new RuntimeException("Error executing query");
		} finally {
			if (statement != null) {
				try {
					statement.getConnection().close();
					statement.close();
				} catch (SQLException e) {

				}
			}
		}

	}

	public static String result(String query, String columnName) {
		List<Map<String, Object>> result = queryResult(query);
		return result.get(0).get(columnName).toString();
	}

}
