import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/profile/profile_bloc.dart';
import 'package:hermes_app/bloc/profile/profile_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              state.user.photo == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        width: 90,
                        height: 90,
                        color: Theme.of(context).colorScheme.primary,
                        child: Center(
                          child: Text(
                            "${state.user.firstName[0].toUpperCase()}${state.user.lastName == null ? "" : state.user.lastName?[0].toUpperCase()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.memory(
                        base64Decode(state.user.photo!),
                        width: 90,
                        height: 90,
                      ),
                    ),
              Expanded(
                child: ListView(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        title: const Text("First name"),
                        trailing: SizedBox(
                          width: 200,
                          child: Text(
                            state.user.firstName,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Last name"),
                        trailing: SizedBox(
                          width: 200,
                          child: Text(
                            state.user.lastName == null
                                ? ""
                                : state.user.lastName!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Phone number"),
                        trailing: SizedBox(
                          width: 200,
                          child: Text(
                            state.user.phoneNumber,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Telegram user id"),
                        trailing: SizedBox(
                          width: 200,
                          child: Text(
                            state.user.userId.toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
