import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/main.dart' as app;
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:myapp/screens/splash_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End App Flow', () {
    testWidgets('Full navigation from Splash to Login to Signup', (tester) async {
      // 1. Launch the app
      // Note: In a real integration test, you would need Firebase initialized 
      // or use a separate entry point that mocks it.
      await tester.pumpWidget(const app.KhalsnyApp());

      // 2. Start at Splash
      expect(find.byType(SplashScreen), findsOneWidget);

      // 3. Wait for Splash transition (simulated time)
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 4. Arrive at Login
      expect(find.byType(LoginScreen), findsOneWidget);

      // 5. Navigate to Signup
      final createAccountBtn = find.text('Create new account');
      await tester.tap(createAccountBtn);
      
      // Wait for navigation animation
      await tester.pumpAndSettle();

      // 6. Verify Signup screen
      expect(find.byType(SignupScreen), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      
      // 7. Go back to Login
      await tester.pageBack();
      await tester.pumpAndSettle();
      
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
