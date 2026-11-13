

class PropertyImage{
  int id=0;
  String file_name='';
  String file_path='';
  String file_type='';
  int is_primary=0;
  int property_id=0;

  PropertyImage({required this.id,required this.file_name,required this.file_path,required this.file_type,
  required this.is_primary,required this.property_id});

  Map<String,dynamic> toJson()=>{
    'file_name':file_name.toString(),
    'file_path':file_path.toString(),
    'file_type':file_type.toString(),
    'is_primary':is_primary.toString(),
    'property_id':property_id.toString()
  };

  factory PropertyImage.fromJson(Map<String,dynamic> parsedJson){
    return PropertyImage(
        id: parsedJson['id'] ?? 0,
        file_name: parsedJson['file_name'] ?? '',
        file_path: parsedJson['file_path'] ?? '',
        file_type: parsedJson['file_type'] ?? '',
        is_primary: parsedJson['is_primary'] ?? 0,
        property_id: parsedJson['property_id'] ?? 0
    );
  }
}