import 'package:flutter/material.dart';

void main() => runApp(FestivalCompanionApp());

class FestivalCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Companion',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
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

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Festival Companion!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '• View the festival map\n'
              '• Check the event schedule\n'
              '• Find your friends\n'
              '• Get the latest notifications\n\n'
              'Enjoy your festival experience!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Map Screen
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // If you have an image, uncomment the next lines and add the image to assets.
      // child: Image.asset(
      //   'assets/festival_map.png',
      //   fit: BoxFit.contain,
      // ),
      child: Container(
        width: 300,
        height: 400,
        color: Colors.deepPurple[100],
        child: Center(
          child: Text(
            'Festival Map Coming Soon',
            style: TextStyle(fontSize: 20, color: Colors.deepPurple[800]),
          ),
        ),
      ),
    );
  }
}

// Schedule Screen
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

// Friends Screen
class FriendsScreen extends StatelessWidget {
  final List<String> friends = ["Alex", "Samira", "Jasper", "Lotte", "Chen"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(friends[index]),
          subtitle: Text("At the festival"),
        );
      },
    );
  }
}

// Notifications Screen
class NotificationsScreen extends StatelessWidget {
  final List<String> notifications = [
    "Welcome to the festival!",
    "Main Stage performance starts at 18:00.",
    "Don't miss the food tasting at 16:30.",
    "Lost & Found is near the entrance.",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.notifications),
          title: Text(notifications[index]),
        );
      },
    );
  }
}
