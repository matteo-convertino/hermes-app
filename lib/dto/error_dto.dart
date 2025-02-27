import 'package:json_annotation/json_annotation.dart';

// part 'mapper/error_dto.g.dart';

// @JsonSerializable()
class ErrorDto {
  const ErrorDto({required this.errors});

  // factory ErrorDto.fromJson(Map<String, dynamic> json) => _$ErrorDtoFromJson(json);

  final List<String>? errors;

  // Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);
}