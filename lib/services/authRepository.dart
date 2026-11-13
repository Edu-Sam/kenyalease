import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class AuthRepository {

  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;
  DatabaseService databaseService=DatabaseService();

  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  late SharedPreferences pref;

  Future<dynamic> signUp(User user) async{
    
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/register'),
          headers: {'Accept':'application/json'},
          body: {
            'firstname':user.firstname,
            'lastname':user.lastname,
            'phone':user.phone,
            'email':user.email,
            'password':user.password
          });

      print("signup response is " + response.body.toString());
      print("signup status code is " + response.statusCode.toString());
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

  Future<dynamic> login(String email,String password,Preferences preferences) async{

    try{
         http.Response response = await http.post(Uri.parse(BASE_URL + '/login'),
         headers: {'Accept':'application/json'},
         body: {
           'email':email,
           'password':password
         });


          log("User login response " + response.body.toString());
          print("User status code is " + response.statusCode.toString());
         if(response.statusCode==200){
           var result = jsonDecode(response.body);
           User user=User.fromJson(result['user']);
           user.remember_token = result['token'];

           if(user.roles.isNotEmpty){
             user.role_id= user.roles.first.id;
           }

           else{
             user.role_id=0;
           }

           var db_result = await databaseService.deleteAccount().then((deletedAccount) async{
             int? delete_user = await databaseService.deleteUser().then((value) async{
               int? insert_user = await databaseService.insertUser(user).then((userInserted) async{
                 User? new_user = await databaseService.getUser();
                 if(new_user.user_id!=0){
                   preferences.isLoggedIn=true;
                   new_user.roles=user.roles;
                   preferences.user=new_user;
                   preferences.account_role_types=user.roles;
                   preferences.user_state= 'LOGGED_IN';
                   preferences.user_id=new_user.user_id;
                   print("The new1 user id is " + new_user.user_id.toString());
                   user.roles.forEach((element) {
                     print("Fetched user role is " + element.firstname.toString());
                   });

                   int insertPreferences=await databaseService.insertPreference(preferences).then((value) async{
                     preferences= await databaseService.getPreferences(1) ?? preferences;
                     preferences.account_role_types=user.roles;
                     print("Returned preferences is " + preferences.user_id.toString());
                     setSignUpPreferences('LOGGED_IN',preferences);
                     return value;
                   });

                   return insertPreferences;

                 }
               });

               return insert_user;
             });
             return delete_user;
           });

           return preferences;
         }

         else{
           return 403;
         }
    }

    catch(Exception,stacktrace){

      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updateRoles(List<String> role_ids,Preferences preferences) async{

    print("User id is " + preferences.user!.user_id.toString());
    role_ids.forEach((element) {
      print("The role id is " + element);
    });
    Map<String, dynamic> args = {"role_ids": role_ids};
    print("The user id is " + preferences.user!.user_id.toString());
    var body = json.encode(args);
   // print("role id is " + role_id.toString());
    try{

   //   Map<String,String> headers={"Accept":"application/json","authorization": basic_auth};
      Dio dio = Dio();
      dio.options.contentType = "application/json";
      dio.options.headers['Authorization'] = 'Bearer ' + preferences.user!.remember_token;

      FormData formData = FormData.fromMap({
        "role_ids": ""

      });

      Response response = await dio.put(BASE_URL + '/users/${preferences.user!.user_id.toString()}/update-role',
          data: {
        "role_ids":role_ids
          }
      );
      /*final response = await http.put(Uri.parse(BASE_URL + '/users/${preferences.user!.user_id.toString()}/update-role'),
          headers: {'Accept':'application/json','Authorization':'Bearer ' + preferences.user!.remember_token},
          //body: body
        body: {
        "role_ids": role_ids.toString()
        }

      );*/

      print("The response status code is " + response.statusCode.toString());
      log("The user created is " + response.data.toString());
      if(response.statusCode==200){
        //var result = jsonDecode(response.data);
        var result = response.data;
       // var result = jsonDecode(response.body);
        String previous_token = preferences.user!.remember_token;
        User user=User.fetch(result['user']);
        user.remember_token = previous_token;
         if(user.roles.isNotEmpty){
             user.role_id= user.roles.first.id;
           }

           else{
             user.role_id=0;
           }


        var db_result = await databaseService.deleteAccount().then((deletedAccount) async{
          int? delete_user = await databaseService.deleteUser().then((value) async{
            int? insert_user = await databaseService.insertUser(user).then((userInserted) async{
              User? new_user = await databaseService.getUser();
              if(new_user.user_id!=0){
                preferences.isLoggedIn=true;
                 new_user.roles=user.roles;
                preferences.user=new_user;
                preferences.account_role_types=user.roles;
                preferences.user_state= 'LOGGED_IN';
                preferences.user_id=new_user.user_id;
                print("The new user id is " + new_user.user_id.toString());

                int insertPreferences=await databaseService.insertPreference(preferences).then((value) async{
                  preferences= await databaseService.getPreferences(1) ?? preferences;
                  preferences.account_role_types=user.roles;
                  print("Returned preferences is " + preferences.user_id.toString());
                  setSignUpPreferences('LOGGED_IN',preferences);
                  return value;
                });

                return insertPreferences;

              }
            });

            return insert_user;
          });
          return delete_user;
        });

        return preferences;
      }

      else{
        return 403;
      }
    }

    on DioError catch(stacktrace){
      print("DIO ERROR:" + stacktrace.response.toString());
      return 500;
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }



  /*Future<dynamic> updateRole(int role_id,Preferences preferences) async{

    print("User id is " + preferences.user!.user_id.toString());
    print("role id is " + role_id.toString());
    try{
         http.Response response = await http.put(Uri.parse(BASE_URL + '/users/${preferences.user!.user_id.toString()}/update-role'),
             headers: {'Accept':'application/json','Authorization':'Bearer ' + preferences.user!.remember_token},
             body: {
            'role_id':role_id.toString()
         });

         print("The response status code is " + response.statusCode.toString());
         log("The user created is " + response.body.toString());
         if(response.statusCode==200){
           var result = jsonDecode(response.body);
           String previous_token = preferences.user!.remember_token;
           User user=User.fromJson(result['user']);
           user.remember_token = previous_token;
          /* if(user.roles.isNotEmpty){
             user.role_id= user.roles.first.id;
           }

           else{
             user.role_id=0;
           }*/


           var db_result = await databaseService.deleteAccount().then((deletedAccount) async{
             int? delete_user = await databaseService.deleteUser().then((value) async{
               int? insert_user = await databaseService.insertUser(user).then((userInserted) async{
                 User? new_user = await databaseService.getUser();
                 if(new_user.user_id!=0){
                   preferences.isLoggedIn=true;
                  // new_user.roles=user.roles;
                   preferences.user=new_user;
                   preferences.user_state= 'LOGGED_IN';
                   preferences.user_id=new_user.user_id;
                   print("The new user id is " + new_user.user_id.toString());

                   int insertPreferences=await databaseService.insertPreference(preferences).then((value) async{
                     preferences= await databaseService.getPreferences(1) ?? preferences;
                     print("Returned preferences is " + preferences.user_id.toString());
                     setSignUpPreferences('LOGGED_IN',preferences);
                     return value;
                   });

                   return insertPreferences;

                 }
               });

               return insert_user;
             });
             return delete_user;
           });

           return preferences;
         }

         else{
           return 403;
         }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }*/

  Future<void> setSignUpPreferences(String state,Preferences preferences) async{
    pref=await _prefs;
    if(pref.containsKey('user_state')){
      pref.remove('user_state');
      pref.setString('user_state', state);
      preferences.user_state=state;
      //print('The state a is ' + pref.getString('user_state'));
    }

    else{
      pref.setString('user_state', state);
      preferences.user_state = state;
      //  print('The state b is ' + pref.getString('user_state'));
    }
  }

  Future<dynamic> verifyEmail(String otp,Preferences preferences) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/email-verification/verify/${otp}'),
        headers: {'accept':'application/json'},);

        log("Verify email is " + response.body.toString());
        print("Verify email status code is " + response.statusCode.toString());
        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          User user=User.fromJson(result['user']);
          user.remember_token = result['token'];

          /*if(user.roles.isNotEmpty){
            user.role_id= user.roles.first.id;
          }

          else{
            user.role_id=0;
          }*/


          var db_result = await databaseService.deleteAccount().then((deletedAccount) async{
            int? delete_user = await databaseService.deleteUser().then((value) async{
              int? insert_user = await databaseService.insertUser(user).then((userInserted) async{
                User? new_user = await databaseService.getUser();
                if(new_user.user_id!=0){
                  preferences.isLoggedIn=true;
                  //new_user.roles=user.roles;
                  preferences.user=new_user;
                  preferences.user_state= 'LOGGED_IN';
                  preferences.user_id=new_user.user_id;
                  print("The new user id is " + new_user.user_id.toString());

                  int insertPreferences=await databaseService.insertPreference(preferences).then((value) async{
                    preferences= await databaseService.getPreferences(1) ?? preferences;
                    setSignUpPreferences('LOGGED_IN',preferences);
                    return value;
                  });

                  return insertPreferences;

                }
              });

              return insert_user;
            });
            return delete_user;
          });

          return preferences;
        }

        else{
          return 403;
        }
    }
    
    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

}