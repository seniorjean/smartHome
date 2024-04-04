import 'package:http/http.dart';

class HttpResponseModel {

  bool? _status;
  int? _statusCode;
  String? _message;
  dynamic _data;
  Response? _response;

  bool? get status => _status;
  int? get statusCode => _statusCode;
  String? get message => _message;
  dynamic get data => _data;
  Response? get response => _response;

  HttpResponseModel({
      bool? status,
      int? statusCode, 
      String? message,
      Response? response,
      dynamic data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _response = response;
}

  HttpResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? json['data'] : null;
    _data = json['response'] != null ? json['response'] : Response("--no response--", 500);
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    map['data'] = _data;
    map['response'] = _response;
    return map;
  }

}