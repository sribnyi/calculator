import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _kmController = TextEditingController();
  final _miController = TextEditingController();

  double? kmValue;
  double? miValue;

  @override
  void initState() {
    _kmController.text = "";
    _miController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _kmController.dispose();
    _miController.dispose();
    super.dispose();
  }

  void _convert(String? value, String type) {
    if (value == null || value.isEmpty) {
      setState(() {
        kmValue = null;
        miValue = null;
        _kmController.text = "";
        _miController.text = "";
      });
      return;
    }

    double? inputValue = double.parse(value);
    try {
      inputValue = double.parse(value);
    } catch (e) {
      inputValue = null;
    }

    if (type == 'km') {
      if (inputValue != null) {
        setState(() {
          kmValue = inputValue;
          miValue = (inputValue! / 1.60934);
          _miController.text = miValue?.toStringAsFixed(2) ??
              "0.0"; // Update miController.text here
        });
      }
    } else {
      if (inputValue != null) {
        setState(() {
          miValue = inputValue;
          kmValue = (inputValue! * 1.60934);
          _kmController.text = kmValue?.toStringAsFixed(2) ??
              "0.0"; // Update kmController.text here
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _kmController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?'))],
                decoration: const InputDecoration(
                  labelText: 'Kilometers',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _convert(value, 'km');
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _miController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?'))],
                decoration: const InputDecoration(
                  labelText: 'Miles',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _convert(value, 'mi');
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    kmValue = 0.0;
                    miValue = 0.0;
                    _kmController.clear();
                    _miController.clear();
                  });
                },
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
