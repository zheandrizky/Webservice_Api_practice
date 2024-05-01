import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class University {
  final String name;
  final List<String> domains;
  final List<String> webPages;

  University({
    required this.name,
    required this.domains,
    required this.webPages,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      domains: List<String>.from(json['domains']),
      webPages: List<String>.from(json['web_pages']),
    );
  }
}

class UniversityList extends StatefulWidget {
  @override
  _UniversityListState createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  late Future<List<University>> futureUniversities;

  @override
  void initState() {
    super.initState();
    futureUniversities = fetchUniversities();
  }

  Future<List<University>> fetchUniversities() async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=Indonesia'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => University.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<University>>(
      future: futureUniversities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              University university = snapshot.data![index];
              return ListTile(
                title: Text(university.name),
                subtitle: Text(university.webPages.first),
                onTap: () {
                  // Handle onTap event
                },
              );
            },
          );
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('University List'),
        ),
        body: UniversityList(),
      ),
    );
  }
}
