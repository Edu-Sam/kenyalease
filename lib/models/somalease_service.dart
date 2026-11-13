

class SomaleaseService{
  int id=0;
  String somalease_service_name='';
  int isActive=0;
  String created_at='';
  String updated_at='';
  String image='';


  SomaleaseService({required this.id,required this.somalease_service_name,required this.isActive,
  required this.created_at,required this.updated_at,required this.image});

  Map<String,dynamic> toJson()=>{
    'somalease_service_name':somalease_service_name.toString()
  };

  factory SomaleaseService.fromJson(Map<String,dynamic> parsedJson){
    return SomaleaseService(
      id: parsedJson['id'],
      somalease_service_name: parsedJson['somalease_service_name'],
      isActive: parsedJson['isActive'],
      created_at: parsedJson['created_at'] ?? '',
      updated_at: parsedJson['updated_at'] ?? '',
      image: parsedJson['image'] ?? ''

    );
  }
}