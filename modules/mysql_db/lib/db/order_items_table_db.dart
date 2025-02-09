import 'package:mysql_client/mysql_client.dart';

class OrderItemsTable {
  final MySQLConnection connection;

  OrderItemsTable({required this.connection});

  Future<void> createTable() async {
    await connection.execute('''
      CREATE TABLE IF NOT EXISTS order_items (
        id INT AUTO_INCREMENT PRIMARY KEY,
        order_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL CHECK (quantity > 0),
        price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
        FOREIGN KEY (order_id) REFERENCES sales_orders(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> addOrderItem(int orderId, int productId, int quantity, double price) async {
    await connection.execute('''
      INSERT INTO order_items (order_id, product_id, quantity, price) 
      VALUES (:order_id, :product_id, :quantity, :price)
    ''', {
      "order_id": orderId,
      "product_id": productId,
      "quantity": quantity,
      "price": price,
    });
  }

  Future<void> deleteOrderItem(int id) async {
    await connection.execute('DELETE FROM order_items WHERE id = :id', {"id": id});
  }
}
