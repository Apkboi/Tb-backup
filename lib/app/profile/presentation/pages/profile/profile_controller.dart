import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController(this.ref) : super(ProfileInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = ProfileLoading();

      state = ProfileSuccess();
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }



}

final profileProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
  return ProfileController(ref);
});

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
