import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}


class offlineFailure extends Failure{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ServerFailure extends Failure{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class EmptyCacheFailure extends Failure{

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

//failure => expection