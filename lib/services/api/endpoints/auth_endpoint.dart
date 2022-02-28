import '../endpoints.dart';

const String headerAuth = "Authorization";

const String token = "{token}";

const String postid = "{postid}";

class AuthEndpoints {
  AuthEndpoints._();

  // Add
  static get loginUser => AuthEndpoint("/v1/users/", Method.put);
  static get registerUser => AuthEndpoint("/v1/users/", Method.post);
  static get addBill => AuthEndpoint("/v1/bill/", Method.post);
  static get addReport => AuthEndpoint("/v1/report/", Method.post);
  static get addEditUserDetails => AuthEndpoint("/v1/users/id/", Method.put);
  static get addMember => AuthEndpoint("/v1/family/", Method.post);
  static get addPrescription => AuthEndpoint("/v1/prescription/", Method.post);
  static get addMedicine => AuthEndpoint("/v1/medicine/", Method.post);

  // Edit
  static get editMember => AuthEndpoint("/v1/family/", Method.put);
  static get editBill => AuthEndpoint("/v1/bill/", Method.put);
  static get editReport => AuthEndpoint("/v1/report/", Method.put);
  static get editPrescription => AuthEndpoint("/v1/prescription/", Method.put);

  // Get
  static get getMember => AuthEndpoint("/v1/family/id/", Method.put);
  static get getUser => AuthEndpoint("/v1/users/", Method.get);
  static get getAllmember => AuthEndpoint("/v1/family", Method.get);
  static get getDocuments => AuthEndpoint("/v1/document/", Method.put);

  // Delete
  static get deletePrescription =>
      AuthEndpoint("/v1/prescription/", Method.delete);
  static get deleteReport => AuthEndpoint("/v1/report/", Method.delete);
  static get deleteBill => AuthEndpoint("/v1/bill/", Method.delete);
  static get deleteMember => AuthEndpoint("/v1/family/id/", Method.delete);
}
