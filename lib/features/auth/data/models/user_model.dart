import 'package:ai_expense_tracker/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.name,
    required super.email,
    required super.uid,
    super.imageUrl = 'assets/images/default_avatar.jpeg',
  });

  factory UserModel.fromFirebase(Map<String, dynamic> data, String uid) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      uid: uid,
      imageUrl: data['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'image_url': imageUrl};
  }
}
