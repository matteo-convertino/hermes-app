import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  int id = 0;

  String hermesUrl;
  String? deviceId;

  bool darkTheme = false;

  Settings({
    required this.hermesUrl,
    this.deviceId,
  });

  @override
  toString() => '{'
      'id: $id, '
      'hermesUrl: "$hermesUrl", '
      'deviceId: "$deviceId"'
      '}';
}
