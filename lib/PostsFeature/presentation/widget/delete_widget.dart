import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';

class DeletDialogWidget extends StatelessWidget {

  final int postId;


   DeletDialogWidget ({required this.postId}) ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure ? "),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('No')
        ),
        TextButton(
            onPressed: (){
              BlocProvider.of<FeatureAppBloc>(context).add(DeletePostEvent(postid: postId));
            },
            child: Text('Yes')
        )
      ],
    );
  }
}
