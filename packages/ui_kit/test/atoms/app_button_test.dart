import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('AppButton displays text and triggers callback', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(text: 'Click Me', onPressed: () => pressed = true),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);

    await tester.tap(find.byType(AppButton));
    expect(pressed, true);
  });

  testWidgets('AppButton shows loader when isLoading is true', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AppButton(text: 'Login', isLoading: true)),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    expect(find.text('Login'), findsNothing);
  });
}
