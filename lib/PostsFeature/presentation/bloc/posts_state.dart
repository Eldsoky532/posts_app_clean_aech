part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable{
  List<Object> get props=>[];
}

class PostsInitial extends PostsState {}


class PostsLoading extends PostsState {}


class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});

  List<Object> get props=>[posts];

}

class Postserror extends PostsState {
  final String error;

  Postserror({required this.error});

  List<Object> get props=>[error];
}