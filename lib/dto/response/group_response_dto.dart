import 'package:hermes_app/dto/error_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/group_response_dto.g.dart';

@JsonSerializable()
class GroupResponseDto extends ErrorDto {
  const GroupResponseDto({
    required this.groupId,
    this.title,
    this.photo,
    this.userId,
    required super.errors,
  });

  factory GroupResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseDtoFromJson(json);

  final int groupId;
  final String? title;
  final String? photo;
  final int? userId;

  Map<String, dynamic> toJson() => _$GroupResponseDtoToJson(this);
}