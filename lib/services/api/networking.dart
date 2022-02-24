import 'package:dio/dio.dart';

import 'network_client.dart';
import 'networkmanager/auth_networkmanager.dart';

BaseOptions _requestOptions = BaseOptions(
  baseUrl: "http://18.222.164.63:7000",
  headers: {},
  queryParameters: {},
);

Dio _dio;
Future<Dio> _getDio() async {
  if (_dio == null) {
    _dio = await _createDio(_requestOptions);
  }
  return _dio;
}

Future<Dio> _createDio(BaseOptions options) async {
  Dio dio = Dio();

  dio.interceptors.add(LogInterceptor(
      request: true,
      responseHeader: true,
      responseBody: true,
      requestHeader: true,
      error: true));
  _dio = dio;
  return dio;
}

NetworkClient _client;
Future<NetworkClient> getClient(String baseUrl) async {
  if (_client == null) {
    _client = NetworkClient(await _getDio(), baseUrl);
  }
  return _client;
}

NetworkManager _networkManager;
Future<NetworkManager> getAuthNetworkManager(String baseURL) async {
  if (_networkManager == null) {
    _networkManager = NetworkManager(await getClient(baseURL));
  }
  return _networkManager;
}
