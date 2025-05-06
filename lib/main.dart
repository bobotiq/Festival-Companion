import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/notifications_screen.dart';

void main() => runApp(FestivalCompanionApp());

class FestivalCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define theme colors
    final primaryColor = Color(0xFF4A90E2);
    final secondaryColor = Color(0xFF50E3C2);
    final surfaceColor = Color(0xFFF5F7FA);

    return MaterialApp(
      title: 'Festival Companion',
      theme: ThemeData(
        // Color scheme
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          surface: surfaceColor,
          onSurface: Colors.black87,
        ),
        scaffoldBackgroundColor: surfaceColor,
        fontFamily: 'Roboto',

        // AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: primaryColor),
        ),

        // Navigation bar theme
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: primaryColor.withAlpha(32),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w600),
          ),
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: primaryColor)),
        ),

        // Card theme
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
        ),

        // Text theme
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track the selected tab index

  // List of screens for navigation
  static final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    ScheduleScreen(),
    FriendsScreen(),
    NotificationsScreen(),
  ];

  // Handle navigation bar item tap
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Festival Companion')),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
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
