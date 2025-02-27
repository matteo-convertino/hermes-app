import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/init_login_response_dto.g.dart';

@JsonSerializable()
class InitLoginResponseDto extends ErrorDto {
  const InitLoginResponseDto({required this.deviceId, required super.errors});

  factory InitLoginResponseDto.fromJson(Map<String, dynamic> json) => _$InitLoginResponseDtoFromJson(json);

  final String deviceId;

  Map<String, dynamic> toJson() => _$InitLoginResponseDtoToJson(this);
}