import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';

import '../../../core/error/failure.dart';
import '../entity.dart';

class UpDatePost
{
  final PostRepositery repositery;

  UpDatePost(this.repositery);

  Future<Either<Failure,Unit>> updatepose(Post post)
  {
    return repositery.updatepose(post);
  }


}