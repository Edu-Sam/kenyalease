

class UserAccountType{
  int id=0;
  int user_id=0;
  int role_id=0;

  UserAccountType({required this.id,required this.user_id,required this.role_id});

  Map<String,dynamic> toJson()=>{
    'user_id':user_id,
    'role_id':role_id
  };

  factory UserAccountType.fromJson(Map<String,dynamic> parsedJson){
    return UserAccountType(
        id: 0,
        user_id: parsedJson['user_id'] ?? 0,
        role_id: parsedJson['role_id'] ?? 0
    );
  }
}