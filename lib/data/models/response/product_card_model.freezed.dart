// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductCardModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductCardModelCopyWith<ProductCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCardModelCopyWith<$Res> {
  factory $ProductCardModelCopyWith(
          ProductCardModel value, $Res Function(ProductCardModel) then) =
      _$ProductCardModelCopyWithImpl<$Res, ProductCardModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String category,
      String image,
      int quantity});
}

/// @nodoc
class _$ProductCardModelCopyWithImpl<$Res, $Val extends ProductCardModel>
    implements $ProductCardModelCopyWith<$Res> {
  _$ProductCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? category = null,
    Object? image = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductCardModelImplCopyWith<$Res>
    implements $ProductCardModelCopyWith<$Res> {
  factory _$$ProductCardModelImplCopyWith(_$ProductCardModelImpl value,
          $Res Function(_$ProductCardModelImpl) then) =
      __$$ProductCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String category,
      String image,
      int quantity});
}

/// @nodoc
class __$$ProductCardModelImplCopyWithImpl<$Res>
    extends _$ProductCardModelCopyWithImpl<$Res, _$ProductCardModelImpl>
    implements _$$ProductCardModelImplCopyWith<$Res> {
  __$$ProductCardModelImplCopyWithImpl(_$ProductCardModelImpl _value,
      $Res Function(_$ProductCardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? category = null,
    Object? image = null,
    Object? quantity = null,
  }) {
    return _then(_$ProductCardModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProductCardModelImpl implements _ProductCardModel {
  const _$ProductCardModelImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.image,
      this.quantity = 1});

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  final String category;
  @override
  final String image;
  @override
  @JsonKey()
  final int quantity;

  @override
  String toString() {
    return 'ProductCardModel(id: $id, name: $name, price: $price, category: $category, image: $image, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, price, category, image, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCardModelImplCopyWith<_$ProductCardModelImpl> get copyWith =>
      __$$ProductCardModelImplCopyWithImpl<_$ProductCardModelImpl>(
          this, _$identity);
}

abstract class _ProductCardModel implements ProductCardModel {
  const factory _ProductCardModel(
      {required final String id,
      required final String name,
      required final double price,
      required final String category,
      required final String image,
      final int quantity}) = _$ProductCardModelImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  String get category;
  @override
  String get image;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ProductCardModelImplCopyWith<_$ProductCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
