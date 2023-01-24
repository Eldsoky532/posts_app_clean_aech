import 'package:flutter/material.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/screens/page_details.dart';

import '../../domain/entity.dart';

class PostListWidget extends StatelessWidget {

  final List<Post> posts;


  const PostListWidget({required this.posts}) ;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index){
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              posts[index].body,
              style: TextStyle(fontSize: 14),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PageDetailsPage(post:posts[index] )));
            },
          );
        },
        separatorBuilder:(context,index)=>Divider(thickness: 1,),
        itemCount: posts.length
    );
  }
}
