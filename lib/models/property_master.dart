
class PropertyMaster{
  int id;
  String property_master_name='';
  String property_master_location='';
  String status='';
  String property_listing_type='';
  String created_at='';
  String finished_at='';

  PropertyMaster({required this.id,required this.property_master_name,required this.property_master_location,
  required this.status,required this.created_at,required this.finished_at,required this.property_listing_type});


  Map<String,dynamic> toJson()=>{
  'property_master_name':property_master_name.toString(),
  'property_master_location':property_master_location.toString(),

  };

  factory PropertyMaster.fromJson(Map<String,dynamic> parsedJson){
    return PropertyMaster(
        id: parsedJson['id'] ?? 0,
        property_master_name: parsedJson['property_master_name'] ?? '',
        property_listing_type: parsedJson['property_listing_type'] ?? '',
        property_master_location: parsedJson['property_master_location'] ?? '',
        status: parsedJson['status'] ?? '',
        created_at: parsedJson['created_at'] ?? '',
        finished_at: parsedJson['finished_at'] ?? ''

    );
  }
}