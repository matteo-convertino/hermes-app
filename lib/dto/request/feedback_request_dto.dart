import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/feedback_request_dto.g.dart';

@JsonSerializable()
class FeedbackRequestDto {
  const FeedbackRequestDto({
    required this.text,
    required this.label,
  });

  factory FeedbackRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FeedbackRequestDtoFromJson(json);

  final String text;
  final int label;

  Map<String, dynamic> toJson() => _$FeedbackRequestDtoToJson(this);
}
