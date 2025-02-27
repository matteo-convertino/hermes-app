import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/profile/profile_event.dart';
import 'package:hermes_app/bloc/profile/profile_state.dart';

import '../../repository/interface/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository})
      : super(ProfileState.initial(userRepository.get()!));
}
