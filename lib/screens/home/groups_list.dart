import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';

class HomeGroupsList extends StatelessWidget {
  const HomeGroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(FetchGroups()),
      // onRefresh: () async {},
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.groups.keys.length,
            itemBuilder: (context, index) {
              final group = state.groups.keys.elementAt(index);
              final isSelected = state.groups[group]!;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CheckboxListTile(
                  title: Text(group.title!),
                  value: isSelected,
                  onChanged: (bool? value) {
                    if (value != null) {
                      context.read<HomeBloc>().add(SetGroupToRead(
                            groupId: group.groupId,
                            toRead: value,
                          ));
                    }
                  },
                  secondary: group.photo == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Container(
                            width: 45,
                            height: 45,
                            color: Theme.of(context).colorScheme.primary,
                            child: Center(
                              child: Text(
                                group.title![0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.memory(
                            base64Decode(group.photo!),
                            width: 45,
                            height: 45,
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
