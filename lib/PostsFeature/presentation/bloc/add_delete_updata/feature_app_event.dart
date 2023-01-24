part of 'feature_app_bloc.dart';

@immutable
abstract class FeatureAppEvent extends Equatable {

  FeatureAppEvent();
  @override
  List<Object> get props => [];
}


class AddPostEvent extends FeatureAppEvent {

  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];

}

class DeletePostEvent extends FeatureAppEvent {
  final int postid;

  DeletePostEvent({required this.postid});

  @override
  List<Object> get props => [postid];
}

class UpdatePostEvent extends FeatureAppEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}