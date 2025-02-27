import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_bloc.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_event.dart';
import 'package:hermes_app/bloc/notification_details/notification_details_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../utils/my_loader_overlay.dart';
import '../utils/show_snackbar.dart';

class NotificationDetails extends StatelessWidget {
  const NotificationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return getMyLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Notification details"),
        ),
        body: BlocConsumer<NotificationDetailsBloc, NotificationDetailsState>(
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
            final notification =
                context.read<NotificationDetailsBloc>().notification;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        notification["group"],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(notification["text"]),
                      Row(
                        spacing: 10,
                        children: [
                          if (notification["is_high"] == "False")
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context
                                    .read<NotificationDetailsBloc>()
                                    .add(const SubmitFeedback(
                                        interesting: true)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Icon(Icons.thumb_up),
                                    Text("Interesting"),
                                  ],
                                ),
                              ),
                            ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context
                                  .read<NotificationDetailsBloc>()
                                  .add(
                                      const SubmitFeedback(interesting: false)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Icon(Icons.thumb_down),
                                  Text("I don't care"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // floatingActionButton: const HomeFab(),
      ),
    );
  }
}
