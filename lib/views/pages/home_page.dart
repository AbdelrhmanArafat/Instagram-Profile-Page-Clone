import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/views/pages/user_page.dart';
import 'package:instagram_clone/views/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController usernameController = TextEditingController();
  Map info = {};
  bool isLoading = false;

  Future<void> getUsernameInfo(String username) async {
    setState(() {
      isLoading = true;
    });
    final uri =
        'https://social-api4.p.rapidapi.com/v1/info?username_or_id_or_url=$username';
    final url = Uri.parse(uri);

    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': 'fcd55a4e4fmsha2d74612202ddeep1cb663jsna638d4e95354',
        'x-rapidapi-host': 'social-api4.p.rapidapi.com',
      },
    );

    final json = jsonDecode(response.body) as Map;
    final result = json['data'] as Map;

    setState(() {
      info = result;
      isLoading = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('success')));
      navigateToUserPage(info);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('error')));
    }
  }

  void navigateToUserPage(Map info) {
    final route = MaterialPageRoute(builder: (context) => UserPage(info: info));
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200),
          Center(
            child: Icon(
              Ionicons.logo_instagram,
              size: 100,
              color: Colors.pinkAccent,
            ),
          ),
          SizedBox(height: 40),
          CustomText(text: 'Enter username'),
          SizedBox(height: 40),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: 'Enter your username',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              if (usernameController.text.isEmpty ||
                  usernameController.text == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a username'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                getUsernameInfo(usernameController.text);
              }
            },
            child: isLoading
                ? CupertinoActivityIndicator(color: Colors.black)
                : CustomText(
                    text: 'Enter',
                    fontSize: 16,
                    fontColor: Colors.black,
                  ),
          ),
        ],
      ),
    );
  }
}
