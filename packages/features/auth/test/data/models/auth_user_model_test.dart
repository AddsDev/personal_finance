import 'package:auth/data/models/auth_user_model.dart';
import 'package:auth/domain/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseUser extends Mock implements firebase.User {}

void main() {
  final mockFirebaseUser = MockFirebaseUser();

  setUp(() {
    when(() => mockFirebaseUser.uid).thenReturn('123');
    when(() => mockFirebaseUser.email).thenReturn('test@test.com');
    when(() => mockFirebaseUser.displayName).thenReturn('Test User');
    when(() => mockFirebaseUser.photoURL).thenReturn('http://photo.url');
  });

  test('should be a subclass of AuthUser entity', () {
    const tUserModel = AuthUserModel(id: '123', email: 'test@test.com');
    expect(tUserModel, isA<AuthUser>());
  });

  test('fromFirebaseUser should return valid model', () {
    final result = AuthUserModel.fromFirebaseUser(mockFirebaseUser);

    expect(result.id, '123');
    expect(result.email, 'test@test.com');
    expect(result.name, 'Test User');
    expect(result.photoUrl, 'http://photo.url');
  });

  test('fromFirebaseUser should manage null email', () {
    when(() => mockFirebaseUser.email).thenReturn(null);

    final result = AuthUserModel.fromFirebaseUser(mockFirebaseUser);

    expect(result.email, '');
  });
}
