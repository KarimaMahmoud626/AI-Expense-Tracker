import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? name;
  final String email;
  final String? imageUrl;

  const UserEntity({
    required this.uid,
    this.name,
    required this.email,
    this.imageUrl = 'assets/images/default_avatar.jpeg',
  });

  @override
  List<Object?> get props => [uid, name, email, imageUrl];
}
