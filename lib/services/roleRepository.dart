import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';

class RoleRepository{

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;
  DatabaseService databaseService=DatabaseService();


  Future<dynamic> getRoles(String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/roles'),
        headers: {'Accept':'application/json','Authorization':'Bearer ' + token}
        );
         log("roles include: " + response.body.toString());
         print("role status code is " + response.statusCode.toString());
        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var role_temp = result as List;
          List<Role> roles = role_temp.map((e) => Role.fromJson(e)).toList();
          return roles;
        }

        else{
          return [];
        }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }


}