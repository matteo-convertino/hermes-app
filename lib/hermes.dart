import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/hermes/hermes_bloc.dart';
import 'package:hermes_app/bloc/hermes/hermes_state.dart';
import 'package:hermes_app/routing/navigation_service.dart';
import 'package:hermes_app/routing/router.dart';
import 'package:hermes_app/theme/theme.dart';
import 'package:hermes_app/theme/util.dart';

class Hermes extends StatelessWidget {
  const Hermes({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme(createTextTheme(context, "Roboto", "Roboto"));

    return BlocBuilder<HermesBloc, HermesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Hermes',
          theme: state.darkTheme ? theme.dark() : theme.light(),
          onGenerateRoute: Router.generateRoute,
          initialRoute: state.initialRoute,
          navigatorKey: NavigationService().navigatorKey,
        );
      },
    );
  }
}