import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/module.dart';
import '../auth/module.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';


class PropertyRepository {
  static const String BASE_URL= DomainServer.name;
  static const String DOMAIN=DomainServer.domain;
  static const String PATH=DomainServer.domain_path;

  Future<dynamic> addPropertyMaster(PropertyMaster propertyMaster,String token) async{
    print("token is " + token.toString());
    try{
        http.Response response = await http.post(Uri.parse(BASE_URL + '/properties-masters'),
        headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //body: json.encode(propertyMaster.toJson())
          body: {
            'property_master_name':propertyMaster.property_master_name.toString(),
            'property_master_location':propertyMaster.property_master_location.toString(),
            'property_listing_type':propertyMaster.property_listing_type.toString()
          }
        );

        print("The property master code is " + response.statusCode.toString());
        log("The property master response is " + response.body.toString());
        if(response.statusCode==201){
          var result = jsonDecode(response.body);
          PropertyMaster propertyMaster = PropertyMaster.fromJson(result['data']);
          return propertyMaster;
        }

        else{
          return response.statusCode;
        }
    }
    
    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updatePropertyMaster(PropertyMaster propertyMaster,String token) async{
    try{
      http.Response response = await http.put(Uri.parse(BASE_URL + '/properties-masters/${propertyMaster.id.toString()}'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //body: json.encode(propertyMaster.toJson())
          body: {
            'property_master_name':propertyMaster.property_master_name.toString(),
            'property_master_location':propertyMaster.property_master_location.toString(),
            'property_listing_type':propertyMaster.property_listing_type.toString()
          }
      );

      print("The property master code is " + response.statusCode.toString());
      log("The property master response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyMaster propertyMaster = PropertyMaster.fromJson(result['data']);
        return propertyMaster;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addProperty(Property property,String token,int user_id) async{
    print("The property master id is " + property.property_master_id.toString());
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/properties'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
         // body: json.encode(property.toJson())
        body: {
          'apartment_type':property.apartment_type.toString(),
          'bhk_type':property.bhk_type.toString(),
          'user_id':user_id.toString(),
          'property_name':property.property_name.toString(),
          'property_price':property.property_price.toString(),
          'no_of_bedroom':property.no_of_bedrooms.toString(),
          'no_of_bathroom':property.no_of_bathrooms.toString(),
          'balcony':property.balcony.toString(),
          'possession':property.possession.toString(),
          'power_backup':property.power_backup.toString(),
          //'landlord_id':landlord_id,
          'property_master_id':property.property_master_id.toString()
        }
      );

      print("The property  code is " + response.statusCode.toString());
      log("The property  response is " + response.body.toString());
      if(response.statusCode==201){
        var result = jsonDecode(response.body);
        Property property = Property.fromJson(result['data']);
        return property;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updateProperty(Property property,String token,int user_id) async{
    print("The property master id is " + property.property_master_id.toString());
    try{
      http.Response response = await http.put(Uri.parse(BASE_URL + '/properties/${property.id}'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          // body: json.encode(property.toJson())
          body: {
            'apartment_type':property.apartment_type.toString(),
            'bhk_type':property.bhk_type.toString(),
            'user_id':user_id.toString(),
            'property_name':property.property_name.toString(),
            'property_price':property.property_price.toString(),
            'no_of_bedroom':property.no_of_bedrooms.toString(),
            'no_of_bathroom':property.no_of_bathrooms.toString(),
            'balcony':property.balcony.toString(),
            'possession':property.possession.toString(),
            'power_backup':property.power_backup.toString(),
         //   'landlord_id':landlord_id,
            'property_master_id':property.property_master_id.toString()
          }
      );

      print("The property update  code is " + response.statusCode.toString());
      log("The property update response is " + response.body.toString());
      if(response.statusCode==200){
      //  return response.statusCode;
        var result = jsonDecode(response.body);
        Property property = Property.fetch(result['data']);
        return property;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addPropertyDescription(PropertyDescription propertyDescription,String token) async{
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/properties/property-descriptions'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
        //  body: json.encode(propertyDescription.toJson())
        body: {
          'description':propertyDescription.description.toString(),
          'property_id':propertyDescription.property_id.toString(),
          'carpet_rea': propertyDescription.carpet_area.toString(),
          'availability_date': propertyDescription.availability_date.toString(),
          'electricity': propertyDescription.electricity.toString(),
          'gym': propertyDescription.gym.toString(),
          'non_veg_allowed': propertyDescription.non_veg_allowed.toString(),
          'preferred_tenant': propertyDescription.preferred_tenant.toString(),
          'service_charge': propertyDescription.service_charge.toString(),
          'service_charge_fee': propertyDescription.service_charge_fee.toString(),
          'water_supply': propertyDescription.water_supply.toString(),
          'other_amenities': propertyDescription.other_amenities.toString()
        }
      );

      print("The property description code is " + response.statusCode.toString());
      log("The property description response is " + response.body.toString());
      if(response.statusCode==201){
        var result = jsonDecode(response.body);
        PropertyDescription propertyDescription = PropertyDescription.fetch(result['data']);
        return propertyDescription;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updatePropertyDescription(PropertyDescription propertyDescription,String token) async{
    try{
      http.Response response = await http.put(Uri.parse(BASE_URL + '/property-descriptions/${propertyDescription.id}'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //  body: json.encode(propertyDescription.toJson())
          body: {
            'description':propertyDescription.description.toString(),
            'property_id':propertyDescription.property_id.toString(),
            'carpet_rea': propertyDescription.carpet_area.toString(),
            'availability_date': propertyDescription.availability_date.toString(),
            'electricity': propertyDescription.electricity.toString(),
            'gym': propertyDescription.gym.toString(),
            'non_veg_allowed': propertyDescription.non_veg_allowed.toString(),
            'preferred_tenant': propertyDescription.preferred_tenant.toString(),
            'service_charge': propertyDescription.service_charge.toString(),
            'service_charge_fee': propertyDescription.service_charge_fee.toString(),
            'water_supply': propertyDescription.water_supply.toString(),
            'other_amenities': propertyDescription.other_amenities.toString()
          }
      );

      print("The property description code is " + response.statusCode.toString());
      log("The property description response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyDescription propertyDescription = PropertyDescription.fetch(result['data']);
        return propertyDescription;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addPropertyOverview(PropertyOverview propertyOverview,String token) async{
    try{
      print("Rent or lease " + propertyOverview.expected_availability.toString());
      http.Response response = await http.post(Uri.parse(BASE_URL + '/properties/property-overviews'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
       //   body: json.encode(propertyOverview.toJson())
        body: {
          'age_of_building':propertyOverview.age_of_building.toString(),
          'total_floor':propertyOverview.total_floor.toString(),
          'plot_area':propertyOverview.plot_area.toString(),
          'facing':propertyOverview.facing.toString(),
          'ownership_type':propertyOverview.ownership_type.toString(),
          'builtup_area':propertyOverview.builtup_area.toString(),
          'floor':propertyOverview.floor.toString(),
          'gated_security':propertyOverview.gated_security.toString(),
          'property_id':propertyOverview.property_id.toString(),
          'furnishing_status':propertyOverview.furnishing_status.toString(),
          'parking':propertyOverview.parking.toString(),
          'rent_or_lease':propertyOverview.expected_availability.toString(),
          'rent_amount':propertyOverview.expected_rent.toString(),
          'expected_deposit':propertyOverview.expected_deposit.toString(),
          'rent_negotiable':propertyOverview.rent_negotiable.toString()
        }
      );

      print("The property overview code is " + response.statusCode.toString());
      log("The property overview response is " + response.body.toString());
      if(response.statusCode==201){
        var result = jsonDecode(response.body);
        PropertyOverview propertyOverview = PropertyOverview.fetch(result['data']);
        return propertyOverview;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updatePropertyOverview(PropertyOverview propertyOverview,String token) async{
    try{
      print("Rent or lease " + propertyOverview.expected_availability.toString());
      http.Response response = await http.put(Uri.parse(BASE_URL + '/property-overviews/${propertyOverview.id}'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //   body: json.encode(propertyOverview.toJson())
          body: {
            'age_of_building':propertyOverview.age_of_building.toString(),
            'total_floor':propertyOverview.total_floor.toString(),
            'plot_area':propertyOverview.plot_area.toString(),
            'facing':propertyOverview.facing.toString(),
            'ownership_type':propertyOverview.ownership_type.toString(),
            'builtup_area':propertyOverview.builtup_area.toString(),
            'floor':propertyOverview.floor.toString(),
            'gated_security':propertyOverview.gated_security.toString(),
            'property_id':propertyOverview.property_id.toString(),
            'furnishing_status':propertyOverview.furnishing_status.toString(),
            'parking':propertyOverview.parking.toString(),
            'rent_or_lease':propertyOverview.expected_availability.toString(),
            'rent_amount':propertyOverview.expected_rent.toString(),
            'expected_deposit':propertyOverview.expected_deposit.toString(),
            'rent_negotiable':propertyOverview.rent_negotiable.toString()
          }
      );

      print("The property overview code is " + response.statusCode.toString());
      log("The property overview response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyOverview propertyOverview = PropertyOverview.fetch(result['data']);
        return propertyOverview;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addPropertyImage(File? new_image,int property_id,String token) async{
    try{
        print("The property id is " + property_id.toString());
      Map<String,String> headers={"Accept":"application/json",'Authorization':'Bearer ' + token};
      var response=http.MultipartRequest('POST',Uri.parse(BASE_URL + '/properties/property-images'),)
        ..headers.addAll(headers)
        ..fields['property_id']=property_id.toString();



      if(new_image!=null){
        response.files.add(http.MultipartFile('file',File.fromUri(Uri.parse(new_image.path)).readAsBytes().asStream(),
            await File.fromUri(Uri.parse(new_image.path)).length(),
            filename: new_image.path.split('/').last
        ));

      }

      else{
        print("image is null");
      }


      http.StreamedResponse userResponse=await response.send();
      final res=await userResponse.stream.bytesToString();


      print("status code response is " + userResponse.statusCode.toString());
      print("image  response is " + res);
      if(userResponse.statusCode==201){
        return userResponse.statusCode;
      }

      else{
        return userResponse.statusCode;
      }
    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addPropertyLocation(PropertyLocation propertyLocation,String token) async{
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/properties/property-locations'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
        //  body: json.encode(propertyLocation.toJson())
        body: {
          'city':propertyLocation.city.toString(),
          'locality':propertyLocation.locality.toString(),
          'landmark_street':propertyLocation.landmark_street.toString(),
          'property_id':propertyLocation.property_id.toString(),
          'address': propertyLocation.address.toString(),
          'street_address': propertyLocation.street_address.toString(),
          'address_line_2': propertyLocation.address_line_2.toString(),
          'postal_code': propertyLocation.postal_code.toString(),
        }
      );

      print("The property location code is " + response.statusCode.toString());
      log("The property location response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyLocation propertyLocation = PropertyLocation.fromJson(result['data']);
        return propertyLocation;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> updatePropertyLocation(PropertyLocation propertyLocation,String token) async{
    try{
      http.Response response = await http.put(Uri.parse(BASE_URL + '/property-locations/${propertyLocation.id}'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //  body: json.encode(propertyLocation.toJson())
          body: {
            'city':propertyLocation.city.toString(),
            'locality':propertyLocation.locality.toString(),
            'landmark_street':propertyLocation.landmark_street.toString(),
            'property_id':propertyLocation.property_id.toString(),
            'address': propertyLocation.address.toString(),
            'street_address': propertyLocation.street_address.toString(),
            'address_line_2': propertyLocation.address_line_2.toString(),
            'postal_code': propertyLocation.postal_code.toString(),
          }
      );

      print("The property location code is " + response.statusCode.toString());
      log("The property location response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyLocation propertyLocation = PropertyLocation.fetch(result['data']);
        return propertyLocation;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }
  //properties/landlords/{landlordId}
  Future<dynamic> getProperties(String token) async{
    try{
        http.Response response = await http.get(Uri.parse(BASE_URL + '/properties'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
        );

        print("Get properties response code is " + response.statusCode.toString());
        log("Get properties response is " + response.body.toString());
        if(response.statusCode==200){
          var result = jsonDecode(response.body);
          var properties_temp = result['data'] as List;
          List<Property> properties = properties_temp.map((e) => Property.fromDetails(e)).toList();
          return properties;
        }

        else{
          return response.statusCode;
        }
    }
    
    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> getPropertyById(String token,int propertyId) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL + '/properties/${propertyId.toString()}'),
        headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
      );

      print("Get properties response code is " + response.statusCode.toString());
      log("Get properties response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        Property property = Property.fromDetails(result['data']);
        return property;
       // var properties_temp = result['data'] as List;
       // List<Property> properties = properties_temp.map((e) => Property.fromDetails(e)).toList();
       // return properties;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> getPropertiesByLandlordID(String token,int landlordId) async{
    try{
      http.Response response = await http.get(Uri.parse(BASE_URL + '/properties/landlords/${landlordId.toString()}'),
        headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
      );

      print("Get properties landlord response code is " + response.statusCode.toString());
      log("Get properties landlord response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        var properties_temp = result['data'] as List;
        List<Property> properties = properties_temp.map((e) => Property.fromDetails(e)).toList();
        return properties;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> addPropertyDays(PropertyDay propertyDay,String token) async{
    try{
      http.Response response = await http.post(Uri.parse(BASE_URL + '/properties/property-days'),
          headers:  {'Accept':'application/json','Authorization':'Bearer ' + token},
          //  body: json.encode(propertyLocation.toJson())
          body: {
            'viewing_day':propertyDay.viewing_day.toString(),
            'from_time':propertyDay.from_time.toString(),
            'to_time':propertyDay.to_time.toString(),
            'contact_person':propertyDay.contact_person.toString(),
            "phone":propertyDay.phone.toString(),
            'property_id':propertyDay.property_id.toString()
          }
      );

      print("The property day code is " + response.statusCode.toString());
      log("The property day response is " + response.body.toString());
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
        PropertyDay propertyDay = PropertyDay.fromJson(result['data']);
        return propertyDay;
      }

      else{
        return response.statusCode;
      }
    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return 500;
    }
  }
}