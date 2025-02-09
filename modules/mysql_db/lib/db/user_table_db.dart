import 'package:mysql_client/mysql_client.dart';

class UsersTable {
  final MySQLConnection _db;

  UsersTable(this._db);

  Future<void> createTable() async {
    try {
      await _db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(100) NOT NULL,
          email VARCHAR(100) UNIQUE NOT NULL,
          role ENUM('admin', 'user', 'vendor') NOT NULL
        )
      ''');
      print("✅ Table 'users' created or already exists!");
    } catch (e) {
      print("❌ Table creation error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      var result = await _db.execute('SELECT * FROM users');
      return result.rows.map((row) => row.assoc()).toList();
    } catch (e) {
      print("❌ Error fetching users: $e");
      return [];
    }
  }

  Future<void> insertUser(String name, String email, String role) async {
    try {
      await _db.execute(
        'INSERT INTO users (name, email, role) VALUES (:name, :email, :role)',
        {
          'name': name,
          'email': email,
          'role': role,
        },
      );
      print("✅ User inserted successfully!");
    } catch (e) {
      print("❌ Error inserting user: $e");
    }
  }
}
