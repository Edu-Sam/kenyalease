import 'module.dart';

class Staff{

  int id=0;
  String name='';
  String email='';
  int property_id=0;
  int role_id=0;
  String created_at='';
  String updated_at='';
  StaffRole? staffRole;
  Property? property;

     Staff({required this.id,required this.name,required this.email,required this.property_id,
     required this.role_id});
     Staff.detail({required this.id,required this.name,required this.email,required this.property_id,
     required this.role_id,required this.staffRole,required this.property,
     required this.created_at,required this.updated_at});

     factory Staff.fromJson(Map<String,dynamic> parsedJson){
       return Staff(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        email: parsedJson['email'] ?? '',
        property_id: parsedJson['property_id'] ?? 0,
        role_id: parsedJson['role_id'] ?? 0
       );
     }

     factory Staff.fromDetail(Map<String,dynamic> parsedJson){
       StaffRole? new_staff_role;
       Property? new_property;

       if(parsedJson['role']!=null){
         new_staff_role = StaffRole.fromJson(parsedJson['role']);
       }

       if(parsedJson['property']!=null){
         new_property=Property.fromDetails(parsedJson['property']);
       }
       return Staff.detail(
           id: parsedJson['id'] ?? 0,
           name: parsedJson['name'] ?? '',
           email: parsedJson['email'] ?? '',
           property_id: parsedJson['property_id'] ?? 0,
           role_id: parsedJson['role_id'] ?? 0,
           staffRole: new_staff_role,
           property: new_property,
           created_at: parsedJson['created_at'] ?? '',
           updated_at: parsedJson['updated_at'] ?? '');
     }

}