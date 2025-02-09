


part of 'product_user_cubit.dart';

class ProductUserState extends Equatable {
  final List<ProductVendorModel> products;
  final bool isLoading;
  final String? error;

  const ProductUserState({
    required this.products,
    this.isLoading = false,
    this.error,
  });

  ProductUserState copyWith({
    List<ProductVendorModel>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductUserState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
