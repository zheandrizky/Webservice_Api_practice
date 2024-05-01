import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bored App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoredPage(),
    );
  }
}

class BoredPage extends StatefulWidget {
  @override
  _BoredPageState createState() => _BoredPageState();
}

class _BoredPageState extends State<BoredPage> {
  String activity = 'Tap the button to get a recommendation';

  Future<void> _getActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity'));
    final Map<String, dynamic> responseData = json.decode(response.body);
    setState(() {
      activity = responseData['activity'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bored App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              activity,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getActivity,
              child: Text('Get Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
