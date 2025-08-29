import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data, {required HeaderType headerType});

  Future<dynamic> getPostApiResponseWithImage(String url, dynamic data, File file, fileKey,String? extension);
}

enum HeaderType { applicationJson, withoutApplicationJson }