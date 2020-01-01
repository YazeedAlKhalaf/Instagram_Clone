import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/post_model.dart';
import 'package:flutter_instagram_clone/models/user_data.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/widgets/post_view.dart';
import 'package:provider/provider.dart';

class SingleImageScreen extends StatefulWidget {
  final Post post;
  final User author;

  SingleImageScreen({this.post, this.author});
  @override
  _SingleImageScreenState createState() => _SingleImageScreenState();
}

class _SingleImageScreenState extends State<SingleImageScreen> {
  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Post',
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      body: PostView(
        currentUserId: currentUserId,
        post: widget.post,
        author: widget.author,
      ),
    );
  }
}
