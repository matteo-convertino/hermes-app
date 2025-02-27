import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/home/home_bloc.dart';
import 'package:hermes_app/bloc/home/home_state.dart';
import 'package:hermes_app/screens/home/empty_data.dart';
import 'package:hermes_app/screens/home/fab.dart';
import 'package:hermes_app/screens/home/groups_list.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../utils/show_snackbar.dart';
import '../../utils/my_loader_overlay.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return getMyLoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: const Text(
            "Hermes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
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
            return state.groups.isEmpty
                ? const HomeEmptyData()
                : const HomeGroupsList();
          },
        ),
        floatingActionButton: const HomeFab(),
      ),
    );
  }
}
