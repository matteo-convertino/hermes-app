import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/preferences_response_dto.g.dart';

@JsonSerializable()
class PreferencesResponseDto extends ErrorDto {
  const PreferencesResponseDto({
    required this.value,
    required this.topicId,
    required this.topicName,
    required super.errors,
  });

  factory PreferencesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PreferencesResponseDtoFromJson(json);

  final double value;
  final int topicId;
  final String topicName;

  Map<String, dynamic> toJson() => _$PreferencesResponseDtoToJson(this);
}
