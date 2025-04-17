import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'members_page.dart';
import 'help_page.dart';
import 'features/stopwatch_app.dart';
import 'features/number_type_app.dart';
import 'features/lbs_tracking_app.dart';
import 'features/time_conversion_app.dart';
import 'features/recommended_sites_app.dart';
import 'features/favorites_app.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Feature App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await SessionManager.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
    {
      'title': 'Favorit',
      'icon': Icons.favorite,
      'color': Colors.pink,
      'page': FavoritesApp(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['page']),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 40, color: item['color']),
                  SizedBox(height: 10),
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}