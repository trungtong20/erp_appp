part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<ProductCardModel> cartItems;

  const CartState({this.cartItems = const []});

  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  @override
  List<Object> get props => [cartItems];

  // Create a new copy of the state with an updated product list
  CartState copyWith({List<ProductCardModel>? cartItems}) {
    return CartState(cartItems: cartItems ?? this.cartItems);
  }
}
