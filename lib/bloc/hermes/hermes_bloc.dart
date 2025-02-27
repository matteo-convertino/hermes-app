import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/hermes/hermes_event.dart';
import 'package:hermes_app/bloc/hermes/hermes_state.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';

import '../../repository/interface/user_repository.dart';

class HermesBloc extends Bloc<HermesEvent, HermesState> {
  final UserRepository userRepository;
  final SettingsRepository settingsRepository;

  HermesBloc({required this.userRepository, required this.settingsRepository})
      : super(HermesState.initial(
          settingsRepository.get(),
          userRepository.isLogged(),
        )) {
    on<DarkThemeToggled>(_onDarkThemeToggled);
  }

  void _onDarkThemeToggled(
      DarkThemeToggled event, Emitter<HermesState> emit) {
    final settings = settingsRepository.get();
    settings?.darkTheme = !settings.darkTheme;
    settingsRepository.update(settings!);
    emit(state.copyWith(darkTheme: settings.darkTheme));
  }
}
