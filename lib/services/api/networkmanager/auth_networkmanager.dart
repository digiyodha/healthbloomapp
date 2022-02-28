import 'dart:convert';

import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/request/add_edit_user_profile_request.dart';
import 'package:health_bloom/model/request/add_member_request.dart';
import 'package:health_bloom/model/request/add_prescription_request.dart';
import 'package:health_bloom/model/request/add_report_request.dart';
import 'package:health_bloom/model/request/delete_member_request.dart';
import 'package:health_bloom/model/request/edit_bill_request.dart';
import 'package:health_bloom/model/request/edit_member_request.dart';
import 'package:health_bloom/model/request/edit_prescription_request.dart';
import 'package:health_bloom/model/request/edit_report_request.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/request/login_user_resquest.dart';
import 'package:health_bloom/model/request/resgister_user_request.dart';
import 'package:health_bloom/model/response/add_edit-user_profile_response.dart';
import 'package:health_bloom/model/response/add_family_response.dart';
import 'package:health_bloom/model/response/add_precsription_response.dart';
import 'package:health_bloom/model/response/add_report_response.dart';
import 'package:health_bloom/model/response/delete_member_response.dart';
import 'package:health_bloom/model/response/edit_bill_response.dart';
import 'package:health_bloom/model/response/edit_member_response.dart';
import 'package:health_bloom/model/response/edit_prescription_response.dart';
import 'package:health_bloom/model/response/edit_report_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/model/response/login_uesr_response.dart';
import 'package:health_bloom/model/response/register_user_response.dart';
import 'package:health_bloom/services/api/endpoints.dart';
import 'package:health_bloom/services/api/endpoints/auth_endpoint.dart';
import 'package:health_bloom/services/api/results.dart';

import '../../../model/request/request.dart';
import '../../../model/response/response.dart';
import '../network_client.dart';

class NetworkManager {
  INetworkClient _client;

  NetworkManager(this._client);

  // Login User
  Future<Result> loginUser(LoginUserRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.loginUser;
    endpoint.addBody(request);

    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      LoginUserResponse response =
          LoginUserResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<LoginUserResponse>(response);
    }
    return result;
  }

  // Rregister user
  Future<Result> registerUser(RegisterUserRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.registerUser;
    endpoint.addBody(request);

    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      RegisterUserResponse response =
          RegisterUserResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<RegisterUserResponse>(response);
    }
    return result;
  }

  // Add edit profile
  Future<Result> addEditProfile(AddEditUserProfileRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.addEditUserDetails;
    endpoint.addBody(request);
    // String xAuthToken = sp.getString('xAuthToken');
    // print("xAuthToken:  ${xAuthToken.toString()}");
    // endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      AddEditUserProfileResponse response = AddEditUserProfileResponse.fromJson(
          json.decode(result.data.toString()));

      print(response);

      return Success<AddEditUserProfileResponse>(response);
    }
    return result;
  }

  // Add member
  Future<Result> addMember(AddMemberRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.addMember;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      AddMemberResponse response =
          AddMemberResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<AddMemberResponse>(response);
    }
    return result;
  }

  // Add prescription
  Future<Result> addPrescription(AddPrescriptionRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.addPrescription;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      AddPrescriptionResponse response =
          AddPrescriptionResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<AddPrescriptionResponse>(response);
    }
    return result;
  }

  // Get all member
  Future<Result> getAllMember() async {
    AuthEndpoint endpoint = AuthEndpoints.getAllmember;
    // endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      GetAllMemberResponse response =
          GetAllMemberResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<GetAllMemberResponse>(response);
    }
    return result;
  }

  // Add bill
  Future<Result> addBill(AddBillRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.addBill;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      AddBillResponse response =
          AddBillResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<AddBillResponse>(response);
    }
    return result;
  }

  // Add report
  Future<Result> addReport(AddReportRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.addReport;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      AddReportResponse response =
          AddReportResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<AddReportResponse>(response);
    }
    return result;
  }

  // delete member
  Future<Result> deletMember(DeleteMemberRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.deleteMember;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      DeleteMemberResponse response =
          DeleteMemberResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<DeleteMemberResponse>(response);
    }
    return result;
  }

  // Get documents
  Future<Result> getDocuments(GetDocumentsRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.getDocuments;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      GetAllDocumentsResponse response =
          GetAllDocumentsResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<GetAllDocumentsResponse>(response);
    }
    return result;
  }

  // Get documents
  Future<Result> getUser() async {
    AuthEndpoint endpoint = AuthEndpoints.getUser;
    // endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      GetUserResponse response =
          GetUserResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<GetUserResponse>(response);
    }
    return result;
  }

  Future<Result> deletePrescription(DeleteDocumentRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.deletePrescription;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      DeletePrescriptionResponse response = DeletePrescriptionResponse.fromJson(
          json.decode(result.data.toString()));

      print(response);

      return Success<DeletePrescriptionResponse>(response);
    }
    return result;
  }

  Future<Result> deleteReport(DeleteDocumentRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.deleteReport;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      DeleteReportResponse response =
          DeleteReportResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<DeleteReportResponse>(response);
    }
    return result;
  }

  Future<Result> deleteBill(DeleteDocumentRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.deleteBill;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      DeleteBillResponse response =
          DeleteBillResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<DeleteBillResponse>(response);
    }
    return result;
  }

  //  Edit member
  Future<Result> editMember(EditMemberRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.editMember;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      EditMemberResponse response =
          EditMemberResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<EditMemberResponse>(response);
    }
    return result;
  }

  //  Edit bill
  Future<Result> editBill(EditBillRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.editBill;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      EditBillResponse response =
          EditBillResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<EditBillResponse>(response);
    }
    return result;
  }

  //  Edit Report
  Future<Result> editReport(EditReportRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.editReport;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      EditReportResponse response =
          EditReportResponse.fromJson(json.decode(result.data.toString()));

      print(response);

      return Success<EditReportResponse>(response);
    }
    return result;
  }

  //  Edit Prescription
  Future<Result> editPrescription(EditPriscriptionRequest request) async {
    AuthEndpoint endpoint = AuthEndpoints.editPrescription;
    endpoint.addBody(request);
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
    Result result = await _client.call(
      endpoint,
    );

    if (result is Success) {
      EditPriscriptionResponse response = EditPriscriptionResponse.fromJson(
          json.decode(result.data.toString()));

      print(response);

      return Success<EditPriscriptionResponse>(response);
    }
    return result;
  }
}
