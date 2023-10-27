import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/home/presentation/pages/home/home_controller.dart';
import 'package:triberly/core/services/di/di.dart';

class ProfileDetailsController extends StateNotifier<ProfileDetailsState> {
  ProfileDetailsController(this.ref, this._accountImpService)
      : super(ProfileDetailsInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  UserDto? userDetails;

  Future<void> getUserDetails(String userId) async {
    try {
      state = ProfileDetailsLoading();

      final listUsers = ref.read(homeProvider.notifier).randomUsers;

      userDetails = listUsers
          .firstWhereOrNull((element) => element.id == num.parse(userId));

      state = ProfileDetailsSuccess();
    } catch (e) {
      state = ProfileDetailsError(e.toString());
    }
  }

  Future<void> getUserDetailsMain(String userId) async {
    try {
      state = ProfileDetailsLoading();

      final response = await _accountImpService.getUser(userId);

      userDetails = response.data;

      state = ProfileDetailsSuccess();
    } catch (e) {
      state = ProfileDetailsError(e.toString());
    }
  }
}

final profileDetailsProvider =
    StateNotifierProvider<ProfileDetailsController, ProfileDetailsState>((ref) {
  return ProfileDetailsController(ref, sl());
});

abstract class ProfileDetailsState {}

class ProfileDetailsInitial extends ProfileDetailsState {}

class ProfileDetailsLoading extends ProfileDetailsState {}

class ProfileDetailsSuccess extends ProfileDetailsState {}

class ProfileDetailsError extends ProfileDetailsState {
  final String message;

  ProfileDetailsError(this.message);
}
