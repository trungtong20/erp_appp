import 'package:equatable/equatable.dart';
import 'package:erp_appp/data/models/response/product_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

// Cart Cubit
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  // Add a product to the cart
  void addProduct(ProductCardModel product) {
    final existingIndex =
        state.cartItems.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      final updatedList = List<ProductCardModel>.from(state.cartItems);
      final updatedProduct = updatedList[existingIndex]
          .copyWith(quantity: updatedList[existingIndex].quantity + 1);
      updatedList[existingIndex] = updatedProduct;
      emit(state.copyWith(cartItems: updatedList));
    } else {
      emit(state.copyWith(
          cartItems: [...state.cartItems, product.copyWith(quantity: 1)]));
    }
  }

  // Decrease product quantity or remove it if the quantity is 1
  void removeProduct(String productId) {
    final existingIndex =
        state.cartItems.indexWhere((item) => item.id == productId);

    if (existingIndex != -1) {
      final updatedList = List<ProductCardModel>.from(state.cartItems);
      final updatedProduct = updatedList[existingIndex];

      if (updatedProduct.quantity > 1) {
        updatedList[existingIndex] =
            updatedProduct.copyWith(quantity: updatedProduct.quantity - 1);
      } else {
        updatedList.removeAt(existingIndex);
      }

      emit(state.copyWith(cartItems: updatedList));
    }
  }

  // Completely remove a product from the cart
  void deleteProduct(String productId) {
    emit(state.copyWith(
        cartItems:
            state.cartItems.where((item) => item.id != productId).toList()));
  }

  void clearCart() {
    emit(const CartState(cartItems: []));
  }
}
