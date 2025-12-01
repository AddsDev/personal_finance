import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;

  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
  });

  static const empty = AuthUser(id: '', email: '');
  bool get isEmpty => id == AuthUser.empty.id;
  bool get isNotEmpty => id != AuthUser.empty.id;

  @override
  List<Object?> get props => [id, email, name, photoUrl];
}