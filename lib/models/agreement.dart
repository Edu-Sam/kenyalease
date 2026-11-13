
import 'package:file_picker/file_picker.dart';

class Agreement {
  int id=0;
  int property_id=0;
  int tenant_id=0;
  String agreement_description='';
  String start_date='';
  String end_date='';
  PlatformFile? file;
  int landlord_id=0;
  String file_path='';
  int accepted=0;
  String signature='';
  String created_at='';
  String updated_at='';

  Agreement({required this.id,required this.property_id,required this.agreement_description,required this.start_date,required this.end_date,
  required this.tenant_id});
  Agreement.detail({required this.id,required this.property_id,required this.landlord_id,required this.tenant_id,
  required this.agreement_description,required this.start_date,required this.end_date,required this.file_path,
  required this.accepted,required this.created_at,required this.updated_at});

  Map<String,dynamic> toJson()=>{

  };

  factory Agreement.fromJson(Map<String,dynamic> parsedJson){
    return Agreement(
        id: parsedJson['id'],
        property_id: parsedJson['property_id'] ?? 0,
        tenant_id: parsedJson['tenant_id'] ?? 0,
        agreement_description: parsedJson['agreement_description'] ?? '',
        start_date: parsedJson['start_date'] ?? '',
        end_date: parsedJson['end_date'] ?? '') ;
  }

  factory Agreement.fetch(Map<String,dynamic> parsedJson){
    return Agreement(
        id: parsedJson['id'],
        property_id: int.parse(parsedJson['property_id']) ?? 0,
        tenant_id: int.parse(parsedJson['tenant_id']) ?? 0,
        agreement_description: parsedJson['agreement_description'] ?? '',
        start_date: parsedJson['start_date'] ?? '',
        end_date: parsedJson['end_date'] ?? '') ;
  }

  factory Agreement.fromDetail(Map<String,dynamic> parsedJson){
    return Agreement.detail(
        id: parsedJson['id'] ?? 0,
        property_id: parsedJson['property_id'] ?? 0,
        landlord_id: parsedJson['landlord_id'] ?? 0,
        tenant_id: parsedJson['tenant_id'] ?? 0,
        agreement_description: parsedJson['agreement_description'] ?? 0,
        start_date: parsedJson['start_date'] ?? '',
        end_date: parsedJson['end_date'] ?? '',
        file_path: parsedJson['file_path'] ?? '',
        accepted: parsedJson['accepted']  ?? 0,
        created_at: parsedJson['created_at']  ?? '',
        updated_at: parsedJson['updated_at'] ?? '');
  }


}