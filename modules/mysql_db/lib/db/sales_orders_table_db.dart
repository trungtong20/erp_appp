import 'package:mysql_client/mysql_client.dart';

class SalesOrdersTable {
  final MySQLConnection connection;

  SalesOrdersTable({required this.connection});

  Future<void> createTable() async {
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS sales_orders (
        id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
        FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> addOrder(int customerId, String status) async {
    await connection.execute('''
      INSERT INTO sales_orders (customer_id, status) VALUES (:customer_id, :status)
    ''', {
      "customer_id": customerId,
      "status": status,
    });
  }

  Future<void> deleteOrder(int id) async {
    await connection.execute('DELETE FROM sales_orders WHERE id = :id', {"id": id});
  }
}
