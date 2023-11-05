import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/community/dormain/models/dtos/get_connections_res_dto.dart';
import 'package:triberly/app/community/dormain/services/connection_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class CommunityController extends StateNotifier<CommunityState> {
  CommunityController(this.ref, this._connectionService)
      : super(CommunityInitial());
  final StateNotifierProviderRef ref;
  final ConnectionImpService _connectionService;
  UserConnectionsData? userConnections;

  Future<void> caller() async {
    try {
      state = CommunityLoading();

      state = CommunitySuccess();
    } catch (e) {
      state = CommunityError(e.toString());
    }
  }

  Future<void> getConnections() async {
    try {
      state = ConnectionsLoading();

      final response = await _connectionService.getConnections();
      userConnections = response?.data;

      state = ConnectionsSuccess();
    } catch (e) {
      state = ConnectionsError(e.toString());
    }
  }

  Future<void> saveConnection(String userId, String? message) async {
    try {
      state = SaveConnectionLoading();

      final response =
          await _connectionService.saveConnections(userId, message);

      state = SaveConnectionSuccess();
    } catch (e) {
      state = SaveConnectionError(e.toString());
    }
  }
}

final communityProvider =
    StateNotifierProvider<CommunityController, CommunityState>((ref) {
  return CommunityController(ref, sl());
});

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunitySuccess extends CommunityState {}

class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);
}

class ConnectionsLoading extends CommunityState {}

class ConnectionsSuccess extends CommunityState {}

class ConnectionsError extends CommunityState {
  final String message;

  ConnectionsError(this.message);
}

class SaveConnectionLoading extends CommunityState {}

class SaveConnectionSuccess extends CommunityState {}

class SaveConnectionError extends CommunityState {
  final String message;

  SaveConnectionError(this.message);
}
