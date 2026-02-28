import 'package:ai_expense_tracker/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.uid,
  });

  factory UserModel.fromFirebase(Map<String, dynamic> data, String uid) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      uid: uid,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
