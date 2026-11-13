import 'module.dart';

class PropertyLocation {
  int id=0;
  String city='';
  String locality='';
  String landmark_street='';
  int property_id=0;
  String address='';
  String street_address='';
  String address_line_2='';
  String postal_code='';
  AppGeoLocation location=AppGeoLocation(lat: 0,long: 0);

  PropertyLocation({required this.id,required this.city,required this.locality,required this.landmark_street,
  required this.property_id,required this.address,required this.street_address,required this.address_line_2,
  required this.postal_code});

  Map<String,dynamic> toJson()=>{
    'city':city.toString(),
    'locality':locality.toString(),
    'landmark_street':landmark_street.toString(),
    'property_id':property_id.toString()
  };

  factory PropertyLocation.fromJson(Map<String,dynamic> parsedJson){
    return PropertyLocation(
        id: parsedJson['id'] ?? 0,
        property_id: parsedJson['property_id'] ?? 0,
        city: parsedJson['city'] ?? '',
        locality: parsedJson['locality'] ?? '',
        landmark_street: parsedJson['landmark_street'] ?? '',
        address: parsedJson['address'] ?? '',
        street_address: parsedJson['street_address'] ?? '',
        address_line_2: parsedJson['address_line_2'] ?? '',
        postal_code: parsedJson['postal_code'] ?? ''
    );
  }

  factory PropertyLocation.fetch(Map<String,dynamic> parsedJson){
    return PropertyLocation(
        id: parsedJson['id'] ?? 0,
        property_id: int.parse(parsedJson['property_id']) ?? 0,
        city: parsedJson['city'] ?? '',
        locality: parsedJson['locality'] ?? '',
        landmark_street: parsedJson['landmark_street'] ?? '',
        address: parsedJson['address'] ?? '',
        street_address: parsedJson['street_address'] ?? '',
        address_line_2: parsedJson['address_line_2'] ?? '',
        postal_code: parsedJson['postal_code'] ?? ''
    );
  }
}