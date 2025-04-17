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
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleStopwatch,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.red : Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning ? _recordLap : null,
                  child: Text('Lap'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            if (_laps.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _laps.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('Lap ${_laps.length - index}'),
                      trailing: Text(_laps[index]),
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