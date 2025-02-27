import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/hermes/hermes_bloc.dart';
import 'package:hermes_app/bloc/hermes/hermes_event.dart';
import 'package:hermes_app/bloc/hermes/hermes_state.dart';

import '../bloc/settings/settings_bloc.dart';
import '../bloc/settings/settings_state.dart';
import '../utils/show_snackbar.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Center(
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: const Text("Hermes server"),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        state.url,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: state.url));
                      showSnackBar(context: context, msg: "URL copied");
                    },
                  ),
                  ListTile(
                    title: const Text("Device ID"),
                    trailing: SizedBox(
                      width: 200,
                      child: Text(
                        state.deviceId,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: state.deviceId));
                      showSnackBar(context: context, msg: "URL copied");
                    },
                  ),
                  BlocBuilder<HermesBloc, HermesState>(
                    builder: (context, state) {
                      return ListTile(
                        title: const Text("Dark theme"),
                        trailing: Checkbox(
                          //activeColor: Theme.of(context).primaryColor,
                          value: state.darkTheme,
                          onChanged: (value) => context
                              .read<HermesBloc>()
                              .add(DarkThemeToggled()),
                        ),
                        onTap: () => context
                            .read<HermesBloc>()
                            .add(DarkThemeToggled()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Version number"),
                    trailing: Text(
                      "${state.packageInfo.version}.${state.packageInfo.buildNumber}",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
