import 'dart:async';
import 'package:dio/dio.dart';

import 'results.dart';

class INetworkClient {
  // ignore: missing_return
  Future<Result> call(dynamic endpoint, {bool formData = false}) {}
}

class NetworkClient implements INetworkClient {
  final Dio _dio;
  final String baseURL;

  NetworkClient(this._dio, this.baseURL);

  Future<Result> call(dynamic endpoint, {bool formData = false}) async {


    Result result;
    _dio.options.baseUrl =  baseURL;
    _dio.options.method = endpoint.method.toString().split('.').last;
    _dio.options.headers = endpoint.headers;

    print(_dio.options.baseUrl);

    if(formData){

      print("FORM DATA API CALLED");

      Response response =  await _dio.post(endpoint.path, data: endpoint.body, );

      result = Success<Response>(response);

      return result;

    }else {
      try {
        Response response = await _dio.request(
            endpoint.path, data: endpoint.body);
        result = Success<Response>(response);
        print(result);
        return result;
      } catch (x) {
        print(x);
        print("CATCH");
        print(x);
        result = Success<Response>(x.response);

        return result;
      }
    }


  }
}
