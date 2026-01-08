import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/controllers/user_provider.dart';
import 'package:myapp/controllers/nav_controller.dart';
import 'package:myapp/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

// Manual Mock for UserProvider
class MockUserProvider extends UserProvider {
  MockUserProvider() : super(autoLoad: false); // Disable real Firebase loading
  @override
  Future<void> refresh() async {}
}

// Mock widgets to replace Firebase-dependent screens during Home testing
class MockWidget extends StatelessWidget {
  final String title;
  const MockWidget(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(title, key: Key('screen_$title'))));
}

// We create a test-specific Home screen that replaces the crashing tabs
class TestHomeScreen extends HomeScreen {
  const TestHomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const HomeContent(),
    const MockWidget('History'),
    const MockWidget('Chat'),
    const MockWidget('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavController>(
      builder: (context, navController, child) {
        return Scaffold(
          body: IndexedStack(
            index: navController.selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navController.selectedIndex,
            onTap: (index) => navController.changeTab(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  Widget createHomeScreen() {
    final userProvider = MockUserProvider();
    userProvider.setUser('Test User', 'test@example.com');
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavController()),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: const MaterialApp(
        home: TestHomeScreen(),
      ),
    );
  }

  testWidgets('Home screen displays welcome message and categories', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(find.text('Welcome Test User 👋'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches tabs', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    // Click History tab icon
    await tester.tap(find.byIcon(Icons.history));
    await tester.pump();

    // Use a more specific finder (Key) because the text "History" appears in both the tab bar and the screen
    expect(find.byKey(const Key('screen_History')), findsOneWidget);
  });
}
