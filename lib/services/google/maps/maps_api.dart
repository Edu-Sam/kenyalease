import 'package:dio/dio.dart';
import '../../../models/module.dart';
import 'dart:convert';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
//import 'package:geocode/geocode.dart';
//import 'package:geocoder/geocoder.dart';

class MapApi{


  Future<List<Place>> getPlaces(String query) async{
    try{
      List<Place> listPlace=[];
      //        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
      String url2 =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${Config.apiKey}&input=${Uri.encodeQueryComponent(query)}";

      Response response = await Dio().get(url2);
      print(response.data.toString());
      listPlace = Place.parseLocationList(response.data);
      // print(listPlace.first.name);
      return listPlace;
    }

    catch(Exception,stacktrace){
      print(stacktrace);
      return [];
    }
  }

  Future<Map<String,dynamic>> decodeLocation(String id) async {
    Map<String,dynamic>? placeLatLng={};
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=${Config.apiKey}&placeid=" +
            Uri.encodeQueryComponent(id);
    //Uri.encodeQueryComponent(query)
    Response? response = await Dio().get(url)
        .then((Response results) async {
      placeLatLng =
      results.data['result']['geometry']['location'];
      //    setState(() {
      //     latitude = double.parse(placeLatLng['lat'].toString());
      //     longitude = double.parse(placeLatLng['lng'].toString());
      //     print('The latitude is ' + latitude.toString());
      //     print('The longitude is ' + longitude.toString());
      //  });
    });

    return placeLatLng!;
  }

  Future<dynamic> getLocationFromCoordinates(double latitude,double longitude) async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      placemarks.forEach((element) {
        print('Placemark name is ' + placemarks.first.name!.toString());
        print('Placemark locality is ' + placemarks.first.locality!.toString());
        print("Placemark " + placemarks.first.administrativeArea!.toString());
        print("Postal code " + placemarks.first.postalCode.toString());
      });

      PropertyLocation propertyLocation = PropertyLocation
        (id: 0, city: placemarks.first.locality ?? '',
          locality: placemarks.first.locality ?? 'N/A',
          landmark_street: placemarks.first.street ?? '',
          property_id: 0,
          address: placemarks.first.name ?? '',
          street_address: placemarks.first.street ?? 'N/A',
          address_line_2: placemarks.first.locality ?? '',
          postal_code: placemarks.first.postalCode ?? 'N/A');

      return propertyLocation;

    //  return placemarks.first.name!.toString();

    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return '';
    }
  }



}