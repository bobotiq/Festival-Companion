import 'package:flutter/material.dart';

void main() => runApp(FestivalCompanionApp());

class FestivalCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festival Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 14, color: Colors.grey),
          bodyMedium: TextStyle(fontSize: 16),
        ),
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
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
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

// Home Screen with card and better typography
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.music_note, size: 80, color: Colors.deepPurple),
              SizedBox(height: 16),
              Text(
                'Welcome to the Festival Companion!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  color: Colors.deepPurple[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Enhance your festival experience with:\n\n'
                '• Interactive festival map\n'
                '• Up-to-date event schedule\n'
                '• Friend finder\n'
                '• Real-time notifications\n\n'
                'Enjoy your time!',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Map Screen with styled placeholder
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.deepPurple[50],
          ),
          child: Center(
            child: Text(
              'Festival Map Coming Soon',
              style: TextStyle(
                fontSize: 22,
                color: Colors.deepPurple[300],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Schedule Screen with cards and icons
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
      padding: EdgeInsets.symmetric(vertical: 12),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                event["time"]!.split(':')[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              event["title"] ?? "",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${event["time"]} - ${event["stage"]}'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.deepPurple,
            ),
            onTap: () {
              // Placeholder for event details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Details for "${event["title"]}" coming soon!'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Friends Screen with cards and avatars
class FriendsScreen extends StatelessWidget {
  final List<String> friends = ["Alex", "Samira", "Jasper", "Lotte", "Chen"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 12),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                friend[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(friend, style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text("At the festival"),
            trailing: Icon(Icons.location_on, color: Colors.deepPurple),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Location sharing for $friend coming soon!'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Notifications Screen with cards and icons
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
      padding: EdgeInsets.symmetric(vertical: 12),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.deepPurple),
            title: Text(notifications[index]),
          ),
        );
      },
    );
  }
}
