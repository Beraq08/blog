import 'package:flutter/material.dart';
import 'blogpost.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogPost post;

  BlogDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 255, 229),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 255, 229),
        title: Text(post.title),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(post.image),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Text(
              post.excerpt,
              style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tags: ${post.tags.join(', ')}',
              style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            Text(
              'Date Published: ${post.datePublished}',
              style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            Text(
              post.body,
              style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            Icon(Icons.error),
            SizedBox(height: 16.0),
            Text('Failed to load image. Please try again later.'),
          ],
        );
      },
    );
  }
}
