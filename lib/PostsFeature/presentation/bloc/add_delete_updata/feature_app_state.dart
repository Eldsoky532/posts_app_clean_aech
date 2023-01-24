part of 'feature_app_bloc.dart';

@immutable
abstract class FeatureAppState {}

class FeatureAppInitial extends FeatureAppState {}



class FeatureApploading extends FeatureAppState {}

class FeatureApploaded extends FeatureAppState {}

class FeatureApperror extends FeatureAppState {
  final String message;
  FeatureApperror({required this.message});
}


class MessageFeatureAppstate extends FeatureAppState {
  final String message;

  MessageFeatureAppstate({required this.message});
}
