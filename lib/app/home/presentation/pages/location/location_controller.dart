import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:triberly/core/services/di/di.dart';
import 'package:triberly/core/services/location_service/location_service.dart';

class LocationController extends StateNotifier<LocationState> {
  LocationController(this.ref) : super(LocationInitial());
  final StateNotifierProviderRef ref;

  Position? userLocation;

  Future<void> caller() async {
    try {
      state = LocationLoading();

      userLocation = await sl<LocationService>().getLatLong();

      state = LocationSuccess();
    } catch (e) {
      state = LocationError(e.toString());
    }
  }
}

final locationProvider =
    StateNotifierProvider<LocationController, LocationState>((ref) {
  return LocationController(ref);
});

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
