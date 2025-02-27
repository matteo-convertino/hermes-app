import 'package:dio/dio.dart';
import 'package:hermes_app/repository/interface/hermes_repository.dart';

class HermesRepositoryProvider {
  late HermesRepository client;

  HermesRepositoryProvider(Dio dio) {
    client = HermesRepository(dio);
  }

  set dio(Dio dio) {
    client = HermesRepository(dio, baseUrl: client.baseUrl);
  }
}