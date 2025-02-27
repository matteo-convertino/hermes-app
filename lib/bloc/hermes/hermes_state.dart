import 'package:equatable/equatable.dart';
import 'package:hermes_app/models/settings.dart';

import '../../models/user.dart';
import '../../routing/constants.dart';

class HermesState extends Equatable {
  final bool darkTheme;
  final String initialRoute;

  const HermesState({
    required this.darkTheme,
    required this.initialRoute,
  });

  HermesState.initial(
    Settings? settings,
    bool isLogged,
  ) : this(
          darkTheme: settings?.darkTheme ?? false,
          initialRoute: isLogged
              ? homeRoute
              : loginRoute,
        );

  HermesState copyWith({bool? darkTheme, bool? copyWithTap}) {
    return HermesState(
      darkTheme: darkTheme ?? this.darkTheme,
      initialRoute: initialRoute,
    );
  }

  @override
  List<Object> get props => [darkTheme];
}
