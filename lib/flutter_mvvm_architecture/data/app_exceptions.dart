// ignore_for_file: prefer_typing_uninitialized_variables

class AppExepction implements Exception {
  final _message;
  final _prefix;

  AppExepction(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppExepction {
  FetchDataException([String? message])
      : super(message, 'Error during Communication ');
}

class BadDataException extends AppExepction {
  BadDataException([String? message]) : super(message, 'Invalid Request');
}

class UnAuthorizedException extends AppExepction {
  UnAuthorizedException([String? message])
      : super(message, 'UnAuthorized Request');
}

class InvalidInputException extends AppExepction {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

// // Define an enum to represent error categories
// enum ErrorCategory {
//   communication,
//   request,
//   authorization,
//   input,
// }

// class AppException implements Exception {
//   final ErrorCategory category;
//   final String message;

//   AppException(this.category, this.message);

//   @override
//   String toString() {
//     return '${_categoryToString(category)}: $message';
//   }

//   String _categoryToString(ErrorCategory category) {
//     switch (category) {
//       case ErrorCategory.communication:
//         return 'Error during Communication';
//       case ErrorCategory.request:
//         return 'Invalid Request';
//       case ErrorCategory.authorization:
//         return 'UnAuthorized Request';
//       case ErrorCategory.input:
//         return 'Invalid Input';
//     }
//   }
// }
