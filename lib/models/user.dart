import 'module.dart';

class User {
  int id=0;
  int user_id=0;
  String firstname='';
  String lastname='';
  String phone='';
  String email='';
  String password='';
  int status=0;
  int email_verified=0;
  String email_verified_at='';
  String email_verification_code='';
  String otp='';
  int role_id=0;
  String remember_token='';
  String created_at='';
  String updated_at='';
  List<Role> roles=[];


  User({required this.id,required this.user_id,
    required this.firstname,required this.lastname,required this.email,required this.phone,
  required this.email_verified,required this.email_verified_at,required this.email_verification_code,
  required this.otp,required this.role_id,required this.remember_token,required this.created_at,
  required this.updated_at,required this.status,required this.roles});

  User.init(){
    id=0;
    user_id=0;
    firstname='';
    lastname='';
    phone='';
    email='';
    remember_token='';
    email_verified_at='';
    otp='';
    created_at='';
    updated_at='';
    email_verified=0;
    role_id=0;
    email_verification_code='';
    status=0;
  }

  Map<String,dynamic> toJson()=>{
    'user_id':user_id,
    'firstname':firstname,
    'lastname':lastname,
    'email':email,
    'phone':phone,
    'email_verified':email_verified,
    'email_verified_at':email_verified_at,
    'email_verification_code':email_verification_code,
    'otp':otp,
    'status':status,
    'remember_token':remember_token,
    'role_id':role_id,
    'created_at':created_at,
    'updated_at':updated_at,

  };

  factory User.fromJson(Map<String,dynamic> parsedJson){

    List<Role> new_roles=[];

    if(parsedJson['roles']!=null){
      var temp_roles=parsedJson['roles'] as List;
      new_roles=temp_roles.map((e) => Role.fromJson(e)).toList();
    }
    return User(
      id: parsedJson['id']  ?? 0,
      user_id: parsedJson['id'] ?? 0,
      firstname: parsedJson['firstname'] ?? '',
      lastname: parsedJson['lastname'] ?? '',
      email: parsedJson['email'] ?? '',
      phone: '',
     // phone: parsedJson['phone'] ?? '',
      email_verified: parsedJson['email_verified']!=null ? parsedJson['email_verified']==true ? 1 : 0 : 0,
      email_verified_at: parsedJson['email_verified_at'] ?? '',
      email_verification_code: parsedJson['email_verification_code'] ?? '',
      otp: parsedJson['otp'] ?? '',
      remember_token: parsedJson['remember_token'] ?? '',
      role_id: parsedJson['role_id'] ?? 0,
      created_at: parsedJson['created_at'] ?? '',
      updated_at: parsedJson['updated_at'] ?? '',
      status: parsedJson['status'] ?? 0,
      roles: new_roles
    );
  }

  factory User.fetch(Map<String,dynamic> parsedJson){

    List<Role> new_roles=[];

    if(parsedJson['roles']!=null){
      var temp_roles=parsedJson['roles'] as List;
      new_roles=temp_roles.map((e) => Role.fromJson(e)).toList();
    }
    return User(
        id: parsedJson['id']  ?? 0,
        user_id: parsedJson['id'] ?? 0,
        firstname: parsedJson['firstname'] ?? '',
        lastname: parsedJson['lastname'] ?? '',
        email: parsedJson['email'] ?? '',
        phone: '',
        // phone: parsedJson['phone'] ?? '',
        email_verified: parsedJson['email_verified']!=null ? parsedJson['email_verified']==true ? 1 : 0 : 0,
        email_verified_at: parsedJson['email_verified_at'] ?? '',
        email_verification_code: parsedJson['email_verification_code'] ?? '',
        otp: parsedJson['otp'] ?? '',
        remember_token: parsedJson['remember_token'] ?? '',
        role_id: int.parse(parsedJson['role_id']) ?? 0,
        created_at: parsedJson['created_at'] ?? '',
        updated_at: parsedJson['updated_at'] ?? '',
        status: parsedJson['status'] ?? 0,
        roles: new_roles
    );
  }

  factory User.fromDB(Map<String,dynamic> parsedJson){
    return User(
        id: parsedJson['id'],
        user_id: parsedJson['user_id'],
        firstname: parsedJson['firstname'] ?? '',
        lastname: parsedJson['lastname'] ?? '',
        phone: parsedJson['phone'] ?? '',
        email: parsedJson['email'] ?? '',
        remember_token: parsedJson['remember_token'] ?? '',
        email_verified_at: parsedJson['email_verified_at'] ?? '',
        otp: parsedJson['otp'] ?? '',
        created_at: parsedJson['created_at'] ?? '',
        updated_at: parsedJson['updated_at'] ?? '',
        email_verified: parsedJson['email_verified'] ?? 0,
        role_id: parsedJson['role_id'] ?? 0,
        email_verification_code: parsedJson['email_verification_code'] ?? '',
        status: parsedJson['status'] ?? 0,
        roles: []
    );
  }

}