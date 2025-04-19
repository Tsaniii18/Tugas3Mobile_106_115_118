import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  String _display = '00:00:00.00';
  List<String> _laps = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 30), _updateTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    if (_isRunning && mounted) {
      setState(() {
        _display = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr:$secondsStr.$hundredsStr';
  }

  void _toggleStopwatch() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _isRunning = !_isRunning;
    });
  }

  void _resetStopwatch() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
        _isRunning = false;
      }
      _stopwatch.reset();
      _display = '00:00:00.00';
      _laps.clear();
    });
  }

  void _recordLap() {
    setState(() {
      _laps.insert(0, _display);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50], // Background coklat muda
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              color: Colors.brown[100], // Card lebih coklat
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    _display,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  label: _isRunning ? 'Stop' : 'Start',
                  color: _isRunning ? Colors.red : Colors.green,
                  onPressed: _toggleStopwatch,
                  icon: _isRunning ? Icons.pause : Icons.play_arrow,
                ),
                _buildControlButton(
                  label: 'Reset',
                  color: Colors.blue,
                  onPressed: _resetStopwatch,
                  icon: Icons.refresh,
                ),
                _buildControlButton(
                  label: 'Lap',
                  color: Colors.orange,
                  onPressed: _isRunning ? _recordLap : null,
                  icon: Icons.flag,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _laps.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada lap dicatat',
                        style: TextStyle(color: Colors.brown),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _laps.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown[200],
                            child: Text(
                              '${_laps.length - index}',
                              style: TextStyle(color: Colors.brown[900]),
                            ),
                          ),
                          title: Text(
                            _laps[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
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

  Widget _buildControlButton({
    required String label,
    required Color color,
    required VoidCallback? onPressed,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
