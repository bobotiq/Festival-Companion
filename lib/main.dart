import 'package:flutter/material.dart';

void main() => runApp(FestivalCompanionApp());

class FestivalCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Companion',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    MapScreen(),
    ScheduleScreen(),
    FriendsScreen(),
    NotificationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Festival Companion')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}

// Placeholder screens
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Festival!', style: TextStyle(fontSize: 24)),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Festival Map Coming Soon', style: TextStyle(fontSize: 20)),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> events = [
    {"time": "12:00", "title": "Opening Ceremony", "stage": "Main Stage"},
    {"time": "13:30", "title": "Rock Band", "stage": "Stage A"},
    {"time": "15:00", "title": "DJ Set", "stage": "Dance Tent"},
    {"time": "16:30", "title": "Food Tasting", "stage": "Food Court"},
    {"time": "18:00", "title": "Headliner", "stage": "Main Stage"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          leading: Icon(Icons.event),
          title: Text(event["title"] ?? ""),
          subtitle: Text('${event["time"]} - ${event["stage"]}'),
        );
      },
    );
  }
}

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Find Friends Coming Soon', style: TextStyle(fontSize: 20)),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Coming Soon', style: TextStyle(fontSize: 20)),
    );
  }
}
