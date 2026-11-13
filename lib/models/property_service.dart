import 'dart:io';

class PropertyService {
  int id = 0;
  String name='';
  String phone = '';
  String email = '';
  String description = '';
  String location_name = '';
  double latitude=0.0;
  double longitude=0.0;
  String images='';
  File? image;
  int somalease_service_id=0;
  int service_provider_id=0;

  PropertyService({required this.id,required this.name,required this.phone,required this.email,
  required this.description,required this.location_name,required this.longitude,required this.latitude,
  required this.images,required this.somalease_service_id,
    required this.service_provider_id
  });

  Map<String,dynamic> parsedJson()=>{
    'name':name.toString(),
    'phone':phone.toString(),
    'email':email.toString(),
    'description':description.toString(),
    'location_name':location_name.toString(),
    'latitude':latitude.toString(),
    'longitude':longitude.toString(),
    'images':images.toString()
  };


  factory PropertyService.fromJson(Map<String,dynamic> parsedJson){
    return PropertyService(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        phone: parsedJson['phone'] ?? '',
        email: parsedJson['email'] ?? '',
        description: parsedJson['description'] ?? '',
        location_name: parsedJson['location_name'] ?? '',
        longitude: parsedJson['longitude'] ?? '',
        latitude: parsedJson['latitude'] ?? '',
        images: parsedJson['images'] ?? '',
        somalease_service_id: parsedJson['somalease_service_id'] ?? 0,
        service_provider_id: parsedJson['service_provider_id'] ?? 0
    );
  }

  factory PropertyService.fetch(Map<String,dynamic> parsedJson){
    return PropertyService(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        phone: parsedJson['phone'] ?? '',
        email: parsedJson['email'] ?? '',
        description: parsedJson['description'] ?? '',
        location_name: parsedJson['location_name'] ?? '',
        longitude: double.parse(parsedJson['longitude']) ?? 0,
        latitude: double.parse(parsedJson['latitude']) ?? 0,
        images: parsedJson['images'] ?? '',
        somalease_service_id: parsedJson['somalease_service_id'] ?? 0,
        service_provider_id: parsedJson['service_provider_id'] ?? 0
    );
  }
}