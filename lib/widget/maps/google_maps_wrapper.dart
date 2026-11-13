import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import 'package:provider/provider.dart';
import '../../models/module.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GoogleMapsWrapper extends StatefulWidget{
  GoogleMapsWrapper({Key? key,this.isMap,this.markers,this.controller,this.longitude,this.latitude,
    this.onUpdatePosition,this.onCameraIdle,this.onCameraMoveStarted,this.isAbsorbPointer,
    this.onCurrentLocation,this.isLocationChosen,this.onMapSelected}):super(key:key);
  bool? isMap;
  bool? isAbsorbPointer;
  Set<Marker>? markers;
  //Map<MarkerId,Marker> markers;
  double? latitude;
  double? longitude;
  bool? isLocationChosen;
  //double field_height;
  Function(CameraPosition)? onUpdatePosition;
  Function? onCameraMoveStarted;
  Function? onCurrentLocation;
  Function(Completer<GoogleMapController>)? onCameraIdle;
  Function? onMapSelected;

  Completer<GoogleMapController>? controller = Completer();
  // GoogleMapController controller;


  @override
  GoogleMapsWrapperState createState()=> GoogleMapsWrapperState();

}

class GoogleMapsWrapperState extends State<GoogleMapsWrapper>{

  bool isCameraMoving=false;
  Widget mapWidget=Container();
  bool isMapFolded=false;
  double main_map_height=0.0;
  double bottom_container_height=0.0;
  double app_bar_height=0.0;
  Completer<GoogleMapController> new_controller = Completer();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    print("Checked map is " + checkIsMap().toString());
    bottom_container_height=90;
    app_bar_height=55;
    double map_height=(MediaQuery.of(context).size.height - bottom_container_height- app_bar_height
        - MediaQuery.of(context).padding.bottom);
    //  double map_height= MediaQuery.of(context).size.height - bottom_container_height- app_bar_height -MediaQuery.of(context).padding.top;
    main_map_height=map_height;


    return  AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: checkIsMap() ? main_map_height * 0.94:
      MediaQuery.of(context).size.height * 0.30,
      duration: Duration(milliseconds: 500),
      child:  Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AbsorbPointer(
                //     absorbing: true,
                  absorbing: checkIsPointer(),
                  // absorbing: false,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: widget.markers!,
                    myLocationButtonEnabled: false,
                    //  myLocationButtonEnabled: checkIsMap(),
                    // myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude!, widget.longitude!),
                      zoom: 18,
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),),},
                    onMapCreated: (GoogleMapController controller) async{
                      widget.controller!.complete(controller);
                      // new_controller.complete(controller);
                      //  controller=await new_controller.future;
                      isMapFolded=checkIsMap();
                      print('IsMapFolded is ' + isMapFolded.toString());
                      if(isMapFolded==false){

                      }
                    },
                    onCameraMove: (cameraPosition){
                      print("Camera moving");
                      widget.onUpdatePosition!(cameraPosition);
                    },

                    onCameraIdle: (){
                      try{
                        print('Camera Idle');

                        setState((){
                          isCameraMoving=false;

                        });
                        //   widget.onCameraIdle(new_controller);
                        widget.onCameraIdle!(widget.controller!);
                      }

                      catch(Exception,stacktrace){
                        print("Error: " + stacktrace.toString());
                      }
                    },

                    onCameraMoveStarted: (){
                      setState(() {
                        isCameraMoving=true;
                      });
                      print("Move Started");
                      widget.onCameraMoveStarted!();
                    },

                  ),
                ),


                isCameraMoving && checkIsMap() ?
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      //  color: Colors.redAccent,
                      //  color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: (main_map_height/2) /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                      child: Container(
                          width: 25,
                          height: 50,
                          //   color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            //  Image.asset('assets/images/somalease_icon.png',width: 50,height: 50,)
                             /* SvgPicture.asset('assets/images/pin2_2.svg',
                                  width: 50,
                                  height: 50,),*/
                              Icon(CupertinoIcons.placemark,color: AppConstants.primaryColorAccent,size: 60,),
                            ],
                          )
                      ),
                    )
                  //child: Icon(CupertinoIcons.placemark_fill,color: Colors.black,size: 40,),
                ):

                !checkIsMap() ?
                Container() :
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                     //    color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: (main_map_height/2),
                      child: GestureDetector(
                        onTap: (){
                          print("Clicked map");
                          widget.onMapSelected!();
                        },
                        child:  Container(
                            width: 25,
                            height: 50,
                            //        color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //    Image.asset('assets/images/somalease_icon.png',width: 50,height: 50,)
                                /*   SvgPicture.asset('assets/images/somalease_icon.svg',
                                  width: 50,
                                  height: 50,color: Colors.redAccent,),*/
                                Icon(CupertinoIcons.placemark_fill,color: AppConstants.primaryColorAccent,size: 60,),
                                Container(
                                    width: 90,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      //  color: Colors.transparent,
                                        border: Border.all(color: AppConstants.primaryColorAccent),
                                        borderRadius: BorderRadius.circular(8.0),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                        )
                                    ),
                                    child: Center(
                                      child: Text("Tap to select",style: Theme.of(context).textTheme!.bodySmall!.copyWith(
                                        //  color: AppConstants.primaryColorDark,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    )
                                )
                              ],
                            )
                        ),
                      )
                    )
                  //child: Icon(CupertinoIcons.placemark_fill,color: Colors.black,size: 40,),
                ),
                !checkIsMap() ?
                Container(
                //    color: Colors.redAccent.withOpacity(0.1),
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height * 0.30),
                  child: Center(
                    child: Container(
                       // width: 25,
                      //  height: 50,
                        //        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //    Image.asset('assets/images/somalease_icon.png',width: 50,height: 50,)
                            /*   SvgPicture.asset('assets/images/somalease_icon.svg',
                                  width: 50,
                                  height: 50,color: Colors.redAccent,),*/
                            Icon(CupertinoIcons.placemark_fill,color: AppConstants.primaryColorAccent,size: 60,),
                            /*Container(
                                width: 90,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: AppConstants.primaryColorAccent),
                                    borderRadius: BorderRadius.circular(8.0),
                                   /* gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                    )*/
                                ),
                                child: Center(
                                  child: Text("Tap to choose",style: Theme.of(context).textTheme!.bodySmall!.copyWith(
                                      color: AppConstants.primaryColorDark,
                                   //   color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),),
                                )
                            )*/
                          ],
                        )
                    ),
                  ),
                  //color: Colors.black,
                ):Container()
              ],
            ),
          )
        ],
      ),
    );
    //  return googleMapWidget();


  }

  Widget googleMapWidget(){
    Widget newMapWidget= AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        height: checkIsMap() ? main_map_height * 0.94:
        MediaQuery.of(context).size.height * 0.25,
        duration: const Duration(milliseconds: 500),
        child: Stack(
          children: [
            GoogleMap(

              mapType: MapType.normal,
              /*onTap: (LatLng latlng){
                if(checkIsMap()==false){
                  setState(() {
                    widget.isMap=true;
                    widget.isLocationChosen=false;
                  });
                }
              },*/
              //  markers: Set<Marker>.of(widget.markers.values),
              markers: widget.markers!,
              myLocationButtonEnabled: checkIsMap(),
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude!, widget.longitude!),
                zoom: 12.0,
              ),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),),},
              onMapCreated: (GoogleMapController controller) async{
                widget.controller!.complete(controller);
                isMapFolded=checkIsMap();
                print('IsMapFolded is ' + isMapFolded.toString());
                if(isMapFolded==false){
                  GoogleMapController new_controller=await widget.controller!.future;
                  print("Snapshot taken");
                  //  GoogleMapController new_controller=controller;
                  Uint8List? _imageBytes;

                  _imageBytes=await new_controller.takeSnapshot();
                  createSnasphot(_imageBytes);
                }

                //   widget.controller=controller;
              },
              onCameraMove: (cameraPosition){
                print("Camera moving");
                widget.onUpdatePosition!(cameraPosition);
              },

              onCameraIdle: (){
                print('Camera Idle');
                //  widget.onCameraIdle(widget.controller);
                setState((){
                  isCameraMoving=false;

                });
                widget.onCameraIdle!(widget.controller!);
              },

              onCameraMoveStarted: (){
                setState(() {
                  isCameraMoving=true;
                });
                print("Move Started");
                widget.onCameraMoveStarted!();
              },

            ),
            isCameraMoving && checkIsMap() ?
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  //  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  height: main_map_height * 0.94/2,
                  child: Container(
                      width: 25,
                      height: 50,
                      //   color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Image.asset('assets/images/somalease_icon.png',width: 20,height: 20,)
                          /*SvgPicture.asset('assets/images/pin2_2.svg',
                            width: 50,
                            height: 50,),*/
                          // Icon(CupertinoIcons.placemark_fill,color: Colors.red,size: 40,),
                        ],
                      )
                  ),
                )
              //child: Icon(CupertinoIcons.placemark_fill,color: Colors.black,size: 40,),
            ):

            !checkIsMap() ?
            Container() :
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  //  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  height: main_map_height * 0.94/2,
                  child: Container(
                      width: 25,
                      height: 50,
                      //   color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Image.asset('assets/images/somalease_icon.png',width: 20,height: 20,)
                          /*SvgPicture.asset('assets/images/pin2_2.svg',
                            width: 50,
                            height: 50,),*/
                          // Icon(CupertinoIcons.placemark_fill,color: Colors.red,size: 40,),
                        ],
                      )
                  ),
                )
              //child: Icon(CupertinoIcons.placemark_fill,color: Colors.black,size: 40,),
            ),
            !checkIsMap() ?
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              //color: Colors.black,
            ):Container()
          ],
        )
    );
    mapWidget=newMapWidget;
    return mapWidget;
  }



  bool checkIsMap(){
    if(widget.isMap!){
      return true;
    }

    else{
      return false;
    }
  }

  bool checkIsPointer(){
    if(widget.isAbsorbPointer!){
      return true;
    }
    else{
      return false;
    }
  }



  Widget createSnasphot(Uint8List? imageBytes){
    isMapFolded=checkIsMap();
    if(isMapFolded){
      if(imageBytes!=null){
        // setState(() {
        mapWidget=
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: imageBytes != null ? Image.memory(imageBytes) : null,
            );
        mapWidget=Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: imageBytes != null ? Image.memory(imageBytes) : null,
            ),
          ],
        );

        //   });
      }
      return mapWidget;
    }

    else{
      mapWidget=googleMapWidget();
      return mapWidget;
    }

  }


}
