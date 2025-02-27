import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/verify_code_response_dto.g.dart';

@JsonSerializable()
class VerifyCodeResponseDto extends ErrorDto {
  const VerifyCodeResponseDto({
    required this.id,
    required this.deviceId,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.photo,
    required this.jwt,
    required super.errors,
  });

  factory VerifyCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseDtoFromJson(json);

  final int id;
  final String deviceId;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String username;
  final String? photo;
  final String jwt;

  Map<String, dynamic> toJson() => _$VerifyCodeResponseDtoToJson(this);
}
