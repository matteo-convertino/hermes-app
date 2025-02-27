import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/login/login_state.dart';
import 'package:hermes_app/utils/custom_code_input.dart';
import 'package:pinput/pinput.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';

class TelegramCodeInput extends StatelessWidget {
  const TelegramCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Enter the '),
                  TextSpan(
                    text: 'Telegram code ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "that was sent to you"),
                ],
              ),
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) => customCodeInput(
              context: context,
              enabled: !state.isLoading,
              forceErrorState: state.telegramCodeError,
            ),
          ),
        ],
      ),
    );
  }
}
