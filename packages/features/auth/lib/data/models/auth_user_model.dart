import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.email,
    super.name,
    super.photoUrl,
  });

  /// Factory para convertir un User de Firebase a nuestro AuthUser
  factory AuthUserModel.fromFirebaseUser(firebase.User user) {
    return AuthUserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  AuthUser toEntity() {
    return AuthUser(id: id, email: email, name: name, photoUrl: photoUrl);
  }
}
