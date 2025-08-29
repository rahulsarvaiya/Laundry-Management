import '../Utils/api_state.dart';

class ApiResponse<T> {
  String? state;
  T? data;
  String? message;
  bool? status;

  ApiResponse({this.state, this.data, this.message, this.status});

  ApiResponse.loading() : state = ApiState.LOADING;

  ApiResponse.initial() : state = ApiState.INITIAL;

  ApiResponse.completed(this.data) : state = ApiState.COMPLETED;

  ApiResponse.error(this.message) : state = ApiState.ERROR;

  ApiResponse.noInternet() : state = ApiState.NO_INTERNET;

  @override
  String toString() {
    return "Status: $state \n Message:$message \n Data: $data";
  }

}
