class BlogPost {
  int id;
  String title;
  String body;
  String excerpt;
  List<String> tags;
  String image;
  String datePublished;

  BlogPost({
    required this.id,
    required this.title,
    required this.body,
    required this.excerpt,
    required this.tags,
    required this.image,
    required this.datePublished,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      excerpt: json['excerpt'],
      tags: List<String>.from(json['tags'].split(',').map((tag) => tag.trim())),
      image: json['image'],
      datePublished: json['date_published'],
    );
  }
}

