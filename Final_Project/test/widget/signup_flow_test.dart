import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:myapp/controllers/user_provider.dart';
import 'package:myapp/controllers/nav_controller.dart';
import 'package:myapp/controllers/theme_controller.dart';
import 'package:myapp/core/auth_service.dart';
import 'package:provider/provider.dart';

// Create a mock class that doesn't use real Firebase
class MockAuthService extends AuthService {
  @override
  Future<User?> signup({required String email, required String password, required String name}) async {
    return null; // Mock does nothing
  }
  
  @override
  Future<User?> login({required String email, required String password}) async {
    return null;
  }
}

// A simple provider that doesn't use Firebase in its constructor
class MockUserProvider extends UserProvider {
  @override
  void setUser(String name, String email) {}
  
  // We override the refresh and _loadUserData logic to prevent Firebase calls
  @override
  Future<void> refresh() async {}
}

void main() {
  Widget createSignupScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavController()),
        // We avoid real UserProvider because it calls Firebase in constructor
        ChangeNotifierProvider<UserProvider>(create: (_) => MockUserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: MaterialApp(
        home: SignupScreen(authService: MockAuthService()),
      ),
    );
  }

  testWidgets('Signup screen has all input fields', (WidgetTester tester) async {
    await tester.pumpWidget(createSignupScreen());
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
  });

  testWidgets('Signup validation works for empty fields', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createSignupScreen());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Please fill in all fields'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Signup validation works for short password', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createSignupScreen());

    // 0: Full Name, 1: Email, 2: Password
    await tester.enterText(find.byType(TextField).at(0), 'Test User');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), '123');
    
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });
}
