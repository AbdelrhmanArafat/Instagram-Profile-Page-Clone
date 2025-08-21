import 'dart:convert';
import 'package:http/http.dart' as http;

class APIServices {
  Future<List> fetchUserData(String endpoint, String username) async {
    final uri =
        'https://social-api4.p.rapidapi.com/v1/$endpoint?username_or_id_or_url=$username';
    final url = Uri.parse(uri);
    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': 'fcd55a4e4fmsha2d74612202ddeep1cb663jsna638d4e95354',
        'x-rapidapi-host': 'social-api4.p.rapidapi.com',
      },
    );

    final json = jsonDecode(response.body) as Map;
    return json['data']['items'] as List;
  }
}
