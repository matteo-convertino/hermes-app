import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../utils/empty_data.dart';

class HomeEmptyData extends StatelessWidget {
  const HomeEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(FetchGroups()),
      // onRefresh: () async {},
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: const EmptyData(
              imageName: "no_results",
              title: "No groups fetched from your Telegram",
              description: "",
            ),
          )),
    );
  }
}
