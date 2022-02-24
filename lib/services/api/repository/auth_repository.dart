import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/add_edit_user_profile_request.dart';
import 'package:health_bloom/model/request/add_member_request.dart';
import 'package:health_bloom/model/request/login_user_resquest.dart';
import 'package:health_bloom/model/request/resgister_user_request.dart';
import 'package:health_bloom/model/response/add_edit-user_profile_response.dart';
import 'package:health_bloom/model/response/add_family_response.dart';
import 'package:health_bloom/model/response/login_uesr_response.dart';
import 'package:health_bloom/model/response/register_user_response.dart';
import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/results.dart';

class NetworkRepository with ChangeNotifier {
  final NetworkManager apiClient;

  NetworkRepository({@required this.apiClient}) : assert(apiClient != null);

  /// Login user
  Future<LoginUserResponse> loginUserAPI(LoginUserRequest request) async {
    Result apiResult = await apiClient.loginUser(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return loginUserAPI(request);
  }

  /// Register user
  Future<RegisterUserResponse> registerUserAPI(
      RegisterUserRequest request) async {
    Result apiResult = await apiClient.registerUser(request);
    if (apiResult is Success) return apiResult.data;
    if (apiResult is Error) throw apiResult.error;

    return registerUserAPI(request);
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
}
