import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:driver/Network/base_api_services.dart';
import 'package:http/http.dart' as http;
import '../Helper/AlertHelper.dart';
import '../Model/app_exception.dart';
import '../Utils/app_global.dart';

class NetworkApiServices extends BaseApiServices{

  dynamic responseJson;

  @override
  Future getGetApiResponse(String url, {bool isExcludeToken = false}) async {
    AppGlobal.printLog('URL ==> $url');
    final http.Response response;
    try {
      response = await http.get(Uri.parse(url),
          headers: {'accept': '*/*'});
      AppGlobal.printLog('================  STATUS CODE  =======> ${response.statusCode}');
      AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${response.body}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
          AlertHelper.showToast('Authentication error. Please verify your login details.');
          break;
        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
          AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data,
      {HeaderType headerType = HeaderType.withoutApplicationJson,
        bool isExcludeToken = false,
        bool isIncludeApplicationJson = false}) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('Request Body ==> ${data.toString()}');
    dynamic responseJson;

    Map<String, String> header = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    'Cookie': 'frontend_lang=en_US; session_id=93bae60fe902301a228c400f3a5f6a4b336c516c'
    };


    try {
      var request = http.Request('POST', Uri.parse(url));
      request.headers.addAll(header);
      request.body = data;
      // request.fields.addAll(data);
      AppGlobal.printLog("Request Header :: ${request.headers}");
      var response = await request.send();

      AppGlobal.printLog('================  API RESPONSE  ================ \n$url ${response.statusCode}');
      String responseBody = await response.stream.bytesToString();
      AppGlobal.printLog('Raw response body $url: $responseBody');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson = jsonDecode(responseBody);
          return responseJson;
        case 201:
          dynamic responseJson = jsonDecode(responseBody);
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
          AlertHelper.showToast('Authentication error. Please verify your login details.');
          break;
        case 403:
          AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
          AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
         AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
          AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
         AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
         AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException catch(error) {
      AppGlobal.printLog("Socket Exception : ${error.message}");
      throw FetchDataException('No Internet Connection');
    }
    catch (e, stackTrace) {
      AppGlobal.printLog("Unknown error: $e");
      AppGlobal.printLog("StackTrace: $stackTrace");
      rethrow;
    }
    return responseJson;
  }

  @override
  Future getPostApiResponseWithImage(
      String url, dynamic data, File? file, fileKey, String? extension) async {
    AppGlobal.printLog('URL ==> $url');
    AppGlobal.printLog('Request Body ==> ${data.toString()}');
    AppGlobal.printLog('Request Body file 1==> $file');
    AppGlobal.printLog('Request Body fileKey ==> $fileKey');
    dynamic responseJson;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // request.headers.addAll({'Authorization': 'bearer ${AppGlobal.authToken}'});
      request.headers.addAll({
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
      request.fields.addAll(data);

        bool isExist = await file?.exists() ?? false;
        if (file != null && isExist) {
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();
          var multipartFile = http.MultipartFile(fileKey, stream, length,
              filename: basename(file.path));
          request.files.add(multipartFile);
        }


      AppGlobal.printLog('Request Body ==> ${request.files.toString()}');

      var response = await request.send();

      AppGlobal.printLog('================  API RESPONSE  ================ \n$url ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          dynamic responseJson =
          jsonDecode(await response.stream.bytesToString());
          AppGlobal.printLog('================  API RESPONSE  =====   $url  =========== \n${responseJson.toString()}');
          return responseJson;
        case 400:
          AlertHelper.showToast("${response.statusCode} Bad request!");
          break;
        case 401:
          AlertHelper.showToast('Authentication error. Please verify your login details.');
          break;
        case 403:
         AlertHelper.showToast("${response.statusCode} Forbidden!");
          break;
        case 404:
         AlertHelper.showToast("${response.statusCode} Not found!");
          break;
        case 405:
          AlertHelper.showToast("${response.statusCode} Method not allowed!");
          break;
        case 406:
          AlertHelper.showToast("${response.statusCode} Not accepted!");
          break;
        case 409:
         AlertHelper.showToast("${response.statusCode} Conflict!");
          break;
        case 500:
          AlertHelper.showToast("${response.statusCode} Internal server error!");
          break;
        case 502:
         AlertHelper.showToast("${response.statusCode} Bad gateway!");
          break;
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


}