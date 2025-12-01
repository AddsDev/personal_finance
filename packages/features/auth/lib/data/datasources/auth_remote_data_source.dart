import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_user_model.dart';
import 'package:core/errors/failure.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthUserModel> get user;

  Future<AuthUserModel> loginWithEmail(String email, String password);

  Future<AuthUserModel> registerWithEmail(
      String name,
      String email,
      String password,
      );

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<AuthUserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return const AuthUserModel(id: '', email: ''); // Empty
      }
      return AuthUserModel.fromFirebaseUser(firebaseUser);
    });
  }

  @override
  Future<AuthUserModel> loginWithEmail(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) {
        throw const ServerFailure('Usuario nulo tras login');
      }
      return AuthUserModel.fromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(_mapFirebaseError(e.code));
    } catch (e) {
      throw const ServerFailure();
    }
  }

  @override
  Future<AuthUserModel> registerWithEmail(
      String name,
      String email,
      String password,
      ) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await result.user!.updateDisplayName(name);

        await result.user!.reload();
        final updatedUser = _firebaseAuth.currentUser;
        return AuthUserModel.fromFirebaseUser(updatedUser!);
      } else {
        throw const ServerFailure('Falló la creación de usuario');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(_mapFirebaseError(e.code));
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'channel-error':
        return 'Contraseña y usuario son requeridos';
      case 'invalid-credential':
        return 'Contraseña o Usuario incorrectos';
      case 'email-already-in-use':
        return 'El correo ya está registrado';
      case 'weak-password':
        return 'La contraseña es muy débil';
      default:
        return 'Error de autenticación: $code';
    }
  }
}
