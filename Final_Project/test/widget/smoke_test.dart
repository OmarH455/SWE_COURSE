import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/controllers/nav_controller.dart';
import 'package:myapp/controllers/user_provider.dart';
import 'package:myapp/controllers/theme_controller.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:provider/provider.dart';

/// A clean, testable version of the app that avoids Firebase dependencies.
class TestKhalsnyApp extends StatelessWidget {
  const TestKhalsnyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavController()),
        ChangeNotifierProvider(create: (_) => UserProvider(autoLoad: false)),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const SplashScreen(),
      ),
    );
  }
}

void main() {
  testWidgets('Advanced Smoke Test: Full Auth Flow & Validation', (WidgetTester tester) async {
    // 1. Launch the app and Verify Splash Screen
    await tester.pumpWidget(const TestKhalsnyApp());
    expect(find.text("Splash Screen"), findsOneWidget);

    // 2. Advance timer (2s) and transition to Login
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    // 3. Test Login: Empty Fields Validation
    final loginBtn = find.widgetWithText(ElevatedButton, 'Login');
    await tester.tap(loginBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please enter both email and password'), findsOneWidget);
    
    ScaffoldMessenger.of(tester.element(find.byType(LoginScreen))).clearSnackBars();
    await tester.pumpAndSettle();

    // 4. Test Login: Forgot Password Validation (Empty Email)
    final forgotPwdBtn = find.text('Forgot Password?');
    await tester.tap(forgotPwdBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please enter your email to reset password'), findsOneWidget);

    ScaffoldMessenger.of(tester.element(find.byType(LoginScreen))).clearSnackBars();
    await tester.pumpAndSettle();

    // 5. Navigate to Signup
    await tester.tap(find.text('Create new account'));
    await tester.pumpAndSettle();
    expect(find.byType(SignupScreen), findsOneWidget);

    // Find Signup fields
    final nameField = find.ancestor(of: find.text('Full Name'), matching: find.byType(TextField));
    final emailField = find.ancestor(of: find.text('Email'), matching: find.byType(TextField));
    final passwordField = find.ancestor(of: find.text('Password'), matching: find.byType(TextField));
    final signupBtn = find.widgetWithText(ElevatedButton, 'Sign Up');

    // 6. Test Signup: Empty Fields Validation
    await tester.tap(signupBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please fill in all fields'), findsOneWidget);

    ScaffoldMessenger.of(tester.element(find.byType(SignupScreen))).clearSnackBars();
    await tester.pumpAndSettle();

    // 7. Test Signup: Invalid Name (Numbers)
    await tester.enterText(nameField, 'User123');
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.tap(signupBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Name must contain only letters and spaces'), findsOneWidget);

    ScaffoldMessenger.of(tester.element(find.byType(SignupScreen))).clearSnackBars();
    await tester.pumpAndSettle();

    // 8. Test Signup: Password Length Constraint
    await tester.enterText(nameField, 'Valid Name');
    await tester.enterText(passwordField, '123'); // Too short
    await tester.tap(signupBtn);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    ScaffoldMessenger.of(tester.element(find.byType(SignupScreen))).clearSnackBars();
    await tester.pumpAndSettle();

    // 9. Navigate back to Login
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    
    // 10. Verify Login elements are still there
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
