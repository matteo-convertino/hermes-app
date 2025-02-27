import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/preferences_request_dto.g.dart';

@JsonSerializable()
class PreferencesRequestDto {
  const PreferencesRequestDto({
    required this.topicId,
    required this.isFavourite,
  });

  factory PreferencesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PreferencesRequestDtoFromJson(json);

  final int topicId;
  final bool isFavourite;

  Map<String, dynamic> toJson() => _$PreferencesRequestDtoToJson(this);
}
