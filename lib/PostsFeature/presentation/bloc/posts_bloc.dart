import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app_clean_aech/core/error/failure.dart';

import '../../domain/entity.dart';
import '../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPost getallPosts;

  PostsBloc({required this.getallPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostEvent) {
        //usecase
        emit(PostsLoading());
        final posts = await getallPosts.getallposta();
        posts.fold(
            (failure) =>
                {emit(Postserror(error: mapFailuretomassege(failure)))},
            (posts) => {emit(PostsLoaded(posts: posts))});
      } else if (event is RefreshPostEvent) {

        emit(PostsLoading());
        final posts = await getallPosts.getallposta();
        posts.fold(
                (failure) =>
            {emit(Postserror(error: mapFailuretomassege(failure)))},
                (posts) => {emit(PostsLoaded(posts: posts))});
      }
    });
  }

  String mapFailuretomassege(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ' ';
      case EmptyCacheFailure:
        return ' ';
      case offlineFailure:
        return ' ';
      default:
        return 'Un expected error';
    }
  }
}
