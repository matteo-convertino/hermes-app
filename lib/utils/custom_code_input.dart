import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';

Pinput customCodeInput({
  required BuildContext context,
  required bool enabled,
  required bool forceErrorState,
}) {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle:
        const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1)),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(15),
    ),
  );

  final errorPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Theme.of(context).colorScheme.error),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Theme.of(context).colorScheme.primary),
  );

  return Pinput(
    length: 5,
    enabled: enabled,
    onChanged: (code) =>
        context.read<LoginBloc>().add(TelegramCodeChanged(telegramCode: code)),
    onCompleted: (_) => context.read<LoginBloc>().add(TelegramCodeSubmit()),
    focusedPinTheme: focusedPinTheme,
    defaultPinTheme: defaultPinTheme,
    forceErrorState: forceErrorState,
    errorPinTheme: errorPinTheme,
  );
}
