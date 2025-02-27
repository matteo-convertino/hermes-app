import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/home/home_event.dart';
import 'package:hermes_app/bloc/home/home_state.dart';
import 'package:hermes_app/dto/request/group_request_dto.dart';
import 'package:hermes_app/dto/response/group_response_dto.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:hermes_app/routing/constants.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import '../../repository/interface/user_repository.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HermesRepositoryProvider hermesRepositoryProvider;
  final UserRepository userRepository;
  final SettingsRepository settingsRepository;

  final NavigationService _navigationService = NavigationService();

  HomeBloc({
    required this.hermesRepositoryProvider,
    required this.userRepository,
    required this.settingsRepository,
  }) : super(HomeState.initial()) {
    on<FetchGroups>(_onFetchGroups);
    on<SetGroupToRead>(_onSetGroupToRead);
    on<Logout>(_onLogout);

    add(FetchGroups());
  }

  Future<void> _onFetchGroups(
      FetchGroups event, Emitter<HomeState> emit) async {
    List<GroupResponseDto> groups = [];
    List<GroupResponseDto> activeGroups = [];

    emit(state.copyWith(isFetching: true));

    await callApi<List<GroupResponseDto>>(
      api: hermesRepositoryProvider.client.getAllGroups,
      onComplete: (response) => groups = response,
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
                "There was an error while fetching groups. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    await callApi<List<GroupResponseDto>>(
      api: hermesRepositoryProvider.client.getAllActiveGroups,
      onComplete: (response) => activeGroups = response,
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
                "There was an error while fetching active groups. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    Map<GroupResponseDto, bool> groupsToEmit = {};

    for (GroupResponseDto group in groups) {
      groupsToEmit[group] =
          activeGroups.where((e) => e.groupId == group.groupId).isNotEmpty;
    }

    emit(state.copyWith(groups: groupsToEmit, isFetching: false));
  }

  Future<void> _onSetGroupToRead(
      SetGroupToRead event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<GroupResponseDto>(
      api: event.toRead
          ? hermesRepositoryProvider.client.addGroup
          : hermesRepositoryProvider.client.deleteGroup,
      data: GroupRequestDto(groupId: event.groupId),
      onComplete: (response) => add(FetchGroups()),
      onFailed: (errors, _) {
        for (String error in errors) {
          emit(state.copyWith(error: error));
        }
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(
            error:
                "There was an error while toggling group. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    emit(state.copyWith(isFetching: false));
  }

  void _onLogout(Logout event, Emitter<HomeState> emit) {
    userRepository.removeAll();
    settingsRepository.removeAll();
    _navigationService.resetToScreen(loginRoute);
  }
}
