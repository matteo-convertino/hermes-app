import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/dto/request/device_request_dto.dart';
import 'package:hermes_app/dto/request/init_login_request_dto.dart';
import 'package:hermes_app/dto/request/verify_code_request_dto.dart';
import 'package:hermes_app/dto/response/device_response_dto.dart';
import 'package:hermes_app/dto/response/init_login_response_dto.dart';
import 'package:hermes_app/dto/response/verify_code_response_dto.dart';
import 'package:hermes_app/models/settings.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:hermes_app/routing/constants.dart';
import 'package:hermes_app/utils/get_my_dio.dart';

import '../../models/user.dart';
import '../../repository/interface/user_repository.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';
import '../../utils/hermes_repository_provider.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final SettingsRepository settingsRepository;
  final HermesRepositoryProvider hermesRepositoryProvider;

  final NavigationService _navigationService = NavigationService();

  LoginBloc({
    required this.userRepository,
    required this.settingsRepository,
    required this.hermesRepositoryProvider,
  }) : super(const LoginState.initial()) {
    on<UrlSubmit>(_onUrlSubmit);
    on<PhoneNumberSubmit>(_onPhoneNumberSubmit);
    on<TelegramCodeSubmit>(_onTelegramCodeSubmit);
    on<TelegramPasswordSubmit>(_onTelegramPasswordSubmit);
    on<UrlChanged>(_onUrlChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<TelegramCodeChanged>(_onTelegramCodeChanged);
    on<TelegramPasswordChanged>(_onTelegramPasswordChanged);
    on<StepChanged>(_onStepChanged);
  }

  void _onUrlSubmit(UrlSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    String url = state.url.trim();

    hermesRepositoryProvider.client.baseUrl =
        url.endsWith("/") ? url.substring(0, url.length - 1) : url;

    await callApi<void>(
      api: hermesRepositoryProvider.client.ping,
      onComplete: (response) {
        settingsRepository.removeAll();
        userRepository.removeAll();

        settingsRepository
            .add(Settings(hermesUrl: hermesRepositoryProvider.client.baseUrl!));

        emit(state.copyWith(
          loginStep: state.loginStep + 1,
          activeStep: state.activeStep + 1,
        ));
      },
      onFailed: (errors, _) {
        emit(state.copyWith(error: "Please enter a valid Hermes server URL"));
        emit(state.copyWith(error: ""));
      },
      onError: () {
        emit(state.copyWith(error: "Please enter a valid Hermes server URL"));
        emit(state.copyWith(error: ""));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onPhoneNumberSubmit(
      PhoneNumberSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<InitLoginResponseDto>(
      api: hermesRepositoryProvider.client.initLogin,
      data: InitLoginRequestDto(phoneNumber: state.phoneNumber),
      onComplete: (response) {
        Settings settings = settingsRepository.get()!;
        settings.deviceId = response.deviceId;
        settingsRepository.update(settings);

        emit(state.copyWith(loginStep: state.loginStep + 1, progress: 0.5));
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
                "There was an error while logging in. Try again in a while."));
        emit(state.copyWith(error: ""));
      },
    );

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _loginVerifyCode(
      Emitter<LoginState> emit, bool withPassword) async {
    Settings settings = settingsRepository.get()!;

    await callApi<VerifyCodeResponseDto>(
      api: hermesRepositoryProvider.client.verifyCode,
      data: VerifyCodeRequestDto(
        deviceId: settings.deviceId!,
        phoneNumber: state.phoneNumber,
        code: state.telegramCode,
        password: withPassword ? state.telegramPassword : null,
      ),
      onComplete: (response) async {
        userRepository.add(User(
          userId: response.id,
          firstName: response.firstName,
          lastName: response.lastName,
          phoneNumber: response.phoneNumber,
          photo: response.photo,
          jwt: response.jwt,
        ));

        hermesRepositoryProvider.dio = getMyDio(token: response.jwt);

        emit(state.copyWith(
          loginStep: state.loginStep + 1,
          activeStep: state.activeStep + 1,
          progress: 0,
        ));

        await callApi<DeviceResponseDto>(
          api: hermesRepositoryProvider.client.updateFirebaseToken,
          data: DeviceRequestDto(firebaseToken: (await FirebaseMessaging.instance.getToken())!),
          onComplete: (_) => _navigationService.resetToScreen(preferencesRoute),
          onFailed: (errors, _) {
            for (String error in errors) {
              emit(state.copyWith(error: error));
            }
            emit(state.copyWith(error: ""));
          },
          onError: () {
            emit(state.copyWith(error: "There was an error with Firebase Messaging. Try to login from scratch again."));
            emit(state.copyWith(error: ""));
          },
        );
      },
      onFailed: (errors, statusCode) {
        if (statusCode == 499) {
          emit(state.copyWith(
            loginStep: state.loginStep + 1,
            progress: 0.75,
            telegramPasswordHint: errors[0],
          ));
        } else {
          emit(state.copyWith(telegramCodeError: true));

          for (String error in errors) {
            emit(state.copyWith(error: error));
          }

          emit(state.copyWith(error: ""));
        }
      },
      onError: () {
        emit(state.copyWith(
          error: "There was an error while logging in. Try again in a while.",
          telegramCodeError: true,
        ));
        emit(state.copyWith(error: ""));
      },
    );
  }

  void _onTelegramCodeSubmit(
      TelegramCodeSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    await _loginVerifyCode(emit, false);

    emit(state.copyWith(isLoading: false));
  }

  void _onTelegramPasswordSubmit(
      TelegramPasswordSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    await _loginVerifyCode(emit, true);

    emit(state.copyWith(isLoading: false));
  }

  void _onUrlChanged(UrlChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(url: event.url));
  }

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onTelegramCodeChanged(
      TelegramCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        telegramCode: event.telegramCode, telegramCodeError: false));
  }

  void _onTelegramPasswordChanged(
      TelegramPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(telegramPassword: event.telegramPassword));
  }

  void _onStepChanged(StepChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        activeStep: event.step, loginStep: event.step, progress: 0));
  }
}
