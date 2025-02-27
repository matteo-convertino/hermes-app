import 'package:equatable/equatable.dart';
import 'package:hermes_app/dto/response/group_response_dto.dart';

class NotificationDetailsState extends Equatable {
  final String error;
  final bool isFetching;

  const NotificationDetailsState({
    required this.error,
    required this.isFetching,
  });

  const NotificationDetailsState.initial()
      : error = '',
        isFetching = false;

  NotificationDetailsState copyWith({
    Map<GroupResponseDto, bool>? groups,
    String? error,
    bool? isFetching,
  }) {
    return NotificationDetailsState(
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [error, isFetching];
}
