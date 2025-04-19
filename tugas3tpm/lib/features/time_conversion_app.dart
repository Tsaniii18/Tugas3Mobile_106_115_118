import 'package:flutter/material.dart';

class TimeConversionApp extends StatefulWidget {
  @override
  _TimeConversionAppState createState() => _TimeConversionAppState();
}

class _TimeConversionAppState extends State<TimeConversionApp> {
  final _formKey = GlobalKey<FormState>();
  final _yearsController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _yearsController.dispose();
    super.dispose();
  }

  void _convertTime() {
    if (!_formKey.currentState!.validate()) return;

    final years = double.tryParse(_yearsController.text.trim());
    if (years == null) return;

    final days = years * 365.25;
    final hours = days * 24;
    final minutes = hours * 60;
    final seconds = minutes * 60;

    setState(() {
      _result = '''
${years.toStringAsFixed(2)} tahun sama dengan:
- ${days.toStringAsFixed(2)} hari
- ${hours.toStringAsFixed(2)} jam
- ${minutes.toStringAsFixed(2)} menit
- ${seconds.toStringAsFixed(2)} detik
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50], // Background coklat muda
      appBar: AppBar(
        title: Text('Konversi Waktu'),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan jumlah tahun:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _yearsController,
                decoration: InputDecoration(
                  hintText: 'Contoh: 2.5',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan jumlah tahun';
                  }
                  final num = double.tryParse(value);
                  if (num == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _convertTime,
                  icon: Icon(Icons.access_time),
                  label: Text('Konversi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              if (_result.isNotEmpty)
                Card(
                  color: Colors.brown[100],
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _result,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[900],
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
