import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendedSitesApp extends StatelessWidget {
  final List<Map<String, dynamic>> recommendedSites = [
    {
      'name': 'Flutter Dev',
      'url': 'https://flutter.dev',
      'image': 'https://flutter.dev/images/flutter-logo-sharing.png',
      'description': 'Situs resmi untuk pengembangan Flutter',
    },
    {
      'name': 'Dart Lang',
      'url': 'https://dart.dev',
      'image': 'https://dart.dev/assets/shared/dart-logo-for-shares.png',
      'description': 'Dokumentasi bahasa pemrograman Dart',
    },
    {
      'name': 'Pub Dev',
      'url': 'https://pub.dev',
      'image': 'https://pub.dev/static/img/pub-dev-icon-cover-image.png',
      'description': 'Paket dan plugin untuk aplikasi Flutter',
    },
    {
      'name': 'GitHub',
      'url': 'https://github.com',
      'image': 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      'description': 'Platform hosting kode sumber dan kolaborasi',
    },
    {
      'name': 'Stack Overflow',
      'url': 'https://stackoverflow.com',
      'image': 'https://cdn.sstatic.net/Sites/stackoverflow/Img/apple-touch-icon.png',
      'description': 'Forum tanya jawab untuk programmer',
    },
  ];

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situs Rekomendasi'),
      ),
      body: ListView.builder(
        itemCount: recommendedSites.length,
        itemBuilder: (context, index) {
          final site = recommendedSites[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: () => _launchURL(site['url']),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            site['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(site['description']),
                          SizedBox(height: 8),
                          Text(
                            site['url'],
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}