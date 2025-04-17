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

    final days = years * 365.25; // Accounting for leap years
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
      appBar: AppBar(
        title: Text('Konversi Waktu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _yearsController,
                decoration: InputDecoration(
                  labelText: 'Masukkan jumlah tahun',
                  border: OutlineInputBorder(),
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
              ElevatedButton(
                onPressed: _convertTime,
                child: Text('Konversi'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 30),
              if (_result.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _result,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}