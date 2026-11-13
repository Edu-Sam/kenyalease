import 'module.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Preferences with ChangeNotifier{

  User? user;
  int user_id=0;
  int account_type=0;
  bool isLoggedIn=false;
  int? isReload=0;
  String user_state='';
  String current_account='';
  List<Role> account_role_types=[];
  AppGeoLocation? current_location=AppGeoLocation(long: 0,lat: 0);
  AppGeoLocation? temp_location=AppGeoLocation(long: 0,lat: 0);
  Set<Marker>? markers=Set<Marker>();
  Position? position;
  bool? location_permission=false;
  bool? notification_permission=false;
  bool? camera_permission=false;
  PropertyLocation? tempLocation;


  Preferences({required this.user_id,required this.account_type,required this.isLoggedIn,
    required this.user_state, this.user,required this.account_role_types,this.current_location,
  this.temp_location,this.markers,this.position,this.location_permission,this.notification_permission,
  this.camera_permission,this.tempLocation});

  Map<String,dynamic> toJson()=>{
    'user_id': user!.user_id,
    'account_type':account_type,
    'isLoggedIn':isLoggedIn ? 1 : 0,
    'user_state':user_state
  };

  factory Preferences.fromJson(Map<String,dynamic> parsedJson){
    return Preferences(
        user_id: parsedJson['user_id'],
        account_type: parsedJson['account_type'],
        isLoggedIn: parsedJson['isLoggedIn']==1 ? true : false,
        user_state: '',
        account_role_types: []
    );
  }
}