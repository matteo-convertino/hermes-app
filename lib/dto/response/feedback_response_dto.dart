import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/feedback_response_dto.g.dart';

@JsonSerializable()
class FeedbackResponseDto {
  const FeedbackResponseDto({
    required this.text,
    required this.label,
  });

  factory FeedbackResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseDtoFromJson(json);

  final String text;
  final int label;

  Map<String, dynamic> toJson() => _$FeedbackResponseDtoToJson(this);
}
