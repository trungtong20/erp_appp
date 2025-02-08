import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  late MySQLConnection _connection;

  Future<void> initConnection() async {
    try {
      _connection = await MySQLConnection.createConnection(
        // host: "sql12.freesqldatabase.com",
        // port: 3306,
        // userName: "sql12761718",
        // password: "DuG3qEHqDp",
        // databaseName: "sql12761718",
        host: "gw.techarrow.asia",
        port: 30231,
        userName: "root",
        password: "inv3st@Mysql2025",
        databaseName: "trungtong",
        secure: false,
      );
      await _connection.connect();
      print("✅ Database connected!");
      await createTable();
    } catch (e) {
      print("❌ Database connection error: $e");
    }
  }

  Future<void> createTable() async {
    try {
      await _connection.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(100) NOT NULL,
          email VARCHAR(100) UNIQUE NOT NULL,
          role ENUM('admin', 'user', 'vendor') NOT NULL
        )
      ''');
      print("✅ Table created or already exists!");
    } catch (e) {
      print("❌ Table creation error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    try {
      var result = await _connection.execute('SELECT * FROM $table');
      List<Map<String, dynamic>> data = [];

      for (final row in result.rows) {
        Map<String, dynamic> rowMap = {};
        for (final field in row.assoc().entries) {
          rowMap[field.key] = field.value;
        }
        data.add(rowMap);
      }
      return data;
    } catch (e) {
      print("❌ Error fetching data: $e");
      return [];
    }
  }

  Future<void> insertData(String table, Map<String, dynamic> data) async {
    try {
      final fields = data.keys.join(', ');
      final values = data.keys.map((key) => ":$key").join(', ');

      final sql = 'INSERT INTO $table ($fields) VALUES ($values)';

      await _connection.execute(sql, data);

      print("✅ Data inserted successfully!");
    } catch (e) {
      print("❌ Error inserting data: $e");
    }
  }

  Future<void> updateData(String table, Map<String, dynamic> data,
      String whereColumn, dynamic whereValue) async {
    try {
      final fields = data.keys.map((key) => "$key = :$key").join(', ');

      final sql = 'UPDATE $table SET $fields WHERE $whereColumn = :whereValue';

      final params = {...data, 'whereValue': whereValue};

      await _connection.execute(sql, params);

      print("✅ Data updated successfully!");
    } catch (e) {
      print("❌ Error updating data: $e");
    }
  }

Future<void> deleteData(String table, String condition) async {
  try {
    await _connection.execute(
      'DELETE FROM $table WHERE $condition',
    );
    print("✅ Data deleted successfully!");
  } catch (e) {
    print("❌ Error deleting data: $e");
  }
}



  Future<void> closeConnection() async {
    try {
      await _connection.close();
      print("✅ Database connection closed.");
    } catch (e) {
      print("❌ Error closing database: $e");
    }
  }
}
