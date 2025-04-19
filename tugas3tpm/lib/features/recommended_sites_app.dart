import 'package:flutter/material.dart';
import 'package:tugas3tpm/utils/session_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendedSitesApp extends StatefulWidget {
  const RecommendedSitesApp({super.key});

  @override
  _RecommendedSitesAppState createState() => _RecommendedSitesAppState();
}

class _RecommendedSitesAppState extends State<RecommendedSitesApp> {
  List<Map<String, dynamic>> recommendedSites = [
    {
      'name': 'Flutter Dev',
      'url': 'https://flutter.dev',
      'image': 'https://flutter.dev/images/flutter-logo-sharing.png',
      'description': 'Situs resmi untuk pengembangan Flutter',
      'isFavorite': false,
    },
    {
      'name': 'Dart Lang',
      'url': 'https://dart.dev',
      'image': 'https://dart.dev/assets/shared/dart-logo-for-shares.png',
      'description': 'Dokumentasi bahasa pemrograman Dart',
      'isFavorite': false,
    },
    {
      'name': 'Pub Dev',
      'url': 'https://pub.dev',
      'image': 'https://pub.dev/static/img/pub-dev-icon-cover-image.png',
      'description': 'Paket dan plugin untuk aplikasi Flutter',
      'isFavorite': false,
    },
    {
      'name': 'GitHub',
      'url': 'https://github.com',
      'image': 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      'description': 'Platform hosting kode sumber dan kolaborasi',
      'isFavorite': false,
    },
    {
      'name': 'Stack Overflow',
      'url': 'https://stackoverflow.com',
      'image': 'https://cdn.sstatic.net/Sites/stackoverflow/Img/apple-touch-icon.png',
      'description': 'Forum tanya jawab untuk programmer',
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> favorites = await SessionManager.getFavoriteSites();
    setState(() {
      for (var site in recommendedSites) {
        site['isFavorite'] = favorites.any((fav) => fav['url'] == site['url']);
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _toggleFavorite(int index) async {
    setState(() {
      recommendedSites[index]['isFavorite'] = !recommendedSites[index]['isFavorite'];
    });
    if (recommendedSites[index]['isFavorite']) {
      await SessionManager.addFavoriteSite(recommendedSites[index]);
    } else {
      await SessionManager.removeFavoriteSite(recommendedSites[index]);
    }
  }

  void _goToFavoritesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situs Rekomendasi'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: _goToFavoritesPage,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.brown, // Menggunakan warna coklat tua
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade200, Colors.brown.shade600], // Gradien coklat muda ke coklat tua
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: recommendedSites.length,
          itemBuilder: (context, index) {
            final site = recommendedSites[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Pembulatan sudut yang lebih modern
              ),
              elevation: 6,
              shadowColor: Colors.black.withOpacity(0.3),
              color: Colors.brown.shade50, // Card dengan warna coklat muda
              child: InkWell(
                onTap: () => _launchURL(site['url']),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          site['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Icon(Icons.link),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              site['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade800, // Warna coklat lebih gelap untuk teks
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              site['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.brown.shade700,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              site['url'],
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          site['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: site['isFavorite'] ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () => _toggleFavorite(index),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ===== Halaman Favorite List =====
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<Map<String, dynamic>> favoriteSites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    favoriteSites = await SessionManager.getFavoriteSites();
    setState(() {});
  }

  Future<void> _removeFavorite(Map<String, dynamic> site) async {
    await SessionManager.removeFavoriteSite(site);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit Saya'),
        backgroundColor: Colors.brown, // Menggunakan warna coklat tua di AppBar
      ),
      body: favoriteSites.isEmpty
          ? Center(child: Text('Belum ada website favorit', style: TextStyle(color: Colors.brown.shade700)))
          : ListView.builder(
              itemCount: favoriteSites.length,
              itemBuilder: (context, index) {
                final site = favoriteSites[index];
                return Dismissible(
                  key: Key(site['url']),
                  background: Container(color: Colors.red, padding: EdgeInsets.only(left: 20), alignment: Alignment.centerLeft, child: Icon(Icons.delete, color: Colors.white)),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    _removeFavorite(site);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(0.3),
                    color: Colors.brown.shade50,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          site['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                              child: Icon(Icons.link),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        site['name'],
                        style: TextStyle(color: Colors.brown.shade800),
                      ),
                      subtitle: Text(site['description']),
                      onTap: () async {
                        if (await canLaunch(site['url'])) {
                          await launch(site['url']);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
