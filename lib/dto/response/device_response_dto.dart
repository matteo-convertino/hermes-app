import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/device_response_dto.g.dart';

@JsonSerializable()
class DeviceResponseDto extends ErrorDto {
  const DeviceResponseDto({
    required this.deviceId,
    required this.firebaseToken,
    required super.errors,
  });

  factory DeviceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseDtoFromJson(json);

  final String deviceId;
  final String firebaseToken;

  Map<String, dynamic> toJson() => _$DeviceResponseDtoToJson(this);
}
