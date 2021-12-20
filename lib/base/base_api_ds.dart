import 'dart:convert';
import 'dart:io';

import 'package:astro_talk/common/constants.dart';
import 'package:astro_talk/network/app_exception.dart';
import 'package:astro_talk/network/model/base_reponse.dart';
import 'package:dio/dio.dart';

/// Base class for all the data source which will call
/// external APIs for the data.
class BaseApiDS {
  /// Wrapper for API calls for handling errors at common place
  /// instead of parsing it in calling Widgets.
  Future<BaseResponse<T>> callApi<T>(Future<Response<T>> future) {
    return future.then((response) {
      jsonEncode(response.data);
      return BaseResponse(data: response.data, success: true);
    }).onError((error, stackTrace) {
      // If error is DioError i.e http exception, we
      // should parse the exact message instead of
      // returning the HTTP Status code and standard message.
      if (error is DioError) {
        // Check if error is of time out error
        if (error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          return BaseResponse(
            exception: ServerConnectionException(
                'Couldn\'t connect with server. Please try again.'),
          );
        }

        // Check if the error is regarding no internet connection.
        if (error.type == DioErrorType.other &&
            error.error is SocketException) {
          return BaseResponse(
            exception: NoInternetException(),
          );
        }

        final exception = _getErrorObject(error);
        return BaseResponse(exception: exception);
      }

      // We are here that means the error wasn't http exception.
      // This could be any un-handled exception from server.
      // In this case, instead of showing weird errors to users
      // like bad response or internal server error, show him
      // a generic message.
      return BaseResponse(
        exception: AppException(kSomethingWentWrongMessage),
      );
    });
  }

  /// Parses the response to get the error object if any
  /// from the API response based on status code.
  AppException _getErrorObject(DioError error) {
    final responseData = error.response?.data;

    try {
      return AppException(
          responseData['message'] ?? kSomethingWentWrongMessage);
    } on Exception catch (e) {
      return AppException(kSomethingWentWrongMessage);
    }
  }
}
