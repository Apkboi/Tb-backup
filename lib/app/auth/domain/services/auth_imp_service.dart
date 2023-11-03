import 'dart:io';
import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:triberly/app/auth/data/datasources/user_dao.dart';
import 'package:triberly/app/auth/domain/models/dtos/forgot_password_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/get_profile.dart';
import 'package:triberly/app/auth/domain/models/dtos/oauth_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/resend_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_up_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_up_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/verify_otp_req_dto.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/core/services/_services.dart';

import '../models/dtos/forgot_password_res.dart';
import '../models/dtos/verify_otp_res_dto.dart';
import 'auth_service.dart';

class AuthImpService implements AccountService {
  AuthImpService(this._networkService);

  final NetworkService _networkService;

  GoogleSignIn googleAuthService = GoogleSignIn(
    scopes: ['email'],
    // serverClientId: ,
    clientId:
        '297535846989-kpnpf9p2p5a57cfstcg9dco26ursr1u6.apps.googleusercontent.com',
  );
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<GoogleSignInAuthentication?> googleAuth() async {
    try {
      final response = await googleAuthService.signIn();

      final res = await response?.authentication;

      logger.i(res?.idToken.toString());
      logger.i(res?.accessToken.toString());
      //
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthorizationCredentialAppleID?> appleAuth() async {
    try {
      final response = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInResDto?> oauthSignIn(OauthReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.oauthLogin,
        RequestMethod.post,
        data: data.toJson(),
      );
      sl<UserImpDao>()
          .storeUser(SignInResDto.fromJson(response.data).data?.user);

      return SignInResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignUpResDto> signUp(SignUpReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.register,
        RequestMethod.post,
        data: data.toJson(),
      );

      final signupData = SignUpResDto.fromJson(response.data);

      SessionManager.instance.authToken = signupData.data?.token ?? '';

      sl<UserImpDao>().storeUser(signupData.data?.user);

      return signupData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignInResDto> signIn(SignInReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.login,
        RequestMethod.post,
        data: data.toJson(),
      );

      final signInData = SignInResDto.fromJson(response.data);

      await sl<UserImpDao>().storeUser(signInData.data?.user);

      final user = sl<UserImpDao>().user;
      logger.e(user);
      logger.e(signInData.data?.user);

      return signInData;
    } catch (e) {
      logger.e(e);
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
      sl<UserImpDao>().storeUser(GetProfile.fromJson(response.data).data);

      return GetProfile.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ForgotPasswordRes> forgotPassword(ForgotPasswordReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.forgotPassword,
        RequestMethod.post,
        data: data.toJson(),
      );

      return ForgotPasswordRes.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResDto> resendOtp(ResendOtpReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.resendOtp,
        RequestMethod.post,
        data: data.toJson(),
      );

      return VerifyOtpResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResDto> verifyOtp(VerifyOtpReqDto data) async {
    try {
      final response = await _networkService(
        UrlConfig.verifyOtp,
        RequestMethod.post,
        data: data.toJson(),
      );

      return VerifyOtpResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
