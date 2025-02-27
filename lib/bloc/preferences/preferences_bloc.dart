import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/dto/request/preferences_request_dto.dart';
import 'package:hermes_app/dto/response/preferences_response_dto.dart';
import 'package:hermes_app/dto/response/topic_response_dto.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import '../../repository/interface/user_repository.dart';
import '../../utils/call_api.dart';
import 'preferences_event.dart';
import 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final UserRepository userRepository;
  final SettingsRepository settingsRepository;
  final HermesRepositoryProvider hermesRepositoryProvider;

  PreferencesBloc({
    required this.userRepository,
    required this.settingsRepository,
    required this.hermesRepositoryProvider,
  }) : super(PreferencesState.initial()) {
    on<SetPreference>(_onSetPreference);
    on<FetchTopics>(_onFetchTopics);

    add(FetchTopics());
  }

  void _onSetPreference(SetPreference event, Emitter<PreferencesState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<PreferencesResponseDto>(
      api: event.isFavourite == null ? hermesRepositoryProvider.client.deletePreference : hermesRepositoryProvider.client.addPreference,
      data: event.isFavourite == null ? event.topicId : PreferencesRequestDto(topicId: event.topicId, isFavourite: event.isFavourite!),
      onComplete: (response) => add(FetchTopics()),
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
            "There was an error while setting your preference. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    emit(state.copyWith(isFetching: false));
  }

  Future<void> _onFetchTopics(FetchTopics event, Emitter<PreferencesState> emit) async {
    List<TopicResponseDto> topics = [];
    List<PreferencesResponseDto> preferences = [];

    emit(state.copyWith(isFetching: true));

    await callApi<List<TopicResponseDto>>(
      api: hermesRepositoryProvider.client.getAllTopics,
      onComplete: (response) =>topics = response,
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
            "There was an error while fetching topics. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    await callApi<List<PreferencesResponseDto>>(
      api: hermesRepositoryProvider.client.getAllPreferences,
      onComplete: (response) => preferences = response,
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
            "There was an error while fetching preferences. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    Map<TopicResponseDto, double> topicsToEmit = {};

    for (TopicResponseDto topic in topics) {
      final preferencesFiltered = preferences.where((e) => e.topicId == topic.id);
      topicsToEmit[topic] = preferencesFiltered.isEmpty ? 0 : preferencesFiltered.first.value;
    }

    emit(state.copyWith(topics: topicsToEmit, isFetching: false));
  }
}
