import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class LandLordRepository{

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;


  Future<dynamic> getLandlordPropertyMasters(int user_id,String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/landlords/${user_id.toString()}/property_masters'),
        headers: {'Accept':'application/json','Authorization':'Bearer ' + token},);

        print("The landlord status response is " + response.statusCode.toString());
        log("Landlords response is " + response.body.toString());

        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var landlord_temp = result['data'] as List;
          List<PropertyMaster> property_masters= landlord_temp.map((e) => PropertyMaster.fromJson(e)).toList();
          return property_masters;
        }

        else{
          return response.statusCode;
        }
    }
    
    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }
}