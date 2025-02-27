import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hermes_app/bloc/preferences/preferences_bloc.dart';
import 'package:hermes_app/bloc/preferences/preferences_event.dart';
import 'package:hermes_app/bloc/preferences/preferences_state.dart';
import 'package:hermes_app/routing/constants.dart';
import 'package:hermes_app/routing/navigation_service.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../utils/show_snackbar.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Interests"),
      ),
      body: BlocConsumer<PreferencesBloc, PreferencesState>(
        listener: (context, state) {
          if (state.error != "") {
            showSnackBar(context: context, msg: state.error);
          }

          if (state.isFetching) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return LoaderOverlay(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "Pick your topic preferences to refine the AI evaluation based on your preferences.",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: FaIcon(
                                  FontAwesomeIcons.handPointer,
                                  color: Colors.green,
                                ),
                              ),
                              Text("One-click to mark as favourite"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: FaIcon(
                                  FontAwesomeIcons.handPointer,
                                  color: Colors.red,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Double-click to mark as ",
                                  children: [
                                    TextSpan(
                                      text: "NOT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: " favourite"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    //spacing: 4.0,
                    //runSpacing: 4.0,

                    children: state.topics.keys.map((topic) {
                      final value = state.topics[topic]!;

                      return Card(
                        color: value == 0
                            ? null
                            : (value > 0 ? Colors.green : Colors.red),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            context.read<PreferencesBloc>().add(SetPreference(
                                  topicId: topic.id,
                                  isFavourite: value == 0
                                      ? true
                                      : (value > 0 ? false : null),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text(
                              topic.name,
                              style: TextStyle(
                                fontSize: 11,
                                color: value == 0 ? null : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Navigator.canPop(context)
          ? null
          : FloatingActionButton(
              onPressed: () => NavigationService().replaceScreen(homeRoute),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
    );
  }
}
