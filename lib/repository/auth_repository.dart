import 'package:pets_4_home/data/network/BaseApiServices.dart';
import 'package:pets_4_home/data/network/NetworkApiServices.dart';
import 'package:pets_4_home/resources/api_urls.dart';

import '../models/article_model.dart';

class AuthRepository{
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> registerApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.registerApi,data);
      return response;

    }catch(e){
      throw e;

    }

  }
  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.loginApi,data);
      return response;

    }catch(e){
      throw e;

    }

  }




}