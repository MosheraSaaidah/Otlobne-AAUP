import 'package:flutter/material.dart';
import 'package:final_project/models/post.dart';
import 'package:final_project/controllers/post_controller.dart';

class PostFormPage extends StatefulWidget {
  final Post? post;
  const PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final PostController _controller = PostController();

  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final post = Post(
      id: widget.post?.id ?? 0,
      userId: 1,
      title: _titleController.text,
      body: _bodyController.text,
    );

    if (widget.post == null) {
      await _controller.createPost(post);
    } else {
      await _controller.updatePost(post);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.post != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Post" : "Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) => v!.isEmpty ? "Please enter a title" : null,
              ),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: "Body"),
                maxLines: 4,
                validator: (v) => v!.isEmpty ? "Please enter body text" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text(isEdit ? "Update" : "Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
