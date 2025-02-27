import 'package:equatable/equatable.dart';
import 'package:hermes_app/models/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsState extends Equatable {
  final bool copiedToClipboard;
  final PackageInfo packageInfo;
  final String url;
  final String deviceId;

  const SettingsState({
    required this.copiedToClipboard,
    required this.packageInfo,
    required this.url,
    required this.deviceId,
  });

  SettingsState.initial(Settings settings)
      : copiedToClipboard = false,
        packageInfo = PackageInfo(
          appName: "Unknown",
          packageName: "Unknown",
          version: "Unknown",
          buildNumber: "Unknown",
        ),
        url = settings.hermesUrl,
        deviceId = settings.deviceId!;

  SettingsState copyWith({
    bool? copiedToClipboard,
    PackageInfo? packageInfo,
  }) {
    return SettingsState(
      copiedToClipboard: copiedToClipboard ?? this.copiedToClipboard,
      packageInfo: packageInfo ?? this.packageInfo,
      url: url,
      deviceId: deviceId,
    );
  }

  @override
  List<Object> get props => [copiedToClipboard, packageInfo];
}
