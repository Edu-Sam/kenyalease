import 'module.dart';
class Role{
  int id;
  String firstname;
  String created_at;
  String updated_at;
  UserAccountType? pivot;



  Role({required this.id,required this.firstname,required this.created_at,required this.updated_at,
  this.pivot});

  factory Role.fromJson(Map<String,dynamic> parsedJson){

    UserAccountType? new_pivot;

    if(parsedJson['pivot']!=null){
      new_pivot= UserAccountType.fromJson(parsedJson['pivot']);
    }
    return Role(
      id: parsedJson['id'],
      firstname: parsedJson['firstname'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at'],
      pivot: new_pivot
    );
  }
}