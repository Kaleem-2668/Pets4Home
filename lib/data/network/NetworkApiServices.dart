import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:pets_4_home/data/network/BaseApiServices.dart';
import 'package:http/http.dart'as http;

import '../app_exceptions.dart';

class NetworkApiService extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
  try{
    final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
    responseJson = returnResponse(response);

  }on SocketException{
    throw FetchDataException('No data connection');
  }
  return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data)async {
    dynamic responseJson;
    try{
     Response response = await post(Uri.parse(url), body:data).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);

    }on SocketException{
      throw FetchDataException('No internet connection');
    }
    return responseJson;

  }

  dynamic returnResponse (http.Response response){
    switch(response.statusCode){
      case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 500:
        throw UnauthorizedException(response.body);
      case 404:
        throw InvalidInputException(response.body);

      default:
        throw FetchDataException('Error occurred while communication with server'+'with status code '+response.statusCode.toString());
    }
  }

}