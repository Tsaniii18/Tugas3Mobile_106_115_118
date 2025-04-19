import 'package:flutter/material.dart';

class NumberTypeApp extends StatefulWidget {
  @override
  _NumberTypeAppState createState() => _NumberTypeAppState();
}

class _NumberTypeAppState extends State<NumberTypeApp> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _checkNumber() {
    if (!_formKey.currentState!.validate()) return;
    final input = _numberController.text.trim();
    final number = double.tryParse(input);
    if (number == null) {
      setState(() {
        _result = 'Input bukan angka yang valid';
      });
      return;
    }
    List<String> types = [];
    if (number == number.toInt()) {
      types.add('Bilangan Bulat');
      if (number > 0) {
        types.add('Bilangan Bulat Positif');
      } else if (number < 0) {
        types.add('Bilangan Bulat Negatif');
      } else {
        types.add('Nol');
      }
      if (number > 1 && _isPrime(number.toInt())) {
        types.add('Bilangan Prima');
      }
    } else {
      types.add('Bilangan Desimal');
    }
    if (number >= 0 && number == number.toInt()) {
      types.add('Bilangan Cacah');
    }
    setState(() {
      _result = 'Jenis Bilangan:\n${types.join('\n')}';
    });
  }
  bool _isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50], // Background coklat muda
      appBar: AppBar(
        title: Text('Jenis Bilangan'),
        backgroundColor: Colors.brown, // AppBar coklat
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan Bilangan:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800], // Teks coklat
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: 'Contoh: 7 atau 3.14',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan bilangan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _checkNumber,
                  icon: Icon(Icons.search),
                  label: Text('Periksa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown, // Tombol coklat
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              if (_result.isNotEmpty)
                Card(
                  color: Colors.brown[100], // Card coklat muda
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _result,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown[800], // Teks hasil pencarian
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
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
