import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'google_maps_wrapper.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import '../../services/module.dart';
import 'map_field_container.dart';
//import 'package:amaizi/services/google/maps/maps_api.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';


class MapContainer extends StatefulWidget{
  MapContainer({Key? key,this.searchController,required this.isMap,
    required this.onTap,required this.isLocationChosen,required this.type,/*this.address,*/
    required this.isAbsorbPointer,this.new_location_selected,required this.onCurrentLocation,
    required this.currentLocation}) : super(key: key);
  TextEditingController? searchController;
  bool isMap;
  Function(bool) onTap;
  bool isAbsorbPointer;
  bool isLocationChosen;
  int type;
  //Address? address;
  bool? new_location_selected;
  Function(bool) onCurrentLocation;
  bool currentLocation;


  @override
  _MapContainerState createState()=> _MapContainerState();
}

class _MapContainerState extends State<MapContainer>{

  MapApi mapApi=MapApi();
  List<Place> listPlace = [];
  Map<String,dynamic>? selectedLocation;
  Widget? mapWidget;

  LatLng? initial_position;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  MarkerId markerId = MarkerId('home');
  int counter=0;
  double bottom_container_height=0.0;
  BitmapDescriptor? bitMapIcon;
  double main_latitude=0.0,main_longitude=0.0;
  BitmapDescriptor? marker_icon;
  String search_area_or_street_tag='Search Area or Street';
  bool onCurrentLocation=true;






  Completer<GoogleMapController> _controller = Completer();
  // Completer<GoogleMapController> _controller;


  AppGeoLocation new_location= AppGeoLocation(lat: 0.0,long: 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        //checkIsMap() ?
        Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
            child: GoogleMapsWrapper(isMap: checkIsMap(),
              isAbsorbPointer: checkIsAbsorbPointer(),
              markers: Provider.of<Preferences>(context,listen: false).markers!,
              //  markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! : Set<Marker>(),
              latitude:Provider.of<Preferences>(context,listen: false).position!.latitude,
              longitude:Provider.of<Preferences>(context,listen: false).position!.longitude,controller: _controller,
              onMapSelected: (){
                print("Is here location");
                chooseLocation(selectedLocation!);
              },
              onUpdatePosition: (camPosition){
                // _cameraMoving(camPosition);
                _updatePosition(camPosition);
              },

              onCameraMoveStarted: (){
                print("camera started");
                onCameraMoveStarted();
              },
              onCameraIdle: (completer) async{
                // GoogleMapController idleController=await completer.future;
                print("Here camera");
                onCameraIdle(completer);
              },
            )
        ),/*: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
            child: mapWidget
        ),*/
        checkIsMap() ?
        Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    //    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MapFieldContainer(
                          controller: widget.searchController!,
                          prefixIcon: Icon(Icons.search,color: AppConstants.thirdColor,),
                          onTap: (){

                          },
                          onClear: (){
                            setState(() {
                              listPlace.clear();
                              listPlace = [];
                              widget.searchController!.text='';
                            });
                          },
                          onChange: (text){
                            if (text.length > 0) {
                              //listPlace=getPlaces(text);
                              setState(() {
                                getPlaces(text);
                              });
                            } else if (text.length ==0 || text.isEmpty) {
                              setState(() {
                                // selectedLocation=null;
                                listPlace.clear();
                                listPlace = [];
                                widget.searchController!.text='';
                                //   location='';

                              });
                            }
                          },
                          hintText: search_area_or_street_tag,
                        ),

                      ],
                    ),
                  ),
                ),
                listPlace.length > 0
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                  child: Container(
                    height:
                    MediaQuery.of(context).size.height *
                        .30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: AppConstants.thirdColor),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 5),
                                  child: Text(
                                    listPlace[index].name !=
                                        null
                                        ? listPlace[index]
                                        .name!
                                        : '',
                                    overflow:
                                    TextOverflow.fade,
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  .90,
                              child: Text(
                                listPlace[index]
                                    .formattedAddress !=
                                    null
                                    ? listPlace[index]
                                    .formattedAddress!
                                    : ' ',
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ),
                            onTap: () async{
                              /* widget.onTap(false,listPlace[index]);
                              setState(() {
                                listPlace.clear();
                                listPlace = [];
                              });*/
                              selectedLocation=await decodeLocation(
                                  listPlace[index]
                                      .locationId!);
                              setState(() {


                                widget.searchController!.text =
                                listPlace[index].name!;
                                _changePosition(selectedLocation!['lat'], selectedLocation!['lng']);
                                listPlace.clear();
                                listPlace = [];
                                /*widget.isMap=false;
                                widget.onTap(false);
                                _getSelectedLocation();*/

                              });
                            },
                          );
                        },
                        separatorBuilder:
                            (context, index) => Padding(
                          padding:
                          const EdgeInsets.only(
                              left: 10,
                              right: 10),
                          child: Divider(
                              height: 1,
                              color: AppConstants.thirdColor
                          ),
                        ),
                        itemCount: listPlace.length

                    ),
                  ),
                )
                    : Container(),
              ],
            )
        ) : Container(),
      ],
    );
  }

  Future<List<Place>> getPlaces(String query) async{
    listPlace=await mapApi.getPlaces(query);
    return listPlace;
  }

  Future<Map<String,dynamic>> decodeLocation(String id) async{
    Map<String,dynamic> result=await mapApi.decodeLocation(id);
    return result;
  }


  void _getCurrentLocation() async {

    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      Provider.of<Preferences>(context,listen: false).position = res;
      print("Fetching current location");
      print("The latitude is " + res.latitude.toString() + ' ' + 'the longitude is ' + res.longitude.toString());
      Position position=Provider.of<Preferences>(context,listen: false).position!;
      _createMarker(res.latitude, res.longitude, markerId, 'Current Location');
      print("The current checkIsMap is " + checkIsMap().toString());
      /*mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
        isAbsorbPointer: checkIsAbsorbPointer(),
         markers: Provider.of<Preferences>(context,listen: false).markers!,
      //  markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! : Set<Marker>(),
        latitude:res.latitude,longitude:res.longitude,controller: _controller,
        onMapSelected: (){
          print("Is here location");
          chooseLocation(selectedLocation!);
        },
        onUpdatePosition: (camPosition){
          // _cameraMoving(camPosition);
          _updatePosition(camPosition);
        },

        onCameraMoveStarted: (){
        print("camera started");
          onCameraMoveStarted();
        },
        onCameraIdle: (completer) async{
          // GoogleMapController idleController=await completer.future;
          print("Here camera");
          onCameraIdle(completer);
        },
      );*/
    });
  }

  Future<void> onCameraIdle(Completer<GoogleMapController> completer) async{
    try{
      GoogleMapController googleMapController=await completer.future;
      LatLngBounds visibleRegion = await googleMapController.getVisibleRegion();
      LatLng centerLatLng = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
        (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,);
      selectedLocation=Map<String,dynamic>();
      selectedLocation!['lat']=centerLatLng.latitude;
      selectedLocation!['lng']=centerLatLng.longitude;
      print("The idle lat is " + centerLatLng.toString() + 'the idle lng is ' + centerLatLng.longitude.toString());

      widget.searchController!.text=await setLocationName(centerLatLng.latitude,centerLatLng.longitude);
      /*setState(() {
        Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
        Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId==markerId);



      });

      Marker marker=Marker(
          markerId: markerId,
          icon: bitMapIcon!,
          infoWindow: const InfoWindow(title: 'Home'));
      Provider.of<Preferences>(context,listen: false).markers!.add(marker.copyWith(
          positionParam: LatLng(centerLatLng.latitude, centerLatLng.longitude)
      ));  */
      setState(() {
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(centerLatLng.latitude, centerLatLng.longitude),),);

       /* Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
        removeSelectedMarkers();
        Provider.of<Preferences>(context,listen: false).markers!.add(marker.copyWith(
            positionParam: LatLng(centerLatLng.latitude, centerLatLng.longitude)
        ));*/

      });


      /*mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
        isAbsorbPointer: checkIsAbsorbPointer(),
        markers: Provider.of<Preferences>(context,listen: false).markers!,
        latitude:centerLatLng.latitude,longitude: centerLatLng.longitude,controller: _controller,onUpdatePosition: (camPosition){

        },
        onCameraIdle: (completer) async{

             onCameraIdle(completer);
        },
      );*/
    }

    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());

    }

  }

  void onCameraMoveStarted(){
    updateCurrentLocation(false);
    setState(() {
      Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId
          ==markerId);
      Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
    });
  }

  void _updatePosition(CameraPosition _position) async{
    updateCurrentLocation(false);
    setState(() {
      Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId
          ==markerId);
      Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
    });
    /* Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    Marker marker = markers[markerId];
    GoogleMapController controller=await _controller.future;

    setState(() {
      markers[markerId] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 270.0,
            target: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),
            tilt: 30.0,
            zoom: 17.0,
          ),
        ),
      );


    });*/

  }

  _cameraMoving(CameraPosition position) async{
    Position newMarkerPosition = Position(latitude: position.target.latitude, longitude: position.target.longitude
        ,accuracy: 0,
        altitude: 0,heading: 0,speed: 0,speedAccuracy: 0,floor: 9,isMocked: false,timestamp: DateTime.now());
    main_latitude=position.target.latitude;
    main_longitude=position.target.longitude;
    // Marker marker = markers[markerId];
    Marker marker=Provider.of<Preferences>(context,listen: false).markers!.firstWhere((element) =>
    element.markerId==markerId);
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    GoogleMapController controller=await _controller.future;

    setState(() {
      /*markers[markerId] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));*/





      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),),);

      /*Provider.of<Preferences>(context,listen: false).markers.remove(markerId);
      Provider.of<Preferences>(context,listen: false).markers.add(marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude)
      ));*/
      Provider.of<Preferences>(context,listen: false).markers!.add(Marker(
        markerId: markerId,
        position: LatLng(main_latitude, main_longitude),
        //icon: BitmapDescriptor.defaultMarker,
        icon:bitMapIcon!,
        infoWindow: const InfoWindow(title: ''),

      ));

      /* Provider.of<Preferences>(context,listen: false).markers.add(marker.copyWith(
        anchorParam: newAnchor,));*/

    });

  }

  Set<Marker> _createMarker(double latitude,double longitude,MarkerId marker_id,String title) {
    //Position position=Provider.of<Preferences>(context,listen: false).position;

    Provider.of<Preferences>(context,listen: false).markers!.add(
      Marker(
          markerId: marker_id,
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarker,
          //     icon: bitMapIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: title)),
    );

    return Provider.of<Preferences>(context,listen: false).markers!;
  }

  bool checkIsMap(){
    if(widget.isMap){
      return true;
    }

    else{
      return false;
    }
  }

  bool checkIsAbsorbPointer(){
    print("The absorb pointer is " + widget.isAbsorbPointer.toString());
    if(widget.isAbsorbPointer){
      return true;
    }

    else{
      return false;
    }
  }

  void _changePosition(double latitude,double longitude) async{
    Position newMarkerPosition = Position(
        latitude: latitude,
        longitude: longitude,accuracy: 0,
        altitude: 0,heading: 0,speed: 0,speedAccuracy: 0,floor: 9,isMocked: false,timestamp: DateTime.now()
    );
    removeSelectedMarkers();
    print("OR here");
    _createMarker(latitude, longitude, markerId, 'Home');
    Marker marker=Provider.of<Preferences>(context,listen: false).markers!.firstWhere((element) =>
    element.markerId==markerId);
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    GoogleMapController controller=await _controller.future;

    setState(() {
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),),);

      Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
      //Provider.of<Preferences>(context,listen: false).markers.removeWhere((element) => element.markerId==markerId);
      removeSelectedMarkers();
      Provider.of<Preferences>(context,listen: false).markers!.add(marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude)
      ));
      if(widget.type==2){
        /** widget.address!.location!.lat=newMarkerPosition.latitude;
            widget.address!.location!.long=newMarkerPosition.longitude;
            Provider.of<Preferences>(context,listen: false).temp_address=widget.address;**/
      }


    });

  }

  updateCurrentLocation(bool location){
    widget.onCurrentLocation(location);
    widget.currentLocation=location;
    onCurrentLocation=location;

  }

  Future<String> getLocationName(double latitude,double longitude) async{

    var result=await mapApi.getLocationFromCoordinates(latitude, longitude);
    String mapLocation='';
    if(result is PropertyLocation){
       mapLocation=result.address + ',' + result.address_line_2;
    }
    return mapLocation;
  }

  Future<String> setLocationName(double latitude,double longitude) async{
    String location_name=await getLocationName(latitude,longitude);
    print("The location_name is " + location_name.toString());
    return location_name;
  }

  void removeSelectedMarkers(){
    Provider.of<Preferences>(context,listen: false).markers!.forEach((element) {
      print("marker value is " + element.markerId.value);
    });

    //print("The marker range is " + Provider.of<Preferences>(context,listen: false).markers.length.toString());
    Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId.value
        .contains("home"));
    /* print("The marker range is " + Provider.of<Preferences>(context,listen: false).markers.length.toString());
    Provider.of<Preferences>(context,listen: false).markers.removeWhere((element) => element.markerId.value
    .contains("Selected"));*/


  }

  /*setLocationChosen(bool chosen){
    setState(() {
      isLocationChosen=chosen;
    });
  }*/

  void chooseLocation(Map<String,dynamic> location) async{
    var result=await mapApi.getLocationFromCoordinates(location["lat"], location["lng"]);
    if(result is PropertyLocation){
   //   print(result.toString());
      setState(() {
        //  selectedLocation=location;
        listPlace.clear();
        widget.searchController!.text=result.address_line_2 + ',' + result.city;
        listPlace = [];
        widget.isMap=false;
        widget.isLocationChosen=true;
        widget.onTap(false);
        double temp_lat=double.parse(selectedLocation!['lat'].toString());
        double temp_lng=double.parse(selectedLocation!['lng'].toString());

        print("The selected final location is " + temp_lat.toString() +  ': ' +
            temp_lng.toString());
        new_location.lat=temp_lat;
        new_location.long=temp_lng;

        Provider.of<Preferences>(context,listen: false).tempLocation = result;
        Provider.of<Preferences>(context,listen: false).tempLocation!.location=new_location;
        // _getSelectedLocation(temp_lat,temp_lng);


      });
    }
  }


}

