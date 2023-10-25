// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse({
    this.status,
    this.data,
    this.message,
  });

  // ignore: non_constant_identifier_names
  ApiResponse.Loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status:$status \n Meesage: $message \n  Data:$data';
  }
}
