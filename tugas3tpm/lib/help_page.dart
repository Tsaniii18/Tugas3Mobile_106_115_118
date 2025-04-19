import 'package:flutter/material.dart';
import 'dart:io'; // Untuk exit(0) jika ingin keluar dari aplikasi
import 'utils/session_manager.dart';

class HelpPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade50, Colors.brown.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cara Penggunaan Aplikasi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Logout dan keluar dari aplikasi
                    await SessionManager.logout(); // Pastikan session logout berhasil
                    // Navigasi ke halaman login dan tutup semua halaman sebelumnya
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    exit(0); // Keluar dari aplikasi setelah logout
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpItem({required String title, required String description}) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.brown.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
