import 'package:hive/hive.dart';
import 'package:rms/features/user/domain/entities/user.dart';

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
  final String restaurantId;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.restaurantId,
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
        restaurantId: json['restaurantId'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'restaurantId': restaurantId,
      };
}
