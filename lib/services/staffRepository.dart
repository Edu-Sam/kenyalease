import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';

class StaffRepository{

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;
  DatabaseService databaseService=DatabaseService();

  Future<dynamic> createStaff(Staff staff,String token) async{
   try{
     http.Response response = await http.post(Uri.parse(BASE_URL + '/staff'),
         headers: {'Accept':'application/json','Authorization':'Bearer ' + token},
         body: {
           'name': staff.name.toString(),
           'email':staff.email.toString(),
           'property_id':staff.property_id.toString(),
           'role_id':staff.role_id.toString()
         });

     print("The staff status code is " + response.statusCode.toString());
     log("The staff response is " + response.body.toString());
     if(response.statusCode==201){
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
      http.Response response = await http.get(Uri.parse(BASE_URL + '/landlords/${landlordId}/staff'),
      headers: {'Accept':'application/json','Authorization':'Bearer ' + token},
      );

      print("Get staff status code is " + response.statusCode.toString());
      log("Get staff response is " + response.body.toString());
      if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var staff_temp = result['data'] as List;
          List<Staff> staffs= staff_temp.map((e) => Staff.fromDetail(e)).toList();
          return staffs;
        //return response.statusCode;
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