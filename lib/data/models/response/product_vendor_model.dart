import 'dart:io';

class ProductVendorModel {
  String id;
  String name;
  double price;
  File image;
  int quantity;

  ProductVendorModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}
