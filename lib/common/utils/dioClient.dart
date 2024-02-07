import 'package:dio/dio.dart';

final bool isEmulator = false;
final dioClient = Dio(BaseOptions(
  baseUrl: isEmulator ? "http://10.0.0.2:8000" : 'http://localhost:8000',
));
