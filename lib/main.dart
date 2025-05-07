/// Main entry point for the Festival Companion app.
/// Sets up the app theme, navigation, and core screens.
library;

import 'package:flutter/material.dart';
// Screen imports for main navigation
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/notifications_screen.dart';

/// Entry point of the application
void main() => runApp(FestivalCompanionApp());

/// Root widget that configures the app-wide theme and appearance
class FestivalCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Companion',
      // Configure Material 3 theme with custom color scheme
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF6200EE), // Main brand color
          secondary: Color(0xFF03DAC6), // Accent color
          surface: Color(0xFFF8F9FA), // Card and surface backgrounds
          background: Color(0xFFFFFFFF), // Pure white background
          error: Color(0xFFB00020), // Standard error color
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Color(0xFF1F1F1F),
          onBackground: Color(0xFF1F1F1F),
          onError: Colors.white,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          bodyLarge: TextStyle(fontSize: 16, letterSpacing: 0.5, height: 1.5),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main navigation container that manages the bottom navigation bar and screen switching
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Track currently selected navigation item
  int _selectedIndex = 0;

  // List of main app screens corresponding to bottom navigation items
  static final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    ScheduleScreen(),
    FriendsScreen(),
    NotificationsScreen(),
  ];

  // Handle bottom navigation item selection
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to preserve screen state when switching tabs
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          // Navigation items with icons and labels
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_rounded), label: 'Map'),
          NavigationDestination(
            icon: Icon(Icons.event_rounded),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_rounded),
            label: 'Friends',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_rounded),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
