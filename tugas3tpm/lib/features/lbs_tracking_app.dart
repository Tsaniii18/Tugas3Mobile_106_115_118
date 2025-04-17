import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LbsTrackingApp extends StatefulWidget {
  @override
  _LbsTrackingAppState createState() => _LbsTrackingAppState();
}

class _LbsTrackingAppState extends State<LbsTrackingApp> {
  Position? _currentPosition;
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Layanan lokasi tidak aktif. Silakan aktifkan.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Izin lokasi ditolak.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'Izin lokasi ditolak permanen. Ubah di pengaturan.';
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal mendapatkan lokasi: ${e.toString()}';
      });
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
        title: Text('Tracking LBS'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 60, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Lokasi Saat Ini',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                )
              else if (_currentPosition != null)
                Column(
                  children: [
                    Text(
                      'Latitude: ${_currentPosition!.latitude.toStringAsFixed(6)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Longitude: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Akurasi: ${_currentPosition!.accuracy.toStringAsFixed(2)} meter',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _getCurrentLocation,
                      child: Text('Refresh Lokasi'),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: Text('Dapatkan Lokasi'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}