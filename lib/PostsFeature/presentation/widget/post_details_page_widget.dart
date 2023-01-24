import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/screens/posts_add_update.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/widget/loading_wiget.dart';

import '../screens/posts_page.dart';
import 'delete_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;

  PostDetailsWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PostAddUpdateScreen(
                                isUpdatepost: true,
                                post: post,
                              )));
                },
                icon: Icon(Icons.edit),
                label: Text("Update"),
              ),
            ),
          ),
          Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed:()=> deleteDialog(context),
                icon: Icon(Icons.delete),
                label: Text("Delet"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<FeatureAppBloc, FeatureAppState>(
            listener: (context, state) {
              if (state is MessageFeatureAppstate) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostaPage()),
                    (route) => false);
              }
              if (state is FeatureApperror) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                ));
              }
            },
            builder: (context, state) {
              if (state is FeatureApploading) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeletDialogWidget(postId:post.id!);
            },
          );
        });
  }
}
