// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenuItemEntity _$MenuItemEntityFromJson(Map<String, dynamic> json) {
  return _MenuItemEntity.fromJson(json);
}

/// @nodoc
mixin _$MenuItemEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;
  List<String> get cuisine => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  bool get typeItem => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get ingredient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenuItemEntityCopyWith<MenuItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemEntityCopyWith<$Res> {
  factory $MenuItemEntityCopyWith(
          MenuItemEntity value, $Res Function(MenuItemEntity) then) =
      _$MenuItemEntityCopyWithImpl<$Res, MenuItemEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String price,
      bool available,
      List<String> cuisine,
      List<String> categories,
      bool typeItem,
      String imageUrl,
      String ingredient});
}

/// @nodoc
class _$MenuItemEntityCopyWithImpl<$Res, $Val extends MenuItemEntity>
    implements $MenuItemEntityCopyWith<$Res> {
  _$MenuItemEntityCopyWithImpl(this._value, this._then);

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
    Object? available = null,
    Object? cuisine = null,
    Object? categories = null,
    Object? typeItem = null,
    Object? imageUrl = null,
    Object? ingredient = null,
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
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      cuisine: null == cuisine
          ? _value.cuisine
          : cuisine // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      typeItem: null == typeItem
          ? _value.typeItem
          : typeItem // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuItemEntityImplCopyWith<$Res>
    implements $MenuItemEntityCopyWith<$Res> {
  factory _$$MenuItemEntityImplCopyWith(_$MenuItemEntityImpl value,
          $Res Function(_$MenuItemEntityImpl) then) =
      __$$MenuItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String price,
      bool available,
      List<String> cuisine,
      List<String> categories,
      bool typeItem,
      String imageUrl,
      String ingredient});
}

/// @nodoc
class __$$MenuItemEntityImplCopyWithImpl<$Res>
    extends _$MenuItemEntityCopyWithImpl<$Res, _$MenuItemEntityImpl>
    implements _$$MenuItemEntityImplCopyWith<$Res> {
  __$$MenuItemEntityImplCopyWithImpl(
      _$MenuItemEntityImpl _value, $Res Function(_$MenuItemEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? available = null,
    Object? cuisine = null,
    Object? categories = null,
    Object? typeItem = null,
    Object? imageUrl = null,
    Object? ingredient = null,
  }) {
    return _then(_$MenuItemEntityImpl(
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
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      cuisine: null == cuisine
          ? _value._cuisine
          : cuisine // ignore: cast_nullable_to_non_nullable
              as List<String>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      typeItem: null == typeItem
          ? _value.typeItem
          : typeItem // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemEntityImpl implements _MenuItemEntity {
  const _$MenuItemEntityImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.available,
      required final List<String> cuisine,
      required final List<String> categories,
      required this.typeItem,
      required this.imageUrl,
      required this.ingredient})
      : _cuisine = cuisine,
        _categories = categories;

  factory _$MenuItemEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String price;
  @override
  final bool available;
  final List<String> _cuisine;
  @override
  List<String> get cuisine {
    if (_cuisine is EqualUnmodifiableListView) return _cuisine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cuisine);
  }

  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final bool typeItem;
  @override
  final String imageUrl;
  @override
  final String ingredient;

  @override
  String toString() {
    return 'MenuItemEntity(id: $id, name: $name, price: $price, available: $available, cuisine: $cuisine, categories: $categories, typeItem: $typeItem, imageUrl: $imageUrl, ingredient: $ingredient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.available, available) ||
                other.available == available) &&
            const DeepCollectionEquality().equals(other._cuisine, _cuisine) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.typeItem, typeItem) ||
                other.typeItem == typeItem) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      available,
      const DeepCollectionEquality().hash(_cuisine),
      const DeepCollectionEquality().hash(_categories),
      typeItem,
      imageUrl,
      ingredient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemEntityImplCopyWith<_$MenuItemEntityImpl> get copyWith =>
      __$$MenuItemEntityImplCopyWithImpl<_$MenuItemEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemEntityImplToJson(
      this,
    );
  }
}

abstract class _MenuItemEntity implements MenuItemEntity {
  const factory _MenuItemEntity(
      {required final String id,
      required final String name,
      required final String price,
      required final bool available,
      required final List<String> cuisine,
      required final List<String> categories,
      required final bool typeItem,
      required final String imageUrl,
      required final String ingredient}) = _$MenuItemEntityImpl;

  factory _MenuItemEntity.fromJson(Map<String, dynamic> json) =
      _$MenuItemEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get price;
  @override
  bool get available;
  @override
  List<String> get cuisine;
  @override
  List<String> get categories;
  @override
  bool get typeItem;
  @override
  String get imageUrl;
  @override
  String get ingredient;
  @override
  @JsonKey(ignore: true)
  _$$MenuItemEntityImplCopyWith<_$MenuItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
