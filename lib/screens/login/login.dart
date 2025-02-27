import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/preferences/preferences_bloc.dart';
import 'package:hermes_app/repository/interface/hermes_repository.dart';
import 'package:hermes_app/screens/login/logo.dart';
import 'package:hermes_app/screens/login/telegram_code_input.dart';
import 'package:hermes_app/screens/login/telegram_password_input.dart';
import 'package:hermes_app/screens/preferences.dart';
import 'package:hermes_app/utils/custom_login_step.dart';
import 'package:hermes_app/screens/login/hermes_url_input.dart';
import 'package:hermes_app/screens/login/phone_number_input.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../bloc/preferences/preferences_event.dart';
import '../../repository/interface/settings_repository.dart';
import '../../repository/interface/user_repository.dart';
import '../../utils/show_snackbar.dart';
import 'stepper.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.error != "") {
            showSnackBar(context: context, msg: state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              const LoginLogo(),

              customLoginStep(
                context: context,
                loginStep: 0,
                activeStep: state.loginStep,
                inputForm: const HermesUrlInput(),
              ),
              customLoginStep(
                context: context,
                loginStep: 1,
                activeStep: state.loginStep,
                inputForm: const PhoneNumberInput(),
              ),
              customLoginStep(
                context: context,
                loginStep: 2,
                activeStep: state.loginStep,
                inputForm: const TelegramCodeInput(),
              ),
              customLoginStep(
                context: context,
                loginStep: 3,
                activeStep: state.loginStep,
                inputForm: const TelegramPasswordInput(),
              ),
              const LoginStepper(),
            ],
          );
        },
      ),
    );
  }
}
