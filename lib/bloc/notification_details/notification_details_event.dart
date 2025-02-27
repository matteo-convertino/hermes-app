import 'package:equatable/equatable.dart';

class NotificationDetailsEvent extends Equatable {
  const NotificationDetailsEvent();

  @override
  List<Object> get props => [];
}

class SubmitFeedback extends NotificationDetailsEvent {
  const SubmitFeedback({required this.interesting});

  final bool interesting;

  @override
  List<Object> get props => [interesting];
}
