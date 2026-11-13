import 'module.dart';

class Property {
  int id=0;
  String apartment_type='';
  String bhk_type='';
  String property_name='';
  String property_price='';
  String no_of_bedrooms='0';
  String no_of_bathrooms='0';
  String balcony='0';
  String possession='';
  String power_backup='';
  int landlord_id=0;
  int property_master_id=0;
  List<PropertyOverview> property_overviews=[];
  List<PropertyDescription> property_description=[];
  List<PropertyLocation> property_location = [];
  List<PropertyImage> property_image=[];
  List<PropertyDay> property_days=[];
  PropertyMaster? propertyMaster;

    Property({required this.id,required this.apartment_type,required this.bhk_type,required this.property_name,
    required this.property_price,required this.no_of_bedrooms,required this.no_of_bathrooms,
    required this.balcony,required this.possession,required this.power_backup,required this.landlord_id,
    required this.property_master_id});

    Property.details({required this.id,required this.apartment_type,required this.bhk_type,required this.property_name,
  required this.property_price,required this.no_of_bedrooms,required this.no_of_bathrooms,
  required this.balcony,required this.possession,required this.power_backup,required this.landlord_id,
  required this.property_master_id,required this.property_overviews,required this.property_description,
    required this.property_location,required this.property_image,required this.property_days,
    required this.propertyMaster});


    Map<String,dynamic> toJson()=>{
      'apartment_type':apartment_type.toString(),
      'bhk_type':bhk_type.toString(),
      'property_name':property_name.toString(),
      'property_price':property_price.toString(),
      'no_of_bedroom':no_of_bedrooms.toString(),
      'no_of_bathroom':no_of_bathrooms.toString(),
      'balcony':balcony.toString(),
      'possession':possession.toString(),
      'power_backup':power_backup.toString(),
      //'landlord_id':landlord_id,
      'property_master_id':property_master_id.toString()

    };
    factory Property.fromJson(Map<String,dynamic> parsedJson){
      return Property(
          id: parsedJson['id'],
          bhk_type: parsedJson['bhk_type'] ?? '',
          apartment_type: parsedJson['apartment_type'] ?? '',
          property_name: parsedJson['property_name'] ?? '',
          property_price: parsedJson['property_price'] ?? '',
          no_of_bedrooms: parsedJson['no_of_bedroom'] ?? '',
          no_of_bathrooms: parsedJson['no_of_bathroom'] ?? '',
          balcony: parsedJson['balcony'] ?? '',
          possession: parsedJson['possession'] ?? '',
          power_backup: parsedJson['power_backup'] ?? '',
          landlord_id: parsedJson['landlord_id'] ?? 0,
          property_master_id: parsedJson['property_master_id'] ?? 0
      );
    }

  factory Property.fetch(Map<String,dynamic> parsedJson){
    return Property(
        id: parsedJson['id'],
        bhk_type: parsedJson['bhk_type'] ?? '',
        apartment_type: parsedJson['apartment_type'] ?? '',
        property_name: parsedJson['property_name'] ?? '',
        property_price: parsedJson['property_price'] ?? '',
        no_of_bedrooms: parsedJson['no_of_bedroom'] ?? '',
        no_of_bathrooms: parsedJson['no_of_bathroom'] ?? '',
        balcony: parsedJson['balcony'] ?? '',
        possession: parsedJson['possession'] ?? '',
        power_backup: parsedJson['power_backup'] ?? '',
        landlord_id: parsedJson['landlord_id'] ?? 0,
        property_master_id: int.parse(parsedJson['property_master_id']) ?? 0
    );
  }

    factory Property.fromDetails(Map<String,dynamic> parsedJson){

      List<PropertyOverview> new_property_overviews=[];
      List<PropertyDescription> new_property_descriptions=[];
      List<PropertyLocation> new_property_locations=[];
      List<PropertyImage> new_property_image=[];
      List<PropertyDay> new_property_days=[];
      PropertyMaster? new_property_master;
      //property_days

      if(parsedJson['property_overview']!=null){
        var property_overview_temp = parsedJson['property_overview'] as List;
        new_property_overviews = property_overview_temp.map((e) => PropertyOverview.fromJson(e)).toList();
      }

      if(parsedJson['property_description']!=null){
        var property_description_temp = parsedJson['property_description'] as List;
        new_property_descriptions = property_description_temp.map((e) => PropertyDescription.fromJson(e)).toList();
      }

      if(parsedJson['property_location']!=null){
        var property_location_temp = parsedJson['property_location'] as List;
        new_property_locations = property_location_temp.map((e) => PropertyLocation.fromJson(e)).toList();
      }

      if(parsedJson['property_images']!=null){
        var property_images_temp = parsedJson['property_images'] as List;
        new_property_image = property_images_temp.map((e) => PropertyImage.fromJson(e)).toList();
      }

      if(parsedJson['property_days']!=null){
        var property_days_temp= parsedJson['property_days'] as List;
        new_property_days=property_days_temp.map((e) => PropertyDay.fromJson(e)).toList();
      }

      if(parsedJson['property_master']!=null){
       new_property_master=PropertyMaster.fromJson(parsedJson['property_master']);

      }

      return Property.details(
          id: parsedJson['id'],
          bhk_type: parsedJson['bhk_type'] ?? '',
          apartment_type: parsedJson['apartment_type'] ?? '',
          property_name: parsedJson['property_name'] ?? '',
          property_price: parsedJson['property_price'] ?? '',
          no_of_bedrooms: parsedJson['no_of_bedroom'].toString() ?? '',
          no_of_bathrooms: parsedJson['no_of_bathroom'].toString() ?? '',
          balcony: parsedJson['balcony'].toString() ?? '',
          possession: parsedJson['possession'] ?? '',
          power_backup: parsedJson['power_backup'] ?? '',
          landlord_id: parsedJson['landlord_id'] ?? 0,
          property_master_id: parsedJson['property_master_id'] ?? 0,
          property_overviews: new_property_overviews,
          property_description: new_property_descriptions,
          property_location: new_property_locations,
          property_image: new_property_image,
          property_days: new_property_days,
          propertyMaster: new_property_master
      );
    }
}