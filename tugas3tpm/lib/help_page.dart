import 'package:flutter/material.dart';
import 'utils/session_manager.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cara Penggunaan Aplikasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildHelpItem(
              title: 'Stopwatch',
              description: 'Aplikasi untuk menghitung waktu dengan akurat.',
            ),
            _buildHelpItem(
              title: 'Jenis Bilangan',
              description: 'Menentukan jenis bilangan yang dimasukkan.',
            ),
            _buildHelpItem(
              title: 'Tracking LBS',
              description: 'Melacak lokasi menggunakan Location-Based Service.',
            ),
            _buildHelpItem(
              title: 'Konversi Waktu',
              description: 'Mengkonversi tahun ke jam, menit, dan detik.',
            ),
            _buildHelpItem(
              title: 'Situs Rekomendasi',
              description: 'Daftar situs web yang direkomendasikan.',
            ),
            _buildHelpItem(
              title: 'Favorit',
              description: 'Daftar item yang telah Anda tandai sebagai favorit.',
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SessionManager.logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4),
          Text(description),
          Divider(height: 16),
        ],
      ),
    );
  }
}