import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/init_login_request_dto.g.dart';

@JsonSerializable()
class InitLoginRequestDto {
  const InitLoginRequestDto({required this.phoneNumber});

  factory InitLoginRequestDto.fromJson(Map<String, dynamic> json) => _$InitLoginRequestDtoFromJson(json);

  final String phoneNumber;

  Map<String, dynamic> toJson() => _$InitLoginRequestDtoToJson(this);
}