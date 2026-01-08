import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:myapp/controllers/user_provider.dart';
import 'package:myapp/controllers/nav_controller.dart';
import 'package:myapp/controllers/theme_controller.dart';
import 'package:myapp/core/auth_service.dart';
import 'package:provider/provider.dart';

// Manual Mock for AuthService
class MockAuthService extends AuthService {
  @override
  Future<User?> login({required String email, required String password}) async => null;
}

// Manual Mock for UserProvider
class MockUserProvider extends UserProvider {
  MockUserProvider() : super(autoLoad: false); // Disable real Firebase loading
  @override
  Future<void> refresh() async {}
}

void main() {
  Widget createLoginScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavController()),
        ChangeNotifierProvider<UserProvider>(create: (_) => MockUserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: MaterialApp(
        home: LoginScreen(authService: MockAuthService()),
      ),
    );
  }

  testWidgets('Login screen has email, password fields and login button', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('Showing error when login is clicked with empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter both email and password'), findsOneWidget);
  });

  testWidgets('Navigation to Signup screen works', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    // Need to find the TextButton for "Create new account"
    await tester.tap(find.text('Create new account'));
    await tester.pumpAndSettle();

    expect(find.byType(SignupScreen), findsOneWidget);
  });
}
