import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class AgreementRepository{

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;

  Future<dynamic> createAgreement(String token,int property_id,Agreement agreement) async{
    try{
      Map<String,String> headers={"Accept":"application/json",'Authorization':'Bearer ' + token};
      var response=http.MultipartRequest('POST',Uri.parse(BASE_URL + '/rental-agreements'),)
        ..headers.addAll(headers)
        ..fields['agreement_description']=agreement.agreement_description
        ..fields['start_date']=agreement.start_date.toString()
        ..fields['end_date']=agreement.end_date.toString()
        ..fields['tenant_id']=agreement.tenant_id.toString()
        ..fields['property_id'] = agreement.property_id.toString();

      if(agreement.file!=null){
        response.files.add(http.MultipartFile('file',File.fromUri(Uri.parse(agreement.file!.path!)).readAsBytes().asStream(),
            await File.fromUri(Uri.parse(agreement.file!.path!)).length(),
            filename: agreement.file!.name
        ));

      }

      /*response.files.add(http.MultipartFile('file',File.fromUri(Uri.parse(objFile!.path!)).readAsBytes().asStream(),
          await File.fromUri(Uri.parse(objFile.path!)).length(),
          filename: objFile.name
      ));*/


    else{
        print("image is null");
      }


      http.StreamedResponse userResponse=await response.send();
      final res=await userResponse.stream.bytesToString();


      print("status code response is " + userResponse.statusCode.toString());
      print("image  response is " + res);

      if(userResponse.statusCode==201){
        var result = jsonDecode(res);
        Agreement agreement = Agreement.fetch(result['data']);
        return agreement;
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

  Future<dynamic> getRentalAgreementsForLandlord(int landlordId,String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL  + '/landlords/${landlordId.toString()}/rental-agreements'),
        headers: {"Accept":"application/json",'Authorization':'Bearer ' + token});

        print("landlord rental agreement status code is " + response.statusCode.toString());
        log("landlord rental agreement is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var rental_agreement_temp=result['rental_agreements'] as List;
        List<Agreement> agreements= rental_agreement_temp.map((e) => Agreement.fromDetail(e)).toList();
        return agreements;
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

  Future<dynamic> getRentalAgreementsForTenants(int tenantId,String token) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL  + '/tenants/${tenantId.toString()}/rental-agreements'),
          headers: {"Accept":"application/json",'Authorization':'Bearer ' + token});

      print("tenant rental agreement status code is " + response.statusCode.toString());
      log("tenant rental agreement is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var rental_agreement_temp=result['data']['rental_agreements'] as List;
        List<Agreement> agreements= rental_agreement_temp.map((e) => Agreement.fromDetail(e)).toList();
        return agreements;
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

  Future<dynamic> signAndAcceptAgreement(int rental_agreement_id,String token,String signature) async{
    try{
        http.Response response = await http.put(Uri.parse(BASE_URL + '/rental-agreements/${rental_agreement_id.toString()}/accept'),
        headers: {'Accept':"application/json",'Authorization':'Bearer ' + token},
        body: {
          'signature':signature.toString()
        }
        );

        print("sign and accept status code is " + response.statusCode.toString());
        log("Sign and accept response is " + response.body.toString());
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
}