import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String? restaurantId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.restaurantId,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          restaurantId: restaurantId,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        restaurantId: json['restaurantId'],
      );

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
    if (restaurantId != null) data['restaurantId'] = restaurantId!;
    return data;
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? restaurantId,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}
