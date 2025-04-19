import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'members_page.dart';
import 'help_page.dart';
import 'features/stopwatch_app.dart';
import 'features/number_type_app.dart';
import 'features/lbs_tracking_app.dart';
import 'features/time_conversion_app.dart';
import 'features/recommended_sites_app.dart';
import 'utils/session_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _MainMenuPage(),
    MembersPage(),
    HelpPage(),
  ];

  Future<void> _logout() async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SessionManager.logout();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Feature App'),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.brown.shade100,
        selectedItemColor: Colors.brown.shade800,
        unselectedItemColor: Colors.brown.shade400,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}

class _MainMenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Stopwatch',
      'icon': Icons.timer,
      'color': Colors.blue,
      'page': StopwatchApp(),
    },
    {
      'title': 'Jenis Bilangan',
      'icon': Icons.numbers,
      'color': Colors.green,
      'page': NumberTypeApp(),
    },
    {
      'title': 'Tracking LBS',
      'icon': Icons.location_on,
      'color': Colors.orange,
      'page': LbsTrackingApp(),
    },
    {
      'title': 'Konversi Waktu',
      'icon': Icons.access_time,
      'color': Colors.purple,
      'page': TimeConversionApp(),
    },
    {
      'title': 'Situs Rekomendasi',
      'icon': Icons.link,
      'color': Colors.red,
      'page': RecommendedSitesApp(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown.shade100, Colors.brown.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['page']),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: item['color'].withOpacity(0.2),
                      child: Icon(item['icon'], size: 40, color: item['color']),
                      radius: 30,
                    ),
                    SizedBox(height: 12),
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
