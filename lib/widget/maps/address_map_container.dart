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



class AddressMapContainer extends StatefulWidget{
  AddressMapContainer({Key? key,this.searchController,required this.isMap,
    required this.onTap,required this.isLocationChosen,required this.type,/*this.address,*/
    required this.isAbsorbPointer,this.new_location_selected,required this.onCurrentLocation,
    required this.currentLocation}):super(key: key);
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
  AddressMapContainerState createState()=> AddressMapContainerState();
}

class AddressMapContainerState extends State<AddressMapContainer>{

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
  void initState(){
    // TODO: implement initState
    super.initState();
    //_controller=new Completer();
    //loadMarkerIcon();
    //  _createMarkerImageFromAsset(context);

    widget.type==1 ? _getCurrentLocation():
    //   choosePosition();
    //_getAddressLocation();
    _loadAddress();


  }



  @override
  Widget build(BuildContext context) {
    /*widget.type==1 ? _getCurrentLocation():
    _getAddressLocation();*/


    _createMarkerImageFromAsset(context);

    if(widget.isLocationChosen==true){
      print("Using is choosePosition");
      choosePosition();
    }

    else{
      print("Using isLocationChosen==false");
      unselectPosition();
    }



    // TODO: implement build
    return Stack(
      children: [
        //checkIsMap() ?
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
            child: mapWidget
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
      mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
        isAbsorbPointer: checkIsAbsorbPointer(),
        markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! : Set<Marker>(),
        latitude:res.latitude,longitude:res.longitude,controller: _controller,
        onUpdatePosition: (camPosition){
          // _cameraMoving(camPosition);
          _updatePosition(camPosition);
        },

        onCameraMoveStarted: (){
          onCameraMoveStarted();
        },
        onCameraIdle: (completer) async{
          // GoogleMapController idleController=await completer.future;
          onCameraIdle(completer);
        },
      );
    });
  }

  void _moveLastLocation(double lat,double long) async{
    _createMarker(lat,
        long, markerId, 'Current Location');
    mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
      isAbsorbPointer: checkIsAbsorbPointer(),
      markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! : Set<Marker>(),
      latitude:lat,longitude:long,controller: _controller,
      onUpdatePosition: (camPosition){
        // _cameraMoving(camPosition);
        _updatePosition(camPosition);
      },

      onCameraMoveStarted: (){
        onCameraMoveStarted();
      },
      onCameraIdle: (completer) async{
        // GoogleMapController idleController=await completer.future;
        onCameraIdle(completer);
      },
    );
  }

  void _getLastLocation() async {
    AppGeoLocation last_location=new AppGeoLocation(lat: 0,long: 0);

    if(widget.currentLocation){
      print("Using is current Location");
      last_location.lat=Provider.of<Preferences>(context,listen: false).current_location!.lat;
      last_location.long=Provider.of<Preferences>(context,listen: false).current_location!.long;
      //    last_location.lat=widget.address.location.lat;
      //    last_location.long=widget.address.location.long;
      _moveLastLocation(last_location.lat!, last_location.long!);
      GoogleMapController controller=await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(last_location.lat!, last_location.long!),),);


    }

    else{
      print("Using new locations");
      //   last_location.lat=widget.address.location.lat;
      //   last_location.long=widget.address.location.long;

      if(selectedLocation==null){
      /**  last_location.lat=widget.address!.location!.lat;
        last_location.long=widget.address!.location!.long;**/
        //   last_location.lat=Provider.of<Preferences>(context,listen: false).current_location.lat;
        //   last_location.long=Provider.of<Preferences>(context,listen: false).current_location.long;
      }

      else{
        last_location.lat=double.parse(selectedLocation!['lat'].toString());
        last_location.long=double.parse(selectedLocation!['lng'].toString());
      }

      _moveLastLocation(last_location.lat!, last_location.long!);
    }



  }


  Future <void> _getAddressLocation() async {
    //  Position res = await Geolocator().getCurrentPosition();
    setState(() {
     /** print("The latitude is " + widget.address!.location!.lat.toString() + ' ' + 'the longitude is ' +
          widget.address!.location!.long.toString());**/
      print("Its here");
      Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId==
          markerId);
      // removeSelectedMarkers();

      //   _createMarker(widget.address.location.lat, widget.address.location.long, markerId, 'Current Location');
      _createMarker(Provider.of<Preferences>(context,listen: false).temp_location!.lat!,
          Provider.of<Preferences>(context,listen: false).temp_location!.long!,
          markerId,'Current Location');
      mapWidget= GoogleMapsWrapper(isMap: true,
        isAbsorbPointer: checkIsAbsorbPointer(),
        markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! : Set<Marker>(),
        latitude:Provider.of<Preferences>(context,listen: false).temp_location!.lat!,
        longitude:Provider.of<Preferences>(context,listen: false).temp_location!.long!,controller: _controller,
        onUpdatePosition: (camPosition){

          _updatePosition(camPosition);
        },

        onCameraMoveStarted: (){
          onCameraMoveStarted();
        },
        onCameraIdle: (completer){
          // GoogleMapController idleController=await completer.future;

          onCameraIdle(completer);
        },
      );
    });
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

  Future<void> _loadAddress() async{
    //  setSelectedLocation();
    await _getAddressLocation();
  }

  Future<void> _getSelectedLocation(double map_lat,double map_lng) async{
    setState(() {

      new_location.lat=map_lat;
      new_location.long=map_lng;

      Provider.of<Preferences>(context,listen: false).tempLocation!.location=new_location;

      //    removeSelectedMarkers();
      // Provider.of<Preferences>(context,listen: false).markers.removeWhere((element) => element.markerId==markerId);
      //  _createMarker(new_location.lat, new_location.long, MarkerId("Selected"+counter.toString()), 'Selected Location');
      // _createMarker(new_location.lat, new_location.long, markerId, 'Current Location');
      _createMarker(new_location.lat!,new_location.long!,markerId,
          'Current Location');


      try{
        mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
          isAbsorbPointer: checkIsAbsorbPointer(),
          markers: !checkIsMap() ? Provider.of<Preferences>(context,listen: false).markers! :Set<Marker>(),
          latitude:new_location.lat!,longitude: new_location.long!,controller: _controller,onUpdatePosition: (camPosition){
            //   _updatePosition(camPosition);
          },

          onCameraMoveStarted: (){
            print("Executing this2");
            //    onCameraMoveStarted();
          },
          onCameraIdle: (completer){
            print("Executing this");
            onCameraIdle1(completer);
          },
        );
      }
      catch(Exception,stacktrace){
        print("Error: " + stacktrace.toString());
      }
    });
  }

  Future<void> onCameraIdle1(Completer<GoogleMapController> completer) async{

    try{

      GoogleMapController googleMapController=await completer.future;
      LatLngBounds visibleRegion = await googleMapController.getVisibleRegion();
      LatLng centerLatLng = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
        (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) / 2,);
      selectedLocation=Map<String,dynamic>();
      selectedLocation!['lat']=centerLatLng.latitude;
      selectedLocation!['lng']=centerLatLng.longitude;
      print("The idle1 lat is " + centerLatLng.toString() + 'the idle1 lng is ' + centerLatLng.longitude.toString());
      widget.searchController!.text=await setLocationName(centerLatLng.latitude,centerLatLng.longitude);
      setState(() {
        Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
        Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId==markerId);



      });

      Marker marker=Marker(
          markerId: markerId,
          icon: bitMapIcon!,
          infoWindow: const InfoWindow(title: 'Home'));
      Provider.of<Preferences>(context,listen: false).markers!.add(marker.copyWith(
          positionParam: LatLng(centerLatLng.latitude, centerLatLng.longitude)
      ));
    }
    catch(Exception,ex){
      print("Error: " + ex.toString());
    }
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



      });*/

      googleMapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(centerLatLng.latitude, centerLatLng.longitude),),);

      /*Marker marker=Marker(
          markerId: markerId,
          icon: bitMapIcon!,
          infoWindow: const InfoWindow(title: 'Home'));
      Provider.of<Preferences>(context,listen: false).markers!.add(marker.copyWith(
          positionParam: LatLng(centerLatLng.latitude, centerLatLng.longitude)
      ));

      mapWidget=GoogleMapsWrapper(isMap: checkIsMap(),
        isAbsorbPointer: checkIsAbsorbPointer(),
        markers: Provider.of<Preferences>(context,listen: false).markers!,
        latitude:centerLatLng.latitude,longitude: centerLatLng.longitude,controller: _controller,onUpdatePosition: (camPosition){

        },
        onCameraIdle: (completer) async{

          //   onCameraIdle(completer);
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

  /*void _createMarker(double latitude,double longitude,MarkerId marker_id,String title) {

    markers.addEntries([
      MapEntry(marker_id, Marker(
        markerId: marker_id,
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarker,
       // icon:bitMapIcon,
        infoWindow: InfoWindow(title: title),
        onTap: ()=>_onMarkerTapped(marker_id),
        draggable: true,
        onDragEnd: (LatLng newPosition)=> _onMarkerDragEnd(marker_id, newPosition),
      ))
    ]);


  }*/

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

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId]!;
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
            iconParam: BitmapDescriptor.defaultMarker
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }



  void _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      this.markerPosition = newPosition;
    });
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId]!;

    if (tappedMarker != null) {
      Map<String,dynamic> location={"lat":tappedMarker.position.latitude,
        "lng":tappedMarker.position.longitude
      };
      setState(() {
        this.markerPosition = null;
        selectedLocation=location;

      });
      chooseLocation(selectedLocation!);

      /* await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });*/
    }
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
    if(widget.isAbsorbPointer){
      return true;
    }

    else{
      return false;
    }
  }

  void chooseLocation(Map<String,dynamic> location) async{
    String result=await mapApi.getLocationFromCoordinates(location["lat"], location["lng"]);
    print(result.toString());
    setState(() {
      selectedLocation=location;
      listPlace.clear();
      widget.searchController!.text=result;
      listPlace = [];
      widget.isMap=false;
      widget.onTap(false);
      double temp_lat=double.parse(selectedLocation!['lat'].toString());
      double temp_lng=double.parse(selectedLocation!['lng'].toString());

      print("The selected final location is " + temp_lat.toString() +  ': ' +
          temp_lng.toString());
      _getSelectedLocation(temp_lat,temp_lng);


    });
  }

  void _changePosition(double latitude,double longitude) async{
    Position newMarkerPosition = Position(
        latitude: latitude,
        longitude: longitude,accuracy: 0,
        altitude: 0,heading: 0,speed: 0,speedAccuracy: 0,floor: 9,isMocked: false,timestamp: DateTime.now()
    );
    print("Heeeeerr");
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

  setSelectedLocation(){
    selectedLocation=Map<String,dynamic>();
    /** selectedLocation!['lat']=widget.address!.location!.lat;
    selectedLocation!['lng']=widget.address!.location!.long;
    print("The selected location is " + selectedLocation!['lat'].toString() + ': ' +
        selectedLocation!['lng'].toString());**/
  }

  /*choosePosition() async{
    widget.isMap=false;
    widget.onTap(false);
  }*/

  choosePosition() async{

    widget.isMap=false;
    widget.onTap(false);


    /** widget.isMap=true;
        widget.onTap(true);**/
    if(selectedLocation==null && widget.type==2){

      //double temp_lat= widget.address.location.lat;
      // double temp_lng=widget.address.location.long;
      double temp_lat=0.0;
      double temp_lng=0.0;

      if(widget.currentLocation){
        print("Pass 1");
        temp_lat=Provider.of<Preferences>(context,listen: false).temp_location!.lat!;
        temp_lng=Provider.of<Preferences>(context,listen: false).temp_location!.long!;
        /* temp_lat=Provider.of<Preferences>(context,listen: false).current_location.lat;
        temp_lng=Provider.of<Preferences>(context,listen: false).current_location.long;*/
      }

      else{
        print("Pass 2");
        temp_lat=Provider.of<Preferences>(context,listen: false).temp_location!.lat!;
        temp_lng=Provider.of<Preferences>(context,listen: false).temp_location!.long!;
      }
      print("IN type 2");
      await _getSelectedLocation(temp_lat,temp_lng);
    }

    else if(widget.type==2 && widget.new_location_selected==false){
      /**
      setState(() {
        Provider.of<Preferences>(context,listen: false).markers!.remove(markerId);
        Provider.of<Preferences>(context,listen: false).markers!.removeWhere((element) => element.markerId==markerId);

      });

      double temp_lat=widget.address!.location!.lat!;
      double temp_lng=widget.address!.location!.long!;
      print("IN Type 1");
      print("lat is " + temp_lat.toString() + ' lng is ' + temp_lng.toString());
      await _getSelectedLocation(temp_lat,temp_lng);
      GoogleMapController controller=await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(temp_lat, temp_lng),),);**/

    }



    else{
      double temp_lat=double.parse(selectedLocation!['lat'].toString());
      double temp_lng=double.parse(selectedLocation!['lng'].toString());
      /*double temp_lat=widget.address.location.lat;
        double temp_lng=widget.address.location.long;*/
      print("IN Type 1.1");
      print("lat is " + temp_lat.toString() + ' lng is ' + temp_lng.toString());
      await _getSelectedLocation(temp_lat,temp_lng);
      /* GoogleMapController controller=await _controller.future;
          controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(temp_lat, temp_lng),),);*/
    }

  }

  unselectPosition() async{
    widget.isMap=true;
    widget.onTap(true);
    _getLastLocation();


  }

  bool getCurrentLocationStatus(){
    //  return widget.currentLocation;
    // return onCurrentLocation;
    return widget.currentLocation;
  }

  updateCurrentLocation(bool location){
    widget.onCurrentLocation(location);
    widget.currentLocation=location;
    onCurrentLocation=location;

  }

  void _updatePosition1(CameraPosition _position) async{
    Position newMarkerPosition = Position(latitude: _position.target.latitude, longitude: _position.target.longitude
        ,accuracy: 0,
        altitude: 0,heading: 0,speed: 0,speedAccuracy: 0,floor: 9,isMocked: false,timestamp: DateTime.now());
    Marker marker = markers[markerId]!;
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    GoogleMapController controller=await _controller.future;

    setState(() {
      /* markers[markerId] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));*/

      setState(() {
        markers[markerId] = marker.copyWith(
          anchorParam: newAnchor,);
      });

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


    });

    /*CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 270.0,
        target: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude),
        tilt: 30.0,
        zoom: 17.0,
      ),
    );*/
  }


  Future<void> _createMarkerImageFromAsset(BuildContext context) async {

    bitMapIcon = BitmapDescriptor.defaultMarker;
    ///Amaizi icon
    /**if (bitMapIcon == null) {
      final ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context, size: const Size.square(48));
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, //'assets/images/pin50.png',
          'assets/images/pin2_2.png'

      )
          .then(_updateBitmap);
    }**/

  }

  /**void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      bitMapIcon = bitmap;
    });
  }**/

  /*Future<void> loadMarkerIcon() async{
    bitMapIcon= await _getAssetIcon(context);
  }*/

  Future<String> getLocationName(double latitude,double longitude) async{

    String result=await mapApi.getLocationFromCoordinates(latitude, longitude);
    return result;
  }

  Future<String> setLocationName(double latitude,double longitude) async{
    String location_name=await getLocationName(latitude,longitude);
    print("The location_name is " + location_name.toString());
    return location_name;
  }



}