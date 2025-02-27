import 'package:dio/dio.dart' hide Headers;
import 'package:hermes_app/dto/request/device_request_dto.dart';
import 'package:hermes_app/dto/request/init_login_request_dto.dart';
import 'package:hermes_app/dto/request/preferences_request_dto.dart';
import 'package:hermes_app/dto/request/verify_code_request_dto.dart';
import 'package:hermes_app/dto/response/device_response_dto.dart';
import 'package:hermes_app/dto/response/group_response_dto.dart';
import 'package:hermes_app/dto/response/init_login_response_dto.dart';
import 'package:hermes_app/dto/response/preferences_response_dto.dart';
import 'package:hermes_app/dto/response/topic_response_dto.dart';
import 'package:hermes_app/dto/response/verify_code_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/request/feedback_request_dto.dart';
import '../../dto/request/group_request_dto.dart';
import '../../dto/response/feedback_response_dto.dart';

part '../generated/interface/hermes_repository.g.dart';

/*abstract class HermesRepository {

}*/

@RestApi()
abstract class HermesRepository {
  factory HermesRepository(Dio dio, {String? baseUrl}) = _HermesRepository;

  String? get baseUrl;
  set baseUrl(String? url);

  @GET('/ping')
  Future<void> ping();

  @POST('/init-login')
  Future<InitLoginResponseDto> initLogin(@Body() InitLoginRequestDto _);

  @POST('/login-verify-code')
  Future<VerifyCodeResponseDto> verifyCode(@Body() VerifyCodeRequestDto _);

  @GET('/topics')
  Future<List<TopicResponseDto>> getAllTopics();

  @GET('/user-topics')
  Future<List<PreferencesResponseDto>> getAllPreferences();

  @POST('/user-topics')
  Future<PreferencesResponseDto> addPreference(@Body() PreferencesRequestDto _);

  @DELETE('/user-topics')
  Future<PreferencesResponseDto> deletePreference(@Query('topicId') int _);

  @POST('/groups')
  Future<GroupResponseDto> addGroup(@Body() GroupRequestDto _);

  @GET('/groups')
  Future<List<GroupResponseDto>> getAllGroups();

  @GET('/groups/active')
  Future<List<GroupResponseDto>> getAllActiveGroups();

  @DELETE('/groups')
  Future<GroupResponseDto> deleteGroup(@Body() GroupRequestDto _);

  @PUT('/devices/update-firebase-token')
  Future<DeviceResponseDto> updateFirebaseToken(@Body() DeviceRequestDto _);

  @POST('/feedback')
  Future<FeedbackResponseDto> addFeedback(@Body() FeedbackRequestDto _);
}
