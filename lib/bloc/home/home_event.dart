import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitFCM extends HomeEvent {}

class FetchGroups extends HomeEvent {}

class Logout extends HomeEvent {}

class SetGroupToRead extends HomeEvent {
  const SetGroupToRead({required this.groupId, required this.toRead});

  final int groupId;
  final bool toRead;

  @override
  List<Object> get props => [groupId, toRead];
}
