import 'package:flutter/material.dart';
import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';

class NetworkRepository with ChangeNotifier {
  final NetworkManager apiClient;

  NetworkRepository({@required this.apiClient}) : assert(apiClient != null);

//  Get product
  // Future<ProductResponse> getProductAPI(ProductRequest request) async {
  //   Result apiResult = await apiClient.getProduct(request);
  //   if (apiResult is Success) return apiResult.data;
  //   if (apiResult is Error) throw apiResult.error;

  //   return getProductAPI(request);
  // }

  // get customer

}
