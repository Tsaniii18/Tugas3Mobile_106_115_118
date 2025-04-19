import 'package:flutter/material.dart';
import 'utils/constants.dart';

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
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
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: AppConstants.teamMembers.length,
          itemBuilder: (context, index) {
            final member = AppConstants.teamMembers[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.brown.shade100,
                  backgroundImage: NetworkImage(member['photo']),
                ),
                title: Text(
                  member['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                subtitle: Text(
                  'ID: ${member['id']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.brown.shade600,
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
