import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';

/// A generic wrapper used to represent the outcome of an operation
/// (usually from Repository or Service layer).
///
/// This class follows the Result pattern and ensures that every
/// async operation returns either:
///
/// - Success<T> → Contains valid data.
/// - Error<T>   → Contains a specific ErrorType.
///
/// This helps:
/// - Avoid throwing exceptions across layers
/// - Enforce explicit success/error handling
/// - Keep business logic predictable and testable
///
/// Example usage in Repository:
///
///   Future<Result<UserModel>> getUser() async {
///     try {
///       final response = await apiCall();
///       return Success(UserModel.fromJson(response));
///     } catch (e) {
///       return Error(ServerError());
///     }
///   }
abstract class Result<T> {
  const Result();
}


/// Represents a successful operation containing a value of type T.
class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}


/// Represents a failed operation containing a specific ErrorType.
class Error<T> extends Result<T> {
  final ErrorType type;
  const Error(this.type);
}


/// Base class for defining different types of errors.
///
/// Each error type must implement `getText()`
/// which returns a user-friendly error message
/// based on the current BuildContext (useful for localization).
///
/// Example:
///   class NetworkError extends ErrorType {
///     @override
///     String getText(BuildContext context) {
///       return AppLocalizations.of(context)!.networkError;
///     }
///   }
abstract class ErrorType {
  String getText(BuildContext context);
}

// Concrete ErrorType classes for specific error scenarios
class ErrorWithMessage extends ErrorType {
  final String? code;
  final String message;
  ErrorWithMessage({this.code, required this.message});

  @override
  String getText(BuildContext context) {
    if (code != null) {
      return "Message: $message, Code: $code";
    } else {
      return "Message: $message";
    }
  }

  factory ErrorWithMessage.fromApiResponse(Map<String, dynamic> response) {
    return ErrorWithMessage(message: response['message'] ?? "");
  }
}

class TokenExpiredError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.tokenExpireError.capitalize;
  }
}

class InvalidTokenError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.invalidTokenError.capitalize;
  }
}

class BadRequestError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.badRequestError.capitalize;
  }
}

class InternalServerError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.badRequestError.capitalize;
  }
}

class ConflictError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.conflictError.capitalize;
  }
}

class NotFoundError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.notFound.capitalize;
  }
}

class UnauthenticatedError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.unauthenticatedError.capitalize;
  }
}

class NetworkTimeoutError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.timeOutError.capitalize;
  }
}

class RequestCancelledError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.requestCancelledError.capitalize;
  }
}

class DeserializationError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.deserializationError.capitalize;
  }
}

class ResponseStatusFailed extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.responseStatusFail.capitalize;
  }
}

class SerializationError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.serializationError.capitalize;
  }
}

class GenericError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.genericError.capitalize;
  }
}

class LoginAttemptError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.loginAttemptError.capitalize;
  }
}

class InternetNetworkError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.networkError.capitalize;
  }
}

class InvalidInputError extends ErrorType {
  @override
  String getText(BuildContext context) {
    return AppString.errorType.invalidInput.capitalize;
  }
}
