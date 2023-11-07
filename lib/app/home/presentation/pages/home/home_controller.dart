import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_req_dto.dart';
import 'package:triberly/core/services/di/di.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(this.ref, this._accountImpService) : super(HomeInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  List<UserDto> randomUsers = [];
  List<UserDto> latLngUsers = [];

  SearchConnectionsReqDto filterData = SearchConnectionsReqDto();

  void clearFilter() {
    filterData = SearchConnectionsReqDto();
    caller(filterData);
  }

  void setfilterData(SearchConnectionsReqDto data) {
    if (data.intent != null) {
      filterData = filterData.copyWith(intent: data.intent);
    }
    if (data.connectWith != null) {
      filterData = filterData.copyWith(connectWith: data.connectWith);
    }
    if (data.languagues != null) {
      filterData = filterData.copyWith(languagues: data.languagues);
    }
    if (data.tribes != null) {
      filterData = filterData.copyWith(tribes: data.tribes);
    }
    if (data.originCountryId != null) {
      filterData = filterData.copyWith(originCountryId: data.originCountryId);
    }
    if (data.residenceCountryId != null) {
      filterData =
          filterData.copyWith(residenceCountryId: data.residenceCountryId);
    }
    if (data.fromAge != null) {
      filterData = filterData.copyWith(fromAge: data.fromAge);
    }
    if (data.faith != null) {
      filterData = filterData.copyWith(faith: data.faith);
    }
    if (data.toAge != null) {
      filterData = filterData.copyWith(toAge: data.toAge);
    }
    if (data.withLatLong != null) {
      filterData = filterData.copyWith(withLatLong: data.withLatLong);
    }
  }

  Future<void> caller(SearchConnectionsReqDto data) async {
    try {
      state = HomeLoading();

      final response = await _accountImpService.searchConnections(data);
      final responseLatLng = await _accountImpService.searchConnections(data.copyWith(withLatLong: true));



      randomUsers = response?.callData?.data ?? [];
      latLngUsers = responseLatLng?.callData?.data ?? [];

      // logger.log(Level.debug, randomUsers.map((e) => e.firstName));

      state = HomeSuccess();
    } catch (e) {
      state = HomeError(e.toString());
    }
  }
}

final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(ref, sl());
});

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
