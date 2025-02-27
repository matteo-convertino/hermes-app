import 'package:equatable/equatable.dart';
import 'package:hermes_app/dto/response/group_response_dto.dart';

class HomeState extends Equatable {
  final Map<GroupResponseDto, bool> groups;
  final String error;
  final bool isFetching;

  const HomeState({
    required this.groups,
    required this.error,
    required this.isFetching,
  });

  HomeState.initial()
      : groups = {},
        error = '',
        isFetching = false;

  HomeState copyWith({
    Map<GroupResponseDto, bool>? groups,
    String? error,
    bool? isFetching,
  }) {
    return HomeState(
      groups: groups ?? this.groups,
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [groups, error, isFetching];
}
