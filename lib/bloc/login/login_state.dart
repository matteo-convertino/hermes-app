import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String url;
  final String phoneNumber;
  final String telegramCode;
  final bool telegramCodeError;
  final String telegramPassword;
  final String telegramPasswordHint;

  final int loginStep;
  final int activeStep;
  final double progress;
  final String error;
  final bool isLoading;

  const LoginState({
    required this.url,
    required this.phoneNumber,
    required this.telegramCode,
    required this.telegramCodeError,
    required this.telegramPassword,
    required this.error,
    required this.loginStep,
    required this.activeStep,
    required this.progress,
    required this.isLoading,
    required this.telegramPasswordHint,
  });

  const LoginState.initial()
      : url = "",
        phoneNumber = "",
        telegramCode = "",
        telegramCodeError = false,
        telegramPassword = "",
        error = "",
        loginStep = 0,
        activeStep = 0,
        isLoading = false,
        progress = 0.0,
        telegramPasswordHint = "";

  LoginState copyWith({
    String? url,
    String? phoneNumber,
    String? telegramCode,
    bool? telegramCodeError,
    String? telegramPassword,
    String? error,
    int? loginStep,
    int? activeStep,
    double? progress,
    bool? isLoading,
    String? telegramPasswordHint,
  }) {
    return LoginState(
      url: url ?? this.url,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      telegramCode: telegramCode ?? this.telegramCode,
      telegramCodeError: telegramCodeError ?? this.telegramCodeError,
      telegramPassword: telegramPassword ?? this.telegramPassword,
      error: error ?? this.error,
      loginStep: loginStep ?? this.loginStep,
      activeStep: activeStep ?? this.activeStep,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      telegramPasswordHint: telegramPasswordHint ?? this.telegramPasswordHint,
    );
  }

  @override
  List<Object> get props => [
        url,
        phoneNumber,
        telegramCode,
        telegramCodeError,
        telegramPassword,
        error,
        loginStep,
        activeStep,
        progress,
        isLoading,
        telegramPasswordHint,
      ];
}
