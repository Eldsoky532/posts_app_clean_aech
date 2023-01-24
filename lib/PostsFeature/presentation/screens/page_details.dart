import 'package:flutter/material.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';

import '../widget/post_details_page_widget.dart';


class PageDetailsPage extends StatelessWidget {

  final Post post;

   PageDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: buildBody(),
    );
  }
  Widget buildBody()
  {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
        child: PostDetailsWidget(post:post),
      ),
    );
  }
}
