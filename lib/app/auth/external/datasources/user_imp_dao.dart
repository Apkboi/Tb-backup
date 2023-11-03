import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/data/hive/hive_manager.dart';

import '../../data/datasources/user_dao.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/models/dtos/user_dto.dart';

// UserImpDao? userImpDao;

class UserImpDao implements UserDao {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  static String userStorageKey = 'user';

  Box<dynamic> _box = Hive.box(HiveBoxes.userBox);

  UserDto? get user {
    return getUser();
  }

  Future<Box<Map>> openBox() async =>
      await HiveBoxes.openBox<Map>(HiveBoxes.userBox);

  Future<void> storeUser(UserDto? user) async {
    if (user != null) {
      await _box.clear();

      final map = jsonEncode(user.toJson());

      await _box.put(userStorageKey, map);
    }
  }

  UserDto? getUser() {
    final userMap = _box.get(userStorageKey);
    if (userMap != null) {
      return UserDto.fromJson(jsonDecode(userMap));
    }
    return null;
  }

  Future<void> updateUser(UserDto updatedUser) async {
    final map = updatedUser.toJson();
    await _box!.put(userStorageKey, map);
  }

  void removeUser() async {
    await _box?.delete(userStorageKey);
  }

  ValueListenable<Box>? getListenable({List<String>? keys}) {
    return keys == null ? _box?.listenable() : _box?.listenable(keys: keys);
  }

  Future truncate() async {
    await _box?.clear();
  }
}
