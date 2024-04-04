import 'dart:convert';
import 'package:smart_home_wifi/constants.dart';

import 'HttpResponseModel.dart';
import 'package:http/http.dart' as HTTP;

const goodResponseCode = [200, 201];

class ApiService {

  static Future<HttpResponseModel> get({required String url}) async {
    HTTP.Response? response;
    try {
      dprint('url', url);
      response = await HTTP.get(Uri.parse(url));

      dprintResponse('GET:${url}', response,payload: '{}');
      String message = '';
      if(isValidJsonResponse(response)){
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        if(jsonContainsKey(responseJson, 'message')){
          message = responseJson['message'];
        }
      }

      if (goodResponseCode.contains(response.statusCode)) {
        return HttpResponseModel(status: true, message: message, statusCode: response.statusCode, data: response.body, response: response);
      }

      return HttpResponseModel(status: false, message: message, statusCode: response.statusCode, data: response.body, response: response);

    } catch (_) {
      dprint('Error',_);
      return HttpResponseModel(status: false, message: _.toString(), statusCode: response != null ? response.statusCode : 500, data: response != null ? response.body : "---ERROR---", response: response);
    }
  }
}

String getApiUrl(String path){
  return 'http://${globalAddress}${(path.isNotEmpty)?'/${path}':''}';
}

void printDebug(dynamic msg , {String title = '' , String url = '' , int status_code = 0}){
  print('****************************************${title}****************************************');
  if(url != '')print('url : ${url}');
  if(status_code != 0) print('statusCode : ${status_code}');
  try{
    printWrapped('body : ${msg}');
  }catch(e){
    print('body : ${msg}');
  }
  print('**************************************************************************************');
}

void printWrapped(String text){
  int maxCharactersPerLine = 200;
  String responseAsString = text;
  int iterations = (responseAsString.length / maxCharactersPerLine).floor();
  for (int i = 0; i <= iterations; i++) {
    int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
    if (endingIndex > responseAsString.length) {
      endingIndex = responseAsString.length;
    }
    print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
  }
}

void dprint(String title, dynamic message) {
  print('*********************** ${title.toUpperCase()} *************************');
  try {
    printWrapped(message);
  } catch (e) {
    print(message);
  }
  print('*********************************************************');
}

void dprintResponse(String title, HTTP.Response response, {dynamic payload}) {
  print('*********************** ${title.toUpperCase()} *************************');
  try {
    print("URL ${response.request!.url}");
    print("PATH ${response.request!.method}");
    print("CODE ${response.statusCode}");
    print("HEADER ${response.request!.headers}");

    printWrapped('PAYLOAD: ${payload}');

    printWrapped("BODY : ${response.body}");
  } catch (e) {
    print(e);
    printWrapped(response.body);
  }
  print('*********************************************************');
}

bool isValidJsonString(String jsonString) {
  try {
    jsonDecode(jsonString);
    return true;
  }
  catch (e) {
    return false;
  }
}

bool isValidJsonResponse(HTTP.Response response) {
  try {
    jsonDecode(utf8.decode(response.bodyBytes));
    return true;
  }
  catch (e) {
    return false;
  }
}

bool jsonContainsKey(var json , String key){
  try{
    return json(key);
  }catch(_){
    return false;
  }
}