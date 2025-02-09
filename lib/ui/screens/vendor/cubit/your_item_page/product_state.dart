


part of 'product_cubit.dart';

class ProductState extends Equatable {
  final List<ProductVendorModel> products;
  final bool isLoading;
  final String? error;

  const ProductState({
    required this.products,
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<ProductVendorModel>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
