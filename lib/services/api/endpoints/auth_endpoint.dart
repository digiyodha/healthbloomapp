import '../endpoints.dart';

const String headerAuth = "Authorization";

const String token = "{token}";

const String postid = "{postid}";

class AuthEndpoints {
  AuthEndpoints._();

  // Add
  static get login => AuthEndpoint("/v1/users/", Method.put);
  static get addBill => AuthEndpoint("/v1/bill/", Method.post);
  static get addReport => AuthEndpoint("/v1/report/", Method.post);
  static get addEditUserDetails => AuthEndpoint("/v1/users/id/", Method.put);
  static get addMember => AuthEndpoint("/v1/family/", Method.post);
  static get addPrescription => AuthEndpoint("/v1/prescription/", Method.post);
  static get addMedicine => AuthEndpoint("/v1/medicine/", Method.post);
  static get addInsurance => AuthEndpoint("/v1/insurance/", Method.post);
  static get addFeedback => AuthEndpoint("/v1/feedback/", Method.post);
  static get addReminder => AuthEndpoint("/v1/reminder/", Method.post);

  // Edit
  static get editMember => AuthEndpoint("/v1/family/", Method.put);
  static get editBill => AuthEndpoint("/v1/bill/", Method.put);
  static get editReport => AuthEndpoint("/v1/report/", Method.put);
  static get editPrescription => AuthEndpoint("/v1/prescription/", Method.put);
  static get searchMedicine => AuthEndpoint("/v1/medicine/search/", Method.put);
  static get editInsurance => AuthEndpoint("/v1/insurance/", Method.put);
  static get searchInsurance =>
      AuthEndpoint("/v1/insurance/search/", Method.put);
  static get editMedicine => AuthEndpoint("/v1/medicine/", Method.put);
  static get getMedicine => AuthEndpoint("/v1/medicine/id/", Method.put);
  static get getNearbyMedical => AuthEndpoint("/v1/map/store", Method.put);
  static get getNearbyLabs => AuthEndpoint("/v1/map/lab", Method.put);
  static get getNextPage => AuthEndpoint("/v1/map/next-page", Method.put);
  static get getPlaceDetails => AuthEndpoint("/v1/map/details", Method.put);
  static get getReminderById => AuthEndpoint("/v1/reminder/id/", Method.put);
  static get getReminderByFamily => AuthEndpoint("/v1/reminder/family/", Method.put);
  static get editReminder => AuthEndpoint("/v1/reminder/", Method.put);
  static get getDocumentsFamily => AuthEndpoint("/v1/document/family/", Method.put);

  // Get
  static get getMember => AuthEndpoint("/v1/family/id/", Method.put);
  static get getUser => AuthEndpoint("/v1/users/", Method.get);
  static get getAllReminders => AuthEndpoint("/v1/reminder/", Method.get);
  static get getAllmember => AuthEndpoint("/v1/family", Method.get);
  static get getDocuments => AuthEndpoint("/v1/document/", Method.put);
  static get getNextMedicine =>
      AuthEndpoint("/v1/medicine/next-medicine/", Method.get);
  static get getFeedbackOptions =>
      AuthEndpoint("/v1/feedback/options/", Method.get);

  // Delete
  static get deletePrescription =>
      AuthEndpoint("/v1/prescription/", Method.delete);
  static get deleteReport => AuthEndpoint("/v1/report/", Method.delete);
  static get deleteBill => AuthEndpoint("/v1/bill/", Method.delete);
  static get deleteMember => AuthEndpoint("/v1/family/id/", Method.delete);
  static get deleteInsurance => AuthEndpoint("/v1/insurance/", Method.delete);
  static get deleteMedicine => AuthEndpoint("/v1/medicine/", Method.delete);
  static get deleteReminder => AuthEndpoint("/v1/reminder/", Method.delete);
}
