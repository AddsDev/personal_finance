import 'package:auth/auth.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_kit/ui_kit.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: LoginPage(onRegisterTap: () {}),
      ),
    );
  }

  testWidgets('should display email and password inputs', (tester) async {
    when(
      () => mockAuthBloc.state,
    ).thenReturn(const AuthState.unauthenticated());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(AppInput), findsNWidgets(2));
    expect(find.text('Iniciar Sesión'), findsOneWidget);
  });

  testWidgets('show error snackbar when state has errorMessage', (
    tester,
  ) async {
    whenListen(
      mockAuthBloc,
      Stream.fromIterable([
        const AuthState(status: AuthStatus.unauthenticated),
        const AuthState(
          status: AuthStatus.unauthenticated,
          errorMessage: 'Error Login',
        ),
      ]),
      initialState: const AuthState.unauthenticated(),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Procesar estado

    expect(find.text('Error Login'), findsOneWidget);
  });

  testWidgets('add AuthLoginRequested event when login button'
      'is pressed with valid inputs', (tester) async {
    when(
      () => mockAuthBloc.state,
    ).thenReturn(const AuthState.unauthenticated());

    await tester.pumpWidget(createWidgetUnderTest());

    // Finder para el campo Email
    final emailInputFinder = find.ancestor(
      of: find.text('Correo electrónico'),
      matching: find.byType(AppInput),
    );
    final emailFieldFinder = find.descendant(
      of: emailInputFinder,
      matching: find.byType(TextFormField),
    );

    // Finder para el campo Password
    final passwordInputFinder = find.ancestor(
      of: find.text('Contraseña'),
      matching: find.byType(AppInput),
    );
    final passwordFieldFinder = find.descendant(
      of: passwordInputFinder,
      matching: find.byType(TextFormField),
    );

    // Escribir texto
    await tester.enterText(emailFieldFinder, 'test@test.com');
    await tester.enterText(passwordFieldFinder, 'password123');
    await tester.pump();

    // on Tap
    final buttonFinder = find.widgetWithText(AppButton, 'Iniciar Sesión');
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify event
    verify(
      () => mockAuthBloc.add(
        const AuthLoginRequested('test@test.com', 'password123'),
      ),
    ).called(1);
  });
}
