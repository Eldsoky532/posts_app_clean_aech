import 'package:dartz/dartz.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';

import '../../../core/error/failure.dart';
import '../entity.dart';

class GetAllPost
{
  final PostRepositery repositery;

  GetAllPost(this.repositery);

  Future<Either<Failure,List<Post>>> getallposta()
  {
    return repositery.getallposta();
  }


}