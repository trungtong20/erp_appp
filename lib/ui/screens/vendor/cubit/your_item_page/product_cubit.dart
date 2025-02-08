import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<List<ProductVendorModel>> {
  ProductCubit() : super([]);

  // Add a new product
  void addProduct(ProductVendorModel product) {
    emit([...state, product]);
  }

  // Delete a product
  void deleteProduct(String productId) {
    emit(state.where((product) => product.id != productId).toList());
  }
}
