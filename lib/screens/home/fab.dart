import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hermes_app/bloc/hermes/hermes_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: context.watch<HermesBloc>().state.darkTheme
          ? null
          : Theme.of(context).primaryColor,
      animatedIcon: AnimatedIcons.menu_close,
      foregroundColor: Colors.white,
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.settings),
          label: "Settings",
          onTap: () => NavigationService().navigateTo(settingsRoute),
        ),
        SpeedDialChild(
          child: const Icon(Icons.person),
          label: "Profile",
          onTap: () => NavigationService().navigateTo(profileRoute),
        ),
        SpeedDialChild(
          child: const Icon(Icons.apps),
          label: "Interests",
          onTap: () => NavigationService().navigateTo(preferencesRoute),
        ),
        SpeedDialChild(
          child: const Icon(Icons.logout),
          label: "Logout",
          onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Logout"),
              content: const Text(
                  "Are you sure that you want to logout from your Hermes account?"),
              actions: [
                TextButton(
                  child: const Text("No"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text("Yes"),
                  onPressed: () => context.read<HomeBloc>().add(Logout()),
                ),
              ],
            ),
          ),
        ),
      ],
      spaceBetweenChildren: 10,
      spacing: 10,
    );
  }
}
