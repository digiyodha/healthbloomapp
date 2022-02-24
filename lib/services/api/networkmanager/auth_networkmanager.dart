import '../network_client.dart';

class NetworkManager {
  INetworkClient _client;

  NetworkManager(this._client);

  // // Add customer address
  // Future<Result> addCustomerAddress(AddCustomerAddressRequest request) async {
  //   AuthEndpoint endpoint = AuthEndpoints.addCustomerAddress;
  //   endpoint.addBody(request);
  //   String xAuthToken = sp.getString('xAuthToken');
  //   print("xAuthToken:  ${xAuthToken.toString()}");
  //   endpoint.addHeaders({"x-auth-token": xAuthToken});
  //   Result result = await _client.call(
  //     endpoint,
  //   );

  //   if (result is Success) {
  //     AddCustomerAddressResposne response = AddCustomerAddressResposne.fromJson(
  //         json.decode(result.data.toString()));

  //     print(response);

  //     return Success<AddCustomerAddressResposne>(response);
  //   }
  //   return result;
  // }

}
