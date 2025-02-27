import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_event.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_state.dart';
import 'package:hermes_app/dto/request/feedback_request_dto.dart';
import 'package:hermes_app/routing/constants.dart';
import 'package:hermes_app/utils/call_api.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import '../../routing/navigation_service.dart';
import '../../utils/firebase_notification_service.dart'
    show flutterLocalNotificationsPlugin;

class NotificationDetailsBloc
    extends Bloc<NotificationDetailsEvent, NotificationDetailsState> {
  final HermesRepositoryProvider hermesRepositoryProvider;
  final Map<String, dynamic> notification;
  final bool? isInteresting;

  final NavigationService _navigationService = NavigationService();

  NotificationDetailsBloc({
    required this.hermesRepositoryProvider,
    required this.notification,
    this.isInteresting,
  }) : super(const NotificationDetailsState.initial()) {
    on<SubmitFeedback>(_onSubmitFeedback);

    if (isInteresting != null) add(SubmitFeedback(interesting: isInteresting!));
  }

  Future<void> _onSubmitFeedback(
      SubmitFeedback event, Emitter<NotificationDetailsState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi(
      api: hermesRepositoryProvider.client.addFeedback,
      data: FeedbackRequestDto(
        text: notification["text"],
        label: event.interesting ? 0 : 1,
      ),
      onComplete: (_) {
        emit(state.copyWith(error: "Feedback saved with success"));
        flutterLocalNotificationsPlugin.cancel(notification["id"]);
        _navigationService.resetToScreen(homeRoute);
      },
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
                "There was an error while saving feedback. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    emit(state.copyWith(isFetching: false));
  }
}
