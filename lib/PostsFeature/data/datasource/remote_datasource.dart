import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/model.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';
import 'package:posts_app_clean_aech/core/error/exception.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postid);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const Base_url = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {'title': postModel.title, 'body': postModel.body};
    final response =
        await client.post(Uri.parse(Base_url + "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postid) async {
    final response = await client
        .delete(Uri.parse(Base_url + "/posts/${postid.toString()}"), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final respone = await client.get(Uri.parse(Base_url + "/posts/"), headers: {
      'Content-Type': 'application/json',
    });
    if (respone.statusCode == 200) {
      final List decodedJson = json.decode(respone.body) as List;
      List<PostModel> postmodels =
          decodedJson.map<PostModel>((e) => PostModel.FromJson(e)).toList();
      return postmodels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
    final body = {'title': postModel.title, 'body': postModel.body};
    final postid=postModel.id.toString();
    final response =
        await client.patch(Uri.parse(Base_url + "/posts/$postid"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
