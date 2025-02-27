import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/device_request_dto.g.dart';

@JsonSerializable()
class DeviceRequestDto {
  const DeviceRequestDto({
    required this.firebaseToken,
  });

  factory DeviceRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceRequestDtoFromJson(json);

  final String firebaseToken;

  Map<String, dynamic> toJson() => _$DeviceRequestDtoToJson(this);
}
