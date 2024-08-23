import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'blogpost.dart';
import 'blogdetailscreen.dart';

class BlogPostList extends StatefulWidget {
  @override
  _BlogPostListState createState() => _BlogPostListState();
}

class _BlogPostListState extends State<BlogPostList> {
  late Future<List<BlogPost>> futureBlogPosts;
  String selectedTag = 'All';

  @override
  void initState() {
    super.initState();
    futureBlogPosts = ApiService().fetchBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 255, 229),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 255, 229),
        title: Text('Blog Reader'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<BlogPost>>(
              future: futureBlogPosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts available'));
                } else {
                  // Tüm etiketleri al
                  List<String> allTags = snapshot.data!
                      .expand((post) => post.tags)
                      .toSet()
                      .toList();
                  allTags.insert(0, 'All'); // "All" seçeneğini ekle

                  return DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 0, 255, 229),
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(Icons.filter_list),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color:Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    value: selectedTag,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTag = newValue!;
                      });
                    },
                    items: allTags
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BlogPost>>(
              future: futureBlogPosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts available'));
                } else {
                  List<BlogPost> filteredPosts = snapshot.data!.where((post) {
                    return selectedTag == 'All' ||
                        post.tags.contains(selectedTag);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      BlogPost post = filteredPosts[index];
                      return ListTile(
                        leading: Image.network(
                          post.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                        title: Text(post.title),
                        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlogDetailScreen(post: post),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
