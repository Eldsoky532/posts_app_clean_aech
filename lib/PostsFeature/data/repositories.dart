import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';
import 'package:posts_app_clean_aech/core/error/exception.dart';
import 'package:posts_app_clean_aech/core/error/failure.dart';

import '../../core/network/network_info.dart';
import 'datasource/localdatasource.dart';
import 'datasource/remote_datasource.dart';
import 'model.dart';

class MainRepository extends PostRepositery {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource LocalDataSource;
  final NetworkInfo networkInfo;

  MainRepository({
    required this.remoteDataSource,
    required this.LocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addpost(Post post) async {
    final PostModel postmodel =
        PostModel(title: post.title, body: post.body);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addPost(postmodel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(offlineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletepost(int id) async{

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(id);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(offlineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getallposta() async {
    //apis
    if (await networkInfo.isConnected) {
      try {
        final remoteposts = await remoteDataSource.getAllPosts();

        LocalDataSource.cachePosts(remoteposts);
        return Right(remoteposts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localpost = await LocalDataSource.getCachedPosts();
        return Right(localpost);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatepose(Post post) async{
    final PostModel postmodel =
    PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updatePost(postmodel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      return Left(offlineFailure());
    }
  }
}
