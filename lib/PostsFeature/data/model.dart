import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';

class PostModel extends Post
{
  PostModel({ int? id, required String title, required String body}):super(
    id: id,title: title,body: body
  );



  factory PostModel.FromJson(Map<String , dynamic> json)
  {
    return PostModel(
        id: json['id'],
        title: json['title'],
        body: json['body']
    );

  }


  Map<String,dynamic> tojson()
  {
    return {
      'id':id,
      'title':title,
      'body':body
  };
}


}