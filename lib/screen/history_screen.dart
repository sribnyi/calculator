import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history') ?? [];

    List<Map<String, dynamic>> formattedHistory = [];

    for (String item in history) {
      try {
        formattedHistory.add(jsonDecode(item) as Map<String, dynamic>);
      } catch (e) {
        print('Error decoding item: $item');
      }
    }

    setState(() {
      _history = formattedHistory;
      _history.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _history[index];
          return ListTile(
            title: Text('${item['input']} = ${item['output']}'),
            subtitle: Text(DateTime.parse(item['timestamp']).toString()),
          );
        },
      ),
    );
  }
}
