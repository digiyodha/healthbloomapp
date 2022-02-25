import '../endpoints.dart';

const String headerAuth = "Authorization";

const String token = "{token}";

const String postid = "{postid}";

class AuthEndpoints {
  AuthEndpoints._();
  static get loginUser => AuthEndpoint("/v1/users/", Method.put);
  static get registerUser => AuthEndpoint("/v1/users/", Method.post);
  static get addEditUserDetails => AuthEndpoint("/v1/users/id/", Method.put);
  static get addMember => AuthEndpoint("/v1/family/", Method.post);
  static get editMember => AuthEndpoint("/v1/family/", Method.put);
  static get getAllmember =>
      AuthEndpoint("/v1/family/get-all-members", Method.get);
  static get getMember => AuthEndpoint("/v1/family/id/", Method.put);
  static get deleteAllmember => AuthEndpoint("/v1/family/id/", Method.delete);



















  static get addBill => AuthEndpoint("/v1/bill/", Method.post);
}
