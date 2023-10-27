import 'dart:io';
import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/forgot_password_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/get_profile.dart';
import 'package:triberly/app/auth/domain/models/dtos/oauth_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/resend_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_up_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_up_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/verify_otp_req_dto.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_req_dto.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_res_dto.dart';
import 'package:triberly/core/services/_services.dart';

import '../models/dtos/forgot_password_res.dart';
import '../models/dtos/verify_otp_res_dto.dart';
import 'auth_service.dart';

class AccountImpService implements AccountService {
  AccountImpService(this._networkService);

  final NetworkService _networkService;

  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<UpdateProfileResDto?> updateProfile(UpdateProfileReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.updateProfile,
        RequestMethod.post,
        data: data.toJson(),
      );

      return UpdateProfileResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CountriesResDto?> getCountries() async {
    try {
      final response = await _networkService(
        UrlConfig.getCountries,
        RequestMethod.get,
      );

      return CountriesResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ConfigResDto?> getConfigs() async {
    try {
      final response = await _networkService(
        UrlConfig.getConfigs,
        RequestMethod.get,
      );

      return ConfigResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchConnectionsResDto?> searchConnections(
      SearchConnectionsReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.searchConnections,
        RequestMethod.get,
        queryParams: data.toJson(),
      );

      return SearchConnectionsResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateOtherPhotosResDto?> updateOtherPhotos(
      UpdateOtherPhotosReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.updateOtherPhotos,
        RequestMethod.post,
        data: data.toJson(),
      );

      return UpdateOtherPhotosResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetProfile> getProfile() async {
    try {
      final response = await _networkService(
        UrlConfig.me,
        RequestMethod.get,
      );

      return GetProfile.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetProfile> getUser(String userId) async {
    try {
      final response = await _networkService(
        UrlConfig.getUser(userId),
        RequestMethod.get,
      );

      return GetProfile.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
