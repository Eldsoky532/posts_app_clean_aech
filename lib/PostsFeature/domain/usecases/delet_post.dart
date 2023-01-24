import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';

import '../../../core/error/failure.dart';
import '../entity.dart';

class DeletePost
{
  final PostRepositery repositery;

  DeletePost(this.repositery);

  Future<Either<Failure,Unit>> deletepost(int id)
  {
    return repositery.deletepost(id);
  }


}