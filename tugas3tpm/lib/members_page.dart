import 'package:flutter/material.dart';
import 'utils/constants.dart';

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: AppConstants.teamMembers.length,
        itemBuilder: (context, index) {
          final member = AppConstants.teamMembers[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(member['photo']),
              ),
              title: Text(member['name']),
              subtitle: Text('ID: ${member['id']}'),
            ),
          );
        },
      ),
    );
  }
}