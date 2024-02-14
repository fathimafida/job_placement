import 'package:dio/dio.dart';

import 'logman_interceptor.dart';

final bool isEmulator = false;
final dioClient = Dio(BaseOptions(
  baseUrl: isEmulator
      ? "http://10.0.0.2:8000"
      : 'https://521f-59-93-232-36.ngrok-free.app',
))
  ..interceptors.add(LogmanDioInterceptor());
