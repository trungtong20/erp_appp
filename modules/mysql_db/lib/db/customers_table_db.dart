import 'package:mysql_client/mysql_client.dart';

class CustomersTable {
  final MySQLConnection connection;

  CustomersTable({required this.connection});

  Future<void> createTable() async {
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS customers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        address TEXT,
        contact_info VARCHAR(255)
      )
    ''');
  }

  Future<void> addCustomer(String name, String address, String contactInfo) async {
    await connection.execute('''
      INSERT INTO customers (name, address, contact_info) VALUES (:name, :address, :contact_info)
    ''', {
      "name": name,
      "address": address,
      "contact_info": contactInfo,
    });
  }

  Future<void> deleteCustomer(int id) async {
    await connection.execute('DELETE FROM customers WHERE id = :id', {"id": id});
  }
}
