import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/login/login_state.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';

class TelegramPasswordInput extends StatelessWidget {
  const TelegramPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            onChanged: (value) =>
                context.read<LoginBloc>().add(TelegramPasswordChanged(telegramPassword: value)),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                    color:
                        Theme.of(context).colorScheme.secondary),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // labelStyle: const TextStyle(color: Colors.white),
              // hintStyle: const TextStyle(color: Colors.white),
              labelText: 'Telegram password',
              hintText: state.telegramPasswordHint,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: IconButton(
                splashRadius: 20,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (!state.isLoading) {
                    context.read<LoginBloc>().add(TelegramPasswordSubmit());
                  }
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        );
      },
    );
  }
}
