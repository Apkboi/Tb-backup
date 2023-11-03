import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:triberly/core/services/location_service/location_service.dart';

class LocationAccessController extends StateNotifier<LocationAccessState> {
  LocationAccessController(this.ref, this._locationService)
      : super(LocationAccessInitial());
  final StateNotifierProviderRef ref;
  final LocationService _locationService;

  Future<Position?> getUserLocation() async {
    try {
      state = LocationAccessLoading();

      final response = await _locationService.getCurrentPosition();

      state = LocationAccessSuccess();
      return response;
    } catch (e) {
      state = LocationAccessError(e.toString());
      return null;
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
