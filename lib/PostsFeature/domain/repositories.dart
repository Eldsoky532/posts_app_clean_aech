import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';

import '../../core/error/failure.dart';

abstract class PostRepositery {
  Future<Either<Failure,List<Post>>> getallposta();

  Future<Either<Failure,Unit>> addpost(Post post);

  Future<Either<Failure,Unit>> updatepose(Post post);

  Future<Either<Failure,Unit>> deletepost(int id);
}


