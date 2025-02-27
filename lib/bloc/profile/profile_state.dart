import 'package:equatable/equatable.dart';
import 'package:hermes_app/models/user.dart';

class ProfileState extends Equatable {
  final User user;

  const ProfileState({
    required this.user,
  });

  const ProfileState.initial(this.user);

  ProfileState copyWith() => this;

  @override
  List<Object> get props => [];
}
