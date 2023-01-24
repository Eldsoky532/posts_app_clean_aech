import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/add_posts.dart';
import '../../../domain/usecases/delet_post.dart';
import '../../../domain/usecases/update_posts.dart';

part 'feature_app_event.dart';
part 'feature_app_state.dart';

class FeatureAppBloc extends Bloc<FeatureAppEvent, FeatureAppState> {
  final CreatePost addpost;

  final UpDatePost updatepost;
  final DeletePost deletePost;




  FeatureAppBloc(
  {
    required this.addpost,
    required this.updatepost,
    required this.deletePost
}
      ) : super(FeatureAppInitial()) {
    on<FeatureAppEvent>((event, emit) async{

      if(event is AddPostEvent)
        {

          emit(FeatureApploading());
          final failureorDone=await addpost.addpost(event.post) ;

          failureorDone.fold((l) => {
            emit(FeatureApperror(message: mapFailuretomassege(l)))
          }, (r) => {
            emit(MessageFeatureAppstate(message: "Add Sucess Message "))
          });

        }
      else if(event is UpdatePostEvent)
        {
          emit(FeatureApploading());
          final failureorDone=await updatepost.updatepose(event.post) ;

          failureorDone.fold((l) => {
            emit(FeatureApperror(message: mapFailuretomassege(l)))
          }, (r) => {
          emit(MessageFeatureAppstate(message: "Update Sucess Message "))
          });

        }else if(event is DeletePostEvent)
          {

            emit(FeatureApploading());
            final failureorDone=await deletePost.deletepost(event.postid) ;

            failureorDone.fold((l) => {
              emit(FeatureApperror(message: mapFailuretomassege(l)))
            }, (r) => {
            emit(MessageFeatureAppstate(message: "Delete Sucess Message "))
            });
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
