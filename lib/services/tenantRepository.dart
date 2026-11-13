import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class TenantRepository {

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;

  Future<dynamic> getTenants(String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/tenants'),
        headers: {'Accept':'application/json','Authorization':'Bearer ' + token},);


        print("tenant response status code is " + response.statusCode.toString());
        log("Tenant response is " + response.body.toString());

        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var tenant_temp = result['tenants'] as List;
          List<User> tenants = tenant_temp.map((e) => User.fromJson(e['tenant'])).toList();
          return tenants;
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

  Future<dynamic> getTenantsByLandlordID(String token,int landlord_id) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL + '/landlords/${landlord_id.toString()}/tenants'),
        headers: {'Accept':'application/json','Authorization':'Bearer ' + token},);


      print("tenant by landlord response status code is " + response.statusCode.toString());
      log("Tenant by landlord response is " + response.body.toString());

      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var tenant_temp = result['tenants'] as List;
        List<User> tenants = tenant_temp.map((e) => User.fromJson(e['tenant'])).toList();
        return tenants;
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