import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UrlSubmit extends LoginEvent {}
class PhoneNumberSubmit extends LoginEvent {}
class TelegramCodeSubmit extends LoginEvent {}
class TelegramPasswordSubmit extends LoginEvent {}

class UrlChanged extends LoginEvent {
  const UrlChanged({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}

class PhoneNumberChanged extends LoginEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class TelegramCodeChanged extends LoginEvent {
  const TelegramCodeChanged({required this.telegramCode});

  final String telegramCode;

  @override
  List<Object> get props => [telegramCode];
}

class TelegramPasswordChanged extends LoginEvent {
  const TelegramPasswordChanged({required this.telegramPassword});

  final String telegramPassword;

  @override
  List<Object> get props => [telegramPassword];
}

class StepChanged extends LoginEvent {
  const StepChanged({required this.step});

  final int step;

  @override
  List<Object> get props => [step];
}
