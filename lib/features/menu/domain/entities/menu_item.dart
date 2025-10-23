import 'package:freezed_annotation/freezed_annotation.dart';
part 'menu_item.freezed.dart';
part 'menu_item.g.dart';

@freezed
class MenuItemEntity with _$MenuItemEntity {
  const factory MenuItemEntity({
    required String id,
    required String name,
    required String price,
    required bool available,
    required List<String> cuisine,
    required List<String> categories,
    required bool typeItem,
    required String imageUrl,
    required String ingredient,
  }) = _MenuItemEntity;

  factory MenuItemEntity.fromJson(Map<String, dynamic> json) => _$MenuItemEntityFromJson(json);
}
