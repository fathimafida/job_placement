import 'package:dio/dio.dart';

import 'logman_interceptor.dart';

final bool isEmulator = true;
final dioClient = Dio(BaseOptions(
  baseUrl: isEmulator ? "http://10.0.2.2:8000" : 'http://localhost:8000',
))
  ..interceptors.add(LogmanDioInterceptor());
