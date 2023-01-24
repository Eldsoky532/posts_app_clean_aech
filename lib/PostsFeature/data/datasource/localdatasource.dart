import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/datasource/remote_datasource.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/model.dart';
import 'package:posts_app_clean_aech/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource
{
 Future<List<PostModel>> getCachedPosts();
 Future<Unit> cachePosts(List<PostModel> postmodel);

}

class PostLocalDataSourceImol implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;


  PostLocalDataSourceImol({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postmodel) {
   List postmodeljson=postmodel.map<Map<String , dynamic>>((e) => e.tojson()).toList();
   sharedPreferences.setString('CACHED_POSTS', json.encode(postmodeljson));
   return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
   final  jsonString=sharedPreferences.getString('CACHED_POSTS');
   if(jsonString!=null)
     {
       List decodedJsonData=json.decode(jsonString);
       List<PostModel> jsontopostmodels=decodedJsonData.map<PostModel>((e) => PostModel.FromJson(e)).toList();
       return Future.value(jsontopostmodels);
     }
   else{
     throw EmptyCacheException();
   }
  }

}


