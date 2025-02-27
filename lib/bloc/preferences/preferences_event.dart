import 'package:equatable/equatable.dart';

class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopics extends PreferencesEvent {}

class SetPreference extends PreferencesEvent {
  const SetPreference({required this.topicId, required this.isFavourite});

  final int topicId;
  final bool? isFavourite;

  @override
  List<Object?> get props => [topicId, isFavourite];
}
