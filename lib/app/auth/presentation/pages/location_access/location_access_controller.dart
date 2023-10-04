import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/services/location_service/location_service.dart';

class LocationAccessController extends StateNotifier<LocationAccessState> {
  LocationAccessController(this.ref, this._locationService)
      : super(LocationAccessInitial());
  final StateNotifierProviderRef ref;
  final LocationService _locationService;

  Future<void> getUserLocation() async {
    try {
      state = LocationAccessLoading();

      await LocationService().getCurrentPosition();

      state = LocationAccessSuccess();
    } catch (e) {
      state = LocationAccessError(e.toString());
    }
  }
}

final locationAccessProvider =
    StateNotifierProvider<LocationAccessController, LocationAccessState>((ref) {
  return LocationAccessController(ref, LocationService());
});

abstract class LocationAccessState {}

class LocationAccessInitial extends LocationAccessState {}

class LocationAccessLoading extends LocationAccessState {}

class LocationAccessSuccess extends LocationAccessState {}

class LocationAccessError extends LocationAccessState {
  final String message;

  LocationAccessError(this.message);
}
