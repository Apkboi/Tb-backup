// ignore_for_file: unused_catch_stack

import 'package:dio/dio.dart';
import 'package:collection/collection.dart';

import 'package:triberly/core/_core.dart';

import '../_services.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  int? errorType = 0;
  ApiErrorModel? apiErrorModel;

  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError(this.errorDescription);

  factory ApiError.fromDio(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiError('Request to API was cancelled');
      case DioExceptionType.connectionTimeout:
        return ApiError('Connection timeout with API');
      case DioExceptionType.sendTimeout:
        return ApiError('Send timeout in connection with API');
      case DioExceptionType.receiveTimeout:
        return ApiError('Receive timeout in connection with API');
      case DioExceptionType.badResponse:
        return ApiError(
            'Received invalid status code: ${dioError.response?.statusCode}');
      case DioExceptionType.unknown:
        return ApiError(dioError.message ?? '');
      default:
        return ApiError('Oops!, Something went wrong, Please try again');
    }
  }
  factory ApiError.unknown(dynamic dioError) {
    return ApiError('Oops!, Something went wrong, Please try again');
  }

  ApiError.fromResponse(Object? error) {
    if (error is Response) {
      setCustomErrorMessage(error);
      _handleErr();
    } else {
      _handleErr();
      errorDescription = "Oops an error occurred, we are fixing it";
    }
  }

  _handleErr() {
    return errorDescription;
  }

  void setCustomErrorMessage(Response error) {
    if (error.data['message'] is String) {
      logger.e(error.data['message']);
      errorDescription = error.data['message'];
    } else if (error.data['errors'] is Map<String, dynamic>) {
      final erros = error.data['errors'] as Map<String, dynamic>;
      errorDescription = '';
      for (var element in erros.entries) {
        errorDescription = "$errorDescription${element.value},"
            .replaceAll('{', '')
            .replaceAll(',', '')
            .replaceAll('}', '')
            .replaceAll('message: ', '')
            .capitalizeFirst;
      }
    } else if (error.data['data'] is String) {
      errorDescription = error.data['data'];
    } else {
      final erros = error.data['msg'] as Map<String, dynamic>;
      errorDescription = '';
      for (var element in erros.entries) {
        errorDescription = "$errorDescription${element.value},"
            .replaceAll('[', '')
            .replaceAll('.', '')
            .replaceAll(']', '');
      }
    }
  }

  String extractDescriptionFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message = response?.data["message"];
        logger.e(message);

        if (message == 'Invalid Data') {
          final errors = response?.data["errors"] as List;
          message = errors.firstOrNull;
        }
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error, stackTrace) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => '$errorDescription';
}

class ApiErrorModel {
  int? code;
  String? msg;
  bool? success;

  ApiErrorModel({
    this.code,
    this.msg,
    this.success,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: json["code"],
        msg: json["message"],
        success: json["success"],
      );
}
