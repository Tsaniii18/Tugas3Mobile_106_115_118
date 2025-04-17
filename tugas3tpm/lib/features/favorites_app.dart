import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesApp extends StatefulWidget {
  @override
  _FavoritesAppState createState() => _FavoritesAppState();
}

class _FavoritesAppState extends State<FavoritesApp> {
  final _formKey = GlobalKey<FormState>();
  final _favoriteController = TextEditingController();
  List<String> _favorites = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _favorites = prefs.getStringList('favorites') ?? [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat favorit: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addFavorite() async {
    if (!_formKey.currentState!.validate()) return;

    final favorite = _favoriteController.text.trim();
    if (favorite.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      if (!_favorites.contains(favorite)) {
        _favorites.add(favorite);
        await prefs.setStringList('favorites', _favorites);
        _favoriteController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan favorit: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(int index) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      _favorites.removeAt(index);
      await prefs.setStringList('favorites', _favorites);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus favorit: ${e.toString()}')),
      );
      _loadFavorites(); // Reload to restore previous state
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _favoriteController,
                            decoration: InputDecoration(
                              labelText: 'Tambahkan favorit',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Silakan masukkan item favorit';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _addFavorite,
                          child: Text('Tambah'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_favorites.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'Belum ada item favorit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: _favorites.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(_favorites[index]),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeFavorite(index),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}