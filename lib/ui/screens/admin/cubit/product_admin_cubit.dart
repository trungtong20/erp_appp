import 'package:equatable/equatable.dart';
import 'package:erp_appp/data/models/response/product_vendor_model.dart';
import 'package:erp_appp/data/repositories/vendor_repository.dart';
import 'package:erp_appp/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_admin_state.dart';

class ProductAdminCubit extends Cubit<ProductAdminState> {
  final VendorRepository repository = serviceLocator.get<VendorRepository>();

  ProductAdminCubit() : super(const ProductAdminState(products: []));

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
}
