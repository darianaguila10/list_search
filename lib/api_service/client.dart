
import 'package:dio/dio.dart';
//connection settings
var options = BaseOptions(headers: { 'Content-Type': 'application/json'},
  baseUrl: 'http://173.212.193.40:5486',
  connectTimeout: 30000,
  receiveTimeout: 30000,
);

Dio dioClient = Dio(options);