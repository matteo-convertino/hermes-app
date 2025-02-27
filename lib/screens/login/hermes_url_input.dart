import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';

class HermesUrlInput extends StatelessWidget {
  const HermesUrlInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: (value) =>
            context.read<LoginBloc>().add(UrlChanged(url: value)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary /*width: 1*/),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary /*width: 1*/),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelStyle: const TextStyle(color: Colors.white),
          // hintStyle: const TextStyle(color: Colors.white),
          labelText: 'Type the Hermes server URL',
          hintText: 'https://www.example.com',
          suffixIcon: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return IconButton(
                splashRadius: 20,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (!state.isLoading) {
                    context.read<LoginBloc>().add(UrlSubmit());
                  }
                },
                icon: const Icon(Icons.arrow_forward),
              );
            },
          ),
        ),
      ),
    );
  }
}
