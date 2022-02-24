import '../endpoints.dart';

const String headerAuth = "Authorization";

const String token = "{token}";

const String postid = "{postid}";

class AuthEndpoints {
  AuthEndpoints._();
  static get sellerList =>
      AuthEndpoint("/v1/seller/get-seller-list", Method.get);
}
