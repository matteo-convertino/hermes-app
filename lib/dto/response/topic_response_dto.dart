import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/topic_response_dto.g.dart';

@JsonSerializable()
class TopicResponseDto extends ErrorDto {
  const TopicResponseDto({
    required this.id,
    required this.name,
    required super.errors,
  });

  factory TopicResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TopicResponseDtoFromJson(json);

  final int id;
  final String name;

  Map<String, dynamic> toJson() => _$TopicResponseDtoToJson(this);
}
