import 'dart:convert';

import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/request/add_edit_user_profile_request.dart';
import 'package:health_bloom/model/request/add_member_request.dart';
import 'package:health_bloom/model/request/login_user_resquest.dart';
import 'package:health_bloom/model/request/resgister_user_request.dart';
import 'package:health_bloom/model/response/add_edit-user_profile_response.dart';
import 'package:health_bloom/model/response/add_family_response.dart';
import 'package:health_bloom/model/response/login_uesr_response.dart';
import 'package:health_bloom/model/response/register_user_response.dart';
import 'package:health_bloom/services/api/endpoints.dart';
import 'package:health_bloom/services/api/endpoints/auth_endpoint.dart';
import 'package:health_bloom/services/api/results.dart';

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
    String xAuthToken = sp.getString('xAuthToken');
    print("xAuthToken:  ${xAuthToken.toString()}");
    endpoint.addHeaders({"x-auth-token": xAuthToken});
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
}
