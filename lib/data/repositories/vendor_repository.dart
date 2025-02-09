import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:erp_appp/data/service/product_table_db.dart';

sealed class VendorRepository {
  Future<List<ProductVendorModel>> getProducts();
  Future<void> addProduct(ProductVendorModel product);
  Future<void> deleteProduct(String productId);
}

class VendorRepositoryImpl implements VendorRepository {
  final ProductsTable productsTable;

  VendorRepositoryImpl({required this.productsTable});

  @override
  Future<List<ProductVendorModel>> getProducts() async {
    return await productsTable.getProducts();
  }

  @override
  Future<void> addProduct(ProductVendorModel product) async {
    await productsTable.addProduct(product);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await productsTable.deleteProduct(productId);
  }
}
