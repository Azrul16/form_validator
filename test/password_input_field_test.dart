import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator_kit/form_validator_kit.dart';

void main() {
  testWidgets('toggles password visibility from the suffix icon', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'Password1!');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PasswordInputField(
            controller: controller,
            showValidationHints: false,
          ),
        ),
      ),
    );

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isTrue,
    );

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pumpAndSettle();

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).obscureText,
      isFalse,
    );
  });

  testWidgets('shows strength feedback and updates requirement hints', (
    tester,
  ) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PasswordInputField(
            controller: controller,
            minLength: 8,
            requireUppercase: true,
            requireLowercase: true,
            requireNumber: true,
            requireSpecialChar: true,
          ),
        ),
      ),
    );

    expect(find.text('Start typing to see password strength'), findsOneWidget);
    expect(find.text('One special character'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Password1!');
    await tester.pumpAndSettle();

    expect(find.text('Strong'), findsOneWidget);
  });

  testWidgets('validates confirm password matching', (tester) async {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController(text: 'Password1!');
    final confirmController = TextEditingController(text: 'Password2!');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: PasswordInputField(
              controller: confirmController,
              matchController: passwordController,
              validateAgainstPolicy: false,
              showStrengthIndicator: false,
              validator: FormValidator.required(),
            ),
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match.'), findsOneWidget);
    expect(find.text('Matches original password'), findsOneWidget);
  });
}
