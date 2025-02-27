import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/hermes.dart';
import 'package:hermes_app/repository/impl/settings_repository_impl.dart';
import 'package:hermes_app/repository/impl/user_repository_impl.dart';
import 'package:hermes_app/repository/interface/settings_repository.dart';
import 'package:hermes_app/repository/interface/user_repository.dart';
import 'package:hermes_app/utils/firebase_notification_service.dart';
import 'package:hermes_app/utils/get_my_dio.dart';
import 'package:hermes_app/utils/hermes_repository_provider.dart';

import 'bloc/hermes/hermes_bloc.dart';
import 'firebase_options.dart';
import 'object_box/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initFirebaseFCM();

  objectBox = await ObjectBox.create();

  final userRepository = UserRepositoryImpl();
  final settingsRepository = SettingsRepositoryImpl();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        RepositoryProvider<SettingsRepository>(
          create: (_) => settingsRepository,
        ),
        RepositoryProvider<HermesRepositoryProvider>(
          create: (_) => HermesRepositoryProvider(getMyDio(
            baseUrl: settingsRepository.get()?.hermesUrl ?? '',
            token: userRepository.get()?.jwt,
          )),
        ),
      ],
      child: BlocProvider<HermesBloc>(
        create: (context) => HermesBloc(
          userRepository: context.read<UserRepository>(),
          settingsRepository: context.read<SettingsRepository>(),
        ),
        child: const Hermes(),
      ),
    ),
  );
}
