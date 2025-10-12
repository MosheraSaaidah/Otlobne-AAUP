import 'package:flutter/material.dart';
import 'package:final_project/models/post.dart';
import 'package:final_project/models/comment.dart';
import 'package:final_project/controllers/post_controller.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = PostController();

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.body, style: const TextStyle(fontSize: 16)),
            const Divider(),
            const Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<Comment>>(
                future: controller.fetchComments(post.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, i) {
                      final c = comments[i];
                      return ListTile(
                        title: Text(c.name),
                        subtitle: Text(c.body),
                        trailing: Text(
                          c.email,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
