import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_card_model.freezed.dart';

@freezed
class ProductCardModel with _$ProductCardModel {
  const factory ProductCardModel({
    required String id,
    required String name,
    required double price,
    required String category,
    required String image,
    @Default(1) int quantity,
  }) = _ProductCardModel;
}
