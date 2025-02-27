import '../../main.dart' show objectBox;
import '../../models/user.dart';
import '../interface/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _userBox = objectBox.store.box<User>();

  @override
  void add(User user) {
    _userBox.put(user);
  }

  @override
  User? get() {
    final users = _userBox.getAll();

    return users.isNotEmpty ? users[0] : null;
  }

  @override
  bool isLogged() {
    User? user = get();
    return user != null;
  }

  @override
  void removeAll() {
    _userBox.removeAll();
  }

  @override
  void update(User user) {
    _userBox.put(user);
  }
}
