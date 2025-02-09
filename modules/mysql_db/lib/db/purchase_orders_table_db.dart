import 'package:mysql_client/mysql_client.dart';

class PurchaseOrdersTable {
  final MySQLConnection connection;

  PurchaseOrdersTable({required this.connection});

  Future<void> createTable() async {
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS purchase_orders (
        id INT AUTO_INCREMENT PRIMARY KEY,
        supplier_id INT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        status ENUM('Pending', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Pending',
        FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> addOrder(int supplierId, String status) async {
    await connection.execute('''
      INSERT INTO purchase_orders (supplier_id, status) VALUES (:supplier_id, :status)
    ''', {
      "supplier_id": supplierId,
      "status": status,
    });
  }

  Future<void> deleteOrder(int id) async {
    await connection.execute('DELETE FROM purchase_orders WHERE id = :id', {"id": id});
  }
}
