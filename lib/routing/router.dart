import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/home/home_bloc.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_bloc.dart';
import 'package:hermes_app/bloc/profile/profile_bloc.dart';
import 'package:hermes_app/bloc/settings/settings_bloc.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:hermes_app/screens/home/home.dart';
import 'package:hermes_app/screens/notification_details.dart';
import 'package:hermes_app/screens/preferences.dart';
import 'package:hermes_app/screens/profile.dart';
import 'package:hermes_app/screens/settings.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/preferences/preferences_bloc.dart';
import '../repository/interface/user_repository.dart';
import '../screens/login/login.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case loginRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: context.read<UserRepository>(),
              settingsRepository: context.read<SettingsRepository>(),
              hermesRepositoryProvider:
                  context.read<HermesRepositoryProvider>(),
            ),
            child: const Login(),
          ),
        );
      case preferencesRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<PreferencesBloc>(
            create: (context) => PreferencesBloc(
              userRepository: context.read<UserRepository>(),
              settingsRepository: context.read<SettingsRepository>(),
              hermesRepositoryProvider:
                  context.read<HermesRepositoryProvider>(),
            ),
            child: const Preferences(),
          ),
        );
      case homeRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              hermesRepositoryProvider:
                  context.read<HermesRepositoryProvider>(),
              userRepository: context.read<UserRepository>(),
              settingsRepository: context.read<SettingsRepository>(),
            ),
            child: const Home(),
          ),
        );
      case settingsRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              settingsRepository: context.read<SettingsRepository>(),
            ),
            child: const Settings(),
          ),
        );
      case notificationDetailsRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<NotificationDetailsBloc>(
            create: (context) => NotificationDetailsBloc(
              hermesRepositoryProvider:
                  context.read<HermesRepositoryProvider>(),
              notification: arguments!["notification"],
              isInteresting: arguments["interesting"],
            ),
            child: const NotificationDetails(),
          ),
        );
      case profileRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
            ),
            child: const Profile(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
