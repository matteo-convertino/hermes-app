import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/settings/settings_event.dart';
import 'package:hermes_app/bloc/settings/settings_state.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../repository/interface/user_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc({required this.settingsRepository})
      : super(SettingsState.initial(settingsRepository.get()!)) {
    on<InitPackageInfo>(_onInitPackageInfo);
    on<CopyToClipboard>(_onCopyToClipboard);

    add(InitPackageInfo());
  }

  void _onInitPackageInfo(
      InitPackageInfo event, Emitter<SettingsState> emit) async {
    final info = await PackageInfo.fromPlatform();
    emit(state.copyWith(packageInfo: info));
  }

  void _onCopyToClipboard(CopyToClipboard event, Emitter<SettingsState> emit) {
    Clipboard.setData(ClipboardData(text: event.text));
    emit(state.copyWith(copiedToClipboard: false));
    emit(state.copyWith(copiedToClipboard: true));
  }
}
