


part of 'product_admin_cubit.dart';

class ProductAdminState extends Equatable {
  final List<ProductVendorModel> products;
  final bool isLoading;
  final String? error;

  const ProductAdminState({
    required this.products,
    this.isLoading = false,
    this.error,
  });

  ProductAdminState copyWith({
    List<ProductVendorModel>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductAdminState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
