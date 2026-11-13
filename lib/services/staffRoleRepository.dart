import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';

class StaffRoleRepository {
  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;
  DatabaseService databaseService=DatabaseService();

  Future<dynamic> addStaffRole(int property_id,String name,int user_id,String token) async{
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/create-staff-role'),
          headers: {'Accept':'application/json','Authorization':'Bearer ' + token},
          body: {
            'property_id':property_id.toString(),
            'name':name.toString(),
            // 'user_id':user_id.toString()
          });

      print("The add staff status code is " + response.statusCode.toString());
      log("The add staff role response is " + response.body.toString());
      if(response.statusCode==200){
        return response.statusCode;
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

  Future<dynamic> getStaffByLandlordID(int landlordId,String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/landlords/${landlordId}/staff-roles'),
          headers: {'Accept':'application/json','Authorization':'Bearer ' + token},
        );

        print("Staff role is " + response.statusCode.toString());
        log("Staff roles response is " + response.body.toString());
        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var staff_result = result['data'] as List;
          List<StaffRole> staffRole = staff_result.map((e) => StaffRole.fromJson(e)).toList();
          return staffRole;
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