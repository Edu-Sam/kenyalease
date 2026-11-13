

class StaffRole{
int id=0;
String name='';
int property_id=0;
int user_id=0;
String created_at='';
String updated_at='';


    StaffRole({required this.id,required this.name,required this.property_id,required this.user_id,
    required this.created_at,required this.updated_at});


    factory StaffRole.fromJson(Map<String,dynamic> parsedJson){
      return StaffRole(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        property_id: parsedJson['property_id'] ?? 0,
        user_id: parsedJson['user_id'] ?? 0,
        created_at: parsedJson['created_at'] ?? '',
        updated_at: parsedJson['updated_at'] ?? ''
      );
    }
}