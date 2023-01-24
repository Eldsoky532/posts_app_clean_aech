import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';

import '../../../core/error/failure.dart';
import '../entity.dart';

class CreatePost
{
  final PostRepositery repositery;

  CreatePost(this.repositery);

  Future<Either<Failure,Unit>> addpost(Post post)
  {
    return repositery.addpost(post);
  }


}