import 'package:equatable/equatable.dart';
import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:erp_appp/data/repositories/vendor_repository.dart';
import 'package:erp_appp/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final VendorRepository repository = serviceLocator.get<VendorRepository>();

  ProductCubit() : super(const ProductState(products: []));

  // Fetch products from repository
  Future<void> fetchProducts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final products = await repository.getProducts();
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Add a new product
  Future<void> addProduct(ProductVendorModel product) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.addProduct(product);
      emit(state
          .copyWith(products: [...state.products, product], isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await repository.deleteProduct(productId);
      emit(state.copyWith(
        products:
            state.products.where((product) => product.id != productId).toList(),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
