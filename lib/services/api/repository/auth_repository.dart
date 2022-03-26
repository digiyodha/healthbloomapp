import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/add_edit_user_profile_request.dart';
import 'package:health_bloom/model/request/add_feedback_request.dart';
import 'package:health_bloom/model/request/add_insurance_request.dart';
import 'package:health_bloom/model/request/add_medicine_request.dart';
import 'package:health_bloom/model/request/add_member_request.dart';
import 'package:health_bloom/model/request/add_prescription_request.dart';
import 'package:health_bloom/model/request/add_report_request.dart';
import 'package:health_bloom/model/request/delete_insurence_request.dart';
import 'package:health_bloom/model/request/delete_mdecine_request.dart';
import 'package:health_bloom/model/request/delete_member_request.dart';
import 'package:health_bloom/model/request/edit_bill_request.dart';
import 'package:health_bloom/model/request/edit_insurance_request.dart';
import 'package:health_bloom/model/request/edit_medicine._request.dart';
import 'package:health_bloom/model/request/edit_member_request.dart';
import 'package:health_bloom/model/request/edit_prescription_request.dart';
import 'package:health_bloom/model/request/edit_report_request.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/request/get_mdecine_request.dart';
import 'package:health_bloom/model/request/get_next_medicine_response.dart';
import 'package:health_bloom/model/request/search_insurance_request.dart';
import 'package:health_bloom/model/request/search_mdecine_request.dart';
import 'package:health_bloom/model/response/add_edit-user_profile_response.dart';
import 'package:health_bloom/model/response/add_family_response.dart';
import 'package:health_bloom/model/response/add_feedback_response.dart';
import 'package:health_bloom/model/response/add_insurance_response.dart';
import 'package:health_bloom/model/response/add_medicine_response.dart';
import 'package:health_bloom/model/response/add_precsription_response.dart';
import 'package:health_bloom/model/response/add_report_response.dart';
import 'package:health_bloom/model/response/delete_insurance_response.dart';
import 'package:health_bloom/model/response/delete_medicine_response.dart';
import 'package:health_bloom/model/response/delete_member_response.dart';
import 'package:health_bloom/model/response/edit_bill_response.dart';
import 'package:health_bloom/model/response/edit_insurance_response.dart';
import 'package:health_bloom/model/response/edit_medicine_response.dart';
import 'package:health_bloom/model/response/edit_member_response.dart';
import 'package:health_bloom/model/response/edit_prescription_response.dart';
import 'package:health_bloom/model/response/edit_report_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/model/response/get_feedback_options_response.dart';
import 'package:health_bloom/model/response/get_medicine_response.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/model/response/search_insurance_response.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/results.dart';

import '../../../model/request/request.dart';
import '../../../model/response/response.dart';

class NetworkRepository with ChangeNotifier {
  final NetworkManager apiClient;

  NetworkRepository({@required this.apiClient}) : assert(apiClient != null);

  /// Add edit profile
  Future<RegisterLoginResponse> loginAPI(RegisterLoginRequest request) async {
    Result apiResult = await apiClient.login(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return loginAPI(request);
  }

  /// Add edit profile
  Future<AddEditUserProfileResponse> addEditProfileAPI(
      AddEditUserProfileRequest request) async {
    Result apiResult = await apiClient.addEditProfile(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return addEditProfileAPI(request);
  }

  /// Add member
  Future<AddMemberResponse> addMemberAPI(AddMemberRequest request) async {
    Result apiResult = await apiClient.addMember(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return addMemberAPI(request);
  }

  /// Add prescription
  Future<AddPrescriptionResponse> addPrescriptionAPI(
      AddPrescriptionRequest request) async {
    Result apiResult = await apiClient.addPrescription(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return addPrescriptionAPI(request);
  }

  /// Get all member
  Future<GetAllMemberResponse> getAllMemberAPI() async {
    Result apiResult = await apiClient.getAllMember();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return getAllMemberAPI();
  }

  /// Add bill
  Future<AddBillResponse> addBillAPI(AddBillRequest request) async {
    Result apiResult = await apiClient.addBill(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addBillAPI(request);
  }

  /// Get report
  Future<AddReportResponse> addReportAPI(AddReportRequest request) async {
    Result apiResult = await apiClient.addReport(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addReportAPI(request);
  }

  /// Delete member
  Future<DeleteMemberResponse> deleteMemberAPI(
      DeleteMemberRequest request) async {
    Result apiResult = await apiClient.deletMember(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteMemberAPI(request);
  }

  /// Get docuemnets
  Future<GetAllDocumentsResponse> getDocumentsAPI(
      GetDocumentsRequest request) async {
    Result apiResult = await apiClient.getDocuments(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getDocumentsAPI(request);
  }

  /// Get docuemnets
  Future<GetUserResponse> getUserAPI() async {
    Result apiResult = await apiClient.getUser();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getUserAPI();
  }

  Future<DeletePrescriptionResponse> deletePrescriptionAPI(
      DeleteDocumentRequest request) async {
    Result apiResult = await apiClient.deletePrescription(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deletePrescriptionAPI(request);
  }

  Future<DeleteReportResponse> deleteReportAPI(
      DeleteDocumentRequest request) async {
    Result apiResult = await apiClient.deleteReport(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteReportAPI(request);
  }

  Future<DeleteBillResponse> deleteBillAPI(
      DeleteDocumentRequest request) async {
    Result apiResult = await apiClient.deleteBill(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteBillAPI(request);
  }

  Future<EditMemberResponse> editMemberAPI(EditMemberRequest request) async {
    Result apiResult = await apiClient.editMember(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editMemberAPI(request);
  }

  Future<EditBillResponse> editBillAPI(EditBillRequest request) async {
    Result apiResult = await apiClient.editBill(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editBillAPI(request);
  }

  Future<EditReportResponse> editReportAPI(EditReportRequest request) async {
    Result apiResult = await apiClient.editReport(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editReportAPI(request);
  }

  Future<EditPriscriptionResponse> editPrescriptionAPI(
      EditPriscriptionRequest request) async {
    Result apiResult = await apiClient.editPrescription(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editPrescriptionAPI(request);
  }

  Future<AddMedicineResponse> addmedicineAPI(AddMedicineRequest request) async {
    Result apiResult = await apiClient.addMedicine(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addmedicineAPI(request);
  }

  Future<SearchMedicineResponse> searchMedicineAPI(
      SearchMedicineRequest request) async {
    Result apiResult = await apiClient.searchMedicine(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return searchMedicineAPI(request);
  }

  Future<AddInsuranceResponse> addInsuranceAPI(
      AddInsuranceRequest request) async {
    Result apiResult = await apiClient.addInsurance(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addInsuranceAPI(request);
  }

  Future<EditInsuranceResponse> editInsuranceAPI(
      EditInsuranceRequest request) async {
    Result apiResult = await apiClient.editInsurance(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editInsuranceAPI(request);
  }

  Future<SearchInsuranceResponse> searchInsuranceAPI(
      SearchInsuranceRequest request) async {
    Result apiResult = await apiClient.searchInsurance(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return searchInsuranceAPI(request);
  }

  Future<DeleteInsuranceResponse> deleteInsuranceAPI(
      DeleteInsuranceRequest request) async {
    Result apiResult = await apiClient.deleteInsurance(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteInsuranceAPI(request);
  }

  Future<EditMedicineResponse> editMedicineAPI(
      EditMedicineRequest request) async {
    Result apiResult = await apiClient.editMedicine(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editMedicineAPI(request);
  }

  Future<DeleteMedicineResponse> deleteMedicineAPI(
      DeleteMedicineRequest request) async {
    Result apiResult = await apiClient.deleteMedicine(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteMedicineAPI(request);
  }

  Future<GetNextMedicineResponse> getNextMedicineAPI() async {
    Result apiResult = await apiClient.getNextMedicine();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getNextMedicineAPI();
  }

  Future<GetMedicineResponse> getMedicineAPI(GetMedicineRequest request) async {
    Result apiResult = await apiClient.getMedicine(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getMedicineAPI(request);
  }

  Future<GetFeedbackOptionsResponse> getFeedbackOptionsAPI() async {
    Result apiResult = await apiClient.getFeedbackOptions();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getFeedbackOptionsAPI();
  }

  Future<AddFeedbackResponse> addFeedbackAPI(AddFeedbackRequest request) async {
    Result apiResult = await apiClient.addFeedback(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addFeedbackAPI(request);
  }

  Future<MapsNearbyMedicalsResponse> getNearbyMedicalsAPI(MapsNearbyMedicalsRequest request) async {
    Result apiResult = await apiClient.getNearbyMedicals(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getNearbyMedicalsAPI(request);
  }

  Future<MapsNearbyMedicalsResponse> getNearbyLabsAPI(MapsNearbyMedicalsRequest request) async {
    Result apiResult = await apiClient.getNearbyLabs(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getNearbyMedicalsAPI(request);
  }

  Future<MapsPlaceDetailsResponse> getPlaceDetailsAPI(MapsPlaceDetailsRequest request) async {
    Result apiResult = await apiClient.getPlaceDetails(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getPlaceDetailsAPI(request);
  }

  Future<AddEditReminderResponse> addReminderAPI(AddReminderRequest request) async {
    Result apiResult = await apiClient.addReminder(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return addReminderAPI(request);
  }

  Future<GetReminderListResponse> getAllReminderAPI() async {
    Result apiResult = await apiClient.getAllReminder();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getAllReminderAPI();
  }

  Future<GetReminderResponse> getReminderByIdAPI(GetReminderRequest request) async {
    Result apiResult = await apiClient.getReminderById(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getReminderByIdAPI(request);
  }

  Future<GetReminderListResponse> getReminderByFamilyAPI(GetFamilyReminderRequest request) async {
    Result apiResult = await apiClient.getReminderByFamily(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getReminderByFamilyAPI(request);
  }

  Future<AddEditReminderResponse> editReminderAPI(EditReminderRequest request) async {
    Result apiResult = await apiClient.editReminder(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return editReminderAPI(request);
  }

  Future<AddEditReminderResponse> deleteReminderAPI(DeleteReminderRequest request) async {
    Result apiResult = await apiClient.deleteReminder(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return deleteReminderAPI(request);
  }

  Future<MapsNearbyMedicalsResponse> nextPageAPI(PlacesNextPageRequest request) async {
    Result apiResult = await apiClient.nextPage(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return nextPageAPI(request);
  }

  Future<GetDocumentsFamilyResponse> getDocumentsFamilyAPI(GetDocumentsFamilyRequest request) async {
    Result apiResult = await apiClient.getDocumentsFamily(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getDocumentsFamilyAPI(request);
  }

  Future<GetHealthScoreResponse> getHealthScoreAPI() async {
    Result apiResult = await apiClient.getHealthScore();
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return getHealthScoreAPI();
  }

  Future<WaterCheckResponse> waterCheckAPI(WaterCheckRequest request) async {
    Result apiResult = await apiClient.waterCheck(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return waterCheckAPI(request);
  }

  Future<MedicineCheckUncheckResponse> medicineCheckUncheckAPI(MedicineCheckUncheckRequest request) async {
    Result apiResult = await apiClient.medicineCheckUncheck(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;
    return medicineCheckUncheckAPI(request);
  }
}
