import 'package:equatable/equatable.dart';
import 'package:hermes_app/dto/response/topic_response_dto.dart';

class PreferencesState extends Equatable {
  final Map<TopicResponseDto, double> topics;
  final String error;
  final bool isFetching;

  const PreferencesState({
    required this.topics,
    required this.error,
    required this.isFetching
  });

  PreferencesState.initial()
      : topics = {},
        error = "",
        isFetching = false;

  PreferencesState copyWith({
    Map<TopicResponseDto, double>? topics,
    String? error,
    bool? isFetching,
  }) {
    return PreferencesState(
      topics: topics ?? this.topics,
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [topics, error, isFetching];
}
