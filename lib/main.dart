import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = "https://jsonplaceholder.typicode.com/posts";
  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     //theme: ThemeData.dark(),
      home: Scaffold(
        body: ListView.builder(
            itemCount: _postsJson.length = 50,
            itemBuilder: (context, i) {
              final post = _postsJson[i];
              return RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "     ${post["title"]}\n",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 3,
                            fontSize: 18,
                            color: Colors.purple[600])),
                    TextSpan(
                      text: "       ${post["body"]}",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.black),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
