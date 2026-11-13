import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';
import 'dart:io';

class ServiceRepository {
  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;

  Future<dynamic> getServices(String token) async{
  try{
     http.Response response = await http.get(Uri.parse(BASE_URL + '/somalease-services'),
         headers: {'Accept':'application/json','Authorization':'Bearer ' + token},
     );

     print("Services status code is " + response.statusCode.toString());
     print("Services response is " + response.body.toString());
     if(response.statusCode==200){
       var result = jsonDecode(response.body);
       var service_temp = result['data'] as List;
       List<SomaleaseService> somalease_service = service_temp.map((e) => SomaleaseService.fromJson(e)).toList();
       return somalease_service;
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
  
  Future<dynamic> addPropertyService(PropertyService propertyService,int somalease_service_id,String token) async{
    try{

      Map<String,String> headers={"Accept":"application/json",'Authorization':'Bearer ' + token};
      var response=http.MultipartRequest('POST',Uri.parse(BASE_URL + '/property-services'),)
        ..headers.addAll(headers)
        ..fields['name']=propertyService.name.toString()
        ..fields['phone']=propertyService.phone.toString()
        ..fields['email']=propertyService.email.toString()
        ..fields['location_name']=propertyService.location_name.toString()
        ..fields['description']=propertyService.description.toString()
        ..fields['latitude']=propertyService.latitude.toString()
        ..fields['longitude']=propertyService.longitude.toString()
        ..fields['somalease_service_id']=somalease_service_id.toString();

      if(propertyService.image!=null){
        response.files.add(http.MultipartFile('images',File.fromUri(Uri.parse(propertyService.image!.path)).readAsBytes().asStream(),
            await File.fromUri(Uri.parse(propertyService.image!.path)).length(),
            filename: propertyService.image!.path.split('/').last
        ));

      }

      else{
        print("image is null");
      }


      http.StreamedResponse userResponse=await response.send();
      final res=await userResponse.stream.bytesToString();


      print("status code response is " + userResponse.statusCode.toString());
      print("image  response is " + res);

      if(userResponse.statusCode==200){
        return userResponse.statusCode;
      }

      else{
        return userResponse.statusCode;
      }

    }
    
    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> getPropertyServiceByServiceID(String token,int service_id) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/somalease-services/${service_id}/property-services'),
        headers: {"Accept":"application/json",'Authorization':'Bearer ' + token},);


        print("The response status code is " + response.statusCode.toString());
        log("The response body is " + response.body.toString());
        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var property_service_temp = result['data'] as List;
          List<PropertyService> property_services = property_service_temp.map((e) => PropertyService.fetch(e)).toList();
          return property_services;
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

  Future<dynamic> getPropertyServiceByID(String token,int user_id) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL + '/property-services/${user_id}'),
        headers: {"Accept":"application/json",'Authorization':'Bearer ' + token},);


      print("The property user service response status code is " + response.statusCode.toString());
      log("The property user service response body is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var property_service_temp = result['data'] as List;
        List<PropertyService> property_services = property_service_temp.map((e) => PropertyService.fetch(e)).toList();
        return property_services;
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

  Future<dynamic> getPropertyServices(String token) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL + '/property-services'),
        headers: {"Accept":"application/json",'Authorization':'Bearer ' + token},);


      print("The property user service response status code is " + response.statusCode.toString());
      log("The property user service response body is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var property_service_temp = result['data'] as List;
        List<PropertyService> property_services = property_service_temp.map((e) => PropertyService.fetch(e)).toList();
        return property_services;
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