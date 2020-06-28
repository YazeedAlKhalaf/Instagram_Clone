import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/widgets/smart_widgets/post/post_widget.dart';
import 'package:stacked/stacked.dart';

import './one_post_view_model.dart';

class OnePostView extends StatelessWidget {
  final Post post;
  final User author;

  const OnePostView({
    @required this.post,
    @required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnePostViewModel>.reactive(
      viewModelBuilder: () => OnePostViewModel(),
      builder: (
        BuildContext context,
        OnePostViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Post',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body: PostWidget(
            post: post,
            author: author,
          ),
        );
      },
    );
  }
}
