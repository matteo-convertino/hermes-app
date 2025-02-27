import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/group_request_dto.g.dart';

@JsonSerializable()
class GroupRequestDto {
  const GroupRequestDto({required this.groupId});

  factory GroupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GroupRequestDtoFromJson(json);

  final int groupId;

  Map<String, dynamic> toJson() => _$GroupRequestDtoToJson(this);
}
