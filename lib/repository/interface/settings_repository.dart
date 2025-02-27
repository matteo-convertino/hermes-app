import 'package:hermes_app/models/settings.dart';

abstract class SettingsRepository {
  Settings? get();
  void add(Settings _);
  void update(Settings _);
  void removeAll();
}
