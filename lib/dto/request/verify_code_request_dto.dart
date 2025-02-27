import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/verify_code_request_dto.g.dart';

@JsonSerializable()
class VerifyCodeRequestDto {
  const VerifyCodeRequestDto({
    required this.deviceId,
    required this.phoneNumber,
    required this.code,
    this.password,
  });

  factory VerifyCodeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestDtoFromJson(json);

  final String deviceId;
  final String phoneNumber;
  final String code;
  final String? password;

  Map<String, dynamic> toJson() => _$VerifyCodeRequestDtoToJson(this);
}
