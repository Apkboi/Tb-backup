import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/get_profile.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class SetupProfileController extends StateNotifier<SetupProfileState> {
  SetupProfileController(this.ref, this._accountImpService)
      : super(SetupProfileInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  GetProfile userProfile = GetProfile();

  Future<void> uploadOtherPhotos(UpdateOtherPhotosReqDto data) async {
    try {
      state = UploadOtherPhotosLoading();
      await _accountImpService.updateOtherPhotos(data);

      state = UploadOtherPhotosSuccess();
    } catch (e) {
      state = UploadOtherPhotosError(e.toString());
    }
  }

  Future<void> updateProfile(UpdateProfileReqDto data) async {
    try {
      state = SetupProfileLoading();
      await _accountImpService.updateProfile(data);

      state = SetupProfileSuccess();
    } catch (e) {
      state = SetupProfileError(e.toString());
    }
  }

  Future<void> getProfile() async {
    try {
      state = SetupProfileLoading();
      userProfile = await _accountImpService.getProfile();

      state = SetupProfileSuccess();
    } catch (e) {
      state = SetupProfileError(e.toString());
    }
  }
}

final setupProfileProvider =
    StateNotifierProvider<SetupProfileController, SetupProfileState>((ref) {
  return SetupProfileController(ref, sl());
});

abstract class SetupProfileState {}

class SetupProfileInitial extends SetupProfileState {}

class SetupProfileLoading extends SetupProfileState {}

class SetupProfileSuccess extends SetupProfileState {}

class SetupProfileError extends SetupProfileState {
  final String message;

  SetupProfileError(this.message);
}

class UploadOtherPhotosLoading extends SetupProfileState {}

class UploadOtherPhotosSuccess extends SetupProfileState {}

class UploadOtherPhotosError extends SetupProfileState {
  final String message;
  UploadOtherPhotosError(this.message);
}
