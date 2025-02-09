import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:mysql_client/mysql_client.dart';

class ProductsTable {
  final MySQLConnection connection;

  ProductsTable({required this.connection});

    Future<void> createTable() async {
    try {
      await connection.execute('''
        CREATE TABLE IF NOT EXISTS products (
          id VARCHAR(50) PRIMARY KEY,
          name VARCHAR(255) NOT NULL,
          price DOUBLE NOT NULL,
          image_url TEXT NOT NULL,
          quantity INT NOT NULL DEFAULT 1
        )
      ''');
      print("✅ Table 'products' created or already exists!");
    } catch (e) {
      print("❌ Error creating table: $e");
    }
  }


  Future<List<ProductVendorModel>> getProducts() async {
    try {
      var result = await connection.execute("SELECT * FROM products");
      List<ProductVendorModel> products = [];

      for (var row in result.rows) {
        products.add(ProductVendorModel(
          id: row.assoc()["id"]!,
          name: row.assoc()["name"]!,
          price: double.parse(row.assoc()["price"]!),
          imageUrl: row.assoc()["image_url"]!,
          quantity: int.parse(row.assoc()["quantity"]!),
        ));
      }
      return products;
    } catch (e) {
      print("❌ Error fetching products: $e");
      return [];
    }
  }

  Future<void> addProduct(ProductVendorModel product) async {
    try {
      await connection.execute(
        "INSERT INTO products (id, name, price, image_url, quantity) VALUES (:id, :name, :price, :image_url, :quantity)",
        {
          "id": product.id,
          "name": product.name,
          "price": product.price,
          "image_url": product.imageUrl,
          "quantity": product.quantity,
        },
      );
      print("✅ Product added successfully!");
    } catch (e) {
      print("❌ Error adding product: $e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await connection.execute(
        "DELETE FROM products WHERE id = :id",
        {"id": productId},
      );
      print("✅ Product deleted successfully!");
    } catch (e) {
      print("❌ Error deleting product: $e");
    }
  }
}
