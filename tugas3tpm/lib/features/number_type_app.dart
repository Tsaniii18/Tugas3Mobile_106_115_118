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

    // Check if it's an integer
    if (number == number.toInt()) {
      types.add('Bilangan Bulat');
      
      if (number > 0) {
        types.add('Bilangan Bulat Positif');
      } else if (number < 0) {
        types.add('Bilangan Bulat Negatif');
      } else {
        types.add('Nol');
      }

      // Check for prime
      if (number > 1 && _isPrime(number.toInt())) {
        types.add('Bilangan Prima');
      }
    } else {
      types.add('Bilangan Desimal');
    }

    // Check for natural number
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
      appBar: AppBar(
        title: Text('Jenis Bilangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Masukkan bilangan',
                  border: OutlineInputBorder(),
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
              ElevatedButton(
                onPressed: _checkNumber,
                child: Text('Periksa'),
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
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}