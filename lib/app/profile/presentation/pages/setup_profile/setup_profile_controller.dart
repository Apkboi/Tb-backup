import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/config_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/countries_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/get_profile.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/core/services/di/di.dart';

enum ProfileForm { bio, ethnicity, interest, others }

class SetupProfileController extends StateNotifier<SetupProfileState> {
  SetupProfileController(this.ref, this._accountImpService)
      : super(SetupProfileInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  GetProfile userProfile = GetProfile();

  List<Hashtags> hashtags = [];
  List<Interests> interests = [];
  List<Languages> languages = [];
  List<Tribes> tribes = [];
  List<CountriesData> countries = [];

  Future<void> uploadOtherPhotos(UpdateOtherPhotosReqDto data) async {
    try {
      state = UploadOtherPhotosLoading();
      var res = await _accountImpService.updateOtherPhotos(data);
      // Retrieve and save user information locally
      await getProfile();

      state = UploadOtherPhotosSuccess();
    } catch (e) {
      state = UploadOtherPhotosError(e.toString());
    }
  }

  Future<void> updateProfile(UpdateProfileReqDto data) async {
    try {
      state = SetupProfileLoading();
      var res = await _accountImpService.updateProfile(data);

      userProfile.data = res?.data?.toUserModel;

      sl<UserImpDao>().storeUser(res?.data?.toUserModel);
      sl<UserImpDao>().getUser();

      state = SetupProfileSuccess();
    } catch (e) {
      state = SetupProfileError(e.toString());
    }
  }

  Future<void> getProfile() async {
    try {
      state = SetupProfileLoading();
      userProfile = await _accountImpService.getProfile();
      sl<UserImpDao>().storeUser(userProfile.data);
      sl<UserImpDao>().getUser();

      state = SetupProfileSuccess();
    } catch (e) {
      state = SetupProfileError(e.toString());
    }
  }

  Future<void> getDataConfigs() async {
    try {
      state = GetConfigsLoading();

      ConfigResDto? configs;
      CountriesResDto? countriesResDto;

      await Future.wait([
        _accountImpService.getProfile(),
        _accountImpService.getConfigs(),
        _accountImpService.getCountries(),
      ]).then((value) {
        userProfile = value[0] as GetProfile;
        configs = value[1] as ConfigResDto?;
        countriesResDto = value[2] as CountriesResDto?;
      });

      hashtags = configs?.data?.hashtags ?? [];
      interests = configs?.data?.interests ?? [];
      languages = configs?.data?.languages ?? [];
      tribes = configs?.data?.tribes ?? [];
      countries = countriesResDto?.callData?.data ?? [];

      // logger.e(tribes);

      state = GetConfigsSuccess();
    } catch (e, stac) {
      logger.e(stac);
      logger.e(e);

      state = GetConfigsError(e.toString());
    }
  }

  void validateProfileForm(ProfileForm form, int nextIndex) {
    switch (form) {
      case ProfileForm.bio:
        state = PersonalBioValidation(nextIndex);
        break;

      case ProfileForm.ethnicity:
        state = EthnicityValidation(nextIndex);
        break;

      case ProfileForm.interest:
        state = InterestValidation(nextIndex);
        break;

      case ProfileForm.others:
        state = OthersValidation(nextIndex);
        break;
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

class GetConfigsLoading extends SetupProfileState {}

class GetConfigsSuccess extends SetupProfileState {}

class GetConfigsError extends SetupProfileState {
  final String message;

  GetConfigsError(this.message);
}

// Validation States

class PersonalBioValidation extends SetupProfileState {
  PersonalBioValidation(this.nextIndex);

  int nextIndex;
}

class EthnicityValidation extends SetupProfileState {
  EthnicityValidation(this.nextIndex);

  int nextIndex;
}

class InterestValidation extends SetupProfileState {
  InterestValidation(this.nextIndex);

  int nextIndex;
}

class OthersValidation extends SetupProfileState {
  OthersValidation(this.nextIndex);

  int nextIndex;
}

final selectedHashTagProvider =
    StateProvider.autoDispose<List<Hashtags>>((ref) => []);
final selectedInterestsProvider =
    StateProvider.autoDispose<List<Interests>>((ref) => []);
