import 'package:dio/dio.dart';

Future<void> callApi<T>({
  required Function api,
  Object? data,
  void Function(T)? onComplete,
  void Function(List, int)? onFailed,
  void Function()? onError,
}) async {
  await (data == null ? api() : api(data))
      .then((T response) => onComplete?.call(response))
      .catchError((e, stackTrace) {
    if (e is DioException &&
        e.response != null &&
        e.response?.data != null &&
        e.response?.data is Map) {
        if (e.response?.data.containsKey("errors")) {
          onFailed?.call(e.response?.data["errors"], e.response!.statusCode!);
        } else if (e.response?.data.containsKey("error")) {
          onFailed?.call([e.response?.data["error"]], e.response!.statusCode!);
        } else {
          onError?.call();
        }
    } else {
      print(e);
      onError?.call();
    }
  });
}
