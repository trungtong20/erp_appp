import 'package:mysql_client/mysql_client.dart';

class SuppliersTable {
  final MySQLConnection connection;

  SuppliersTable({required this.connection});

  Future<void> createTable() async {
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS suppliers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        address TEXT,
        contact_info VARCHAR(255)
      )
    ''');
  }

  Future<void> addSupplier(String name, String address, String contactInfo) async {
    await connection.execute('''
      INSERT INTO suppliers (name, address, contact_info) VALUES (:name, :address, :contact_info)
    ''', {
      "name": name,
      "address": address,
      "contact_info": contactInfo,
    });
  }

  Future<void> deleteSupplier(int id) async {
    await connection.execute('DELETE FROM suppliers WHERE id = :id', {"id": id});
  }
}
