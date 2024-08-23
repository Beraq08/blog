import 'dart:convert';
import 'package:http/http.dart' as http;
import 'blogpost.dart';

class ApiService {
  final String apiUrl = 'https://blogsapi.p.rapidapi.com/';

  Future<List<BlogPost>> fetchBlogPosts() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      "x-rapidapi-key": "Your API Key",
      "x-rapidapi-host": "blogsapi.p.rapidapi.com"
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> data = jsonResponse['results']; // Access the results list
      return data.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }
}
