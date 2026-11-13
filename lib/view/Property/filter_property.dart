import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/constants/app_constants.dart';
import 'package:somalease/view/module.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';
import '../../models/module.dart';

class FilterProperty extends StatefulWidget{
  FilterProperty({Key? key,required this.filter}) : super(key: key);
  Filter? filter;


  @override
  _FilterPropertyState createState()=> _FilterPropertyState();
}

class _FilterPropertyState extends State<FilterProperty>{

  TextEditingController city_controller = TextEditingController(text: '');
  TextEditingController town_controller = TextEditingController(text: '');
  List<String> property_types=["Apartment","Gated Community Home","Independent House/Villa"];
  List<String> bhk_types=["Studio","2BHK","3BHK","4BHK"];
  List<String> preferred_tenant_types=["Family","No Preference"];
  List<String> furnishing_types=["Unfurnished","Semi furnished","Fully furnished"];
  List<bool> property_type_status=[];
  List<bool> bhk_type_status=[];
  List<bool> preference_type_status=[];
  List<bool> furnishing_type_status=[];
  double startVal=0;
  double endVal=50000;
  SfRangeValues _values = SfRangeValues(10.0, 42000.0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initButtonStatus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,color: Colors.black54,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Filter",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,),
            onPressed: (){

            },
          )
        ],),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.0
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                    )
                                ),
                                child: TextFormField(
                                  controller: city_controller,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,fontSize: 14
                                  ),
                                  decoration: const InputDecoration(
                                      filled: false,
                                      contentPadding: EdgeInsets.all(8.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                    )
                                ),
                                child: TextFormField(
                                  controller: town_controller,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,fontSize: 14
                                  ),
                                  decoration: const InputDecoration(
                                      filled: false,
                                      contentPadding: EdgeInsets.all(8.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Looking for ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: property_types.asMap().map((index, element){
                                  return MapEntry(index,Padding(
                                    padding: EdgeInsets.only(right: 5.0,bottom: 20.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          property_type_status[index]=!property_type_status[index];
                                        });
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            gradient:property_type_status[index] ?
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,
                                                  AppConstants.primaryColorDark]
                                            ) :
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[Colors.grey.shade100,Colors.grey.shade100]
                                            )
                                        ),
                                        child: Center(
                                          child: Text(element.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: property_type_status[index] ?
                                              Colors.white :
                                              Colors.grey.shade700,
                                              fontSize: 14
                                          ),textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ),
                                  ));
                                }).values.toList(),
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("BHK Type ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: bhk_types.asMap().map((index, element){
                                  return MapEntry(index,Padding(
                                    padding: EdgeInsets.only(right: 5.0,bottom: 20.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          bhk_type_status[index]=!bhk_type_status[index];
                                        });
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            gradient:bhk_type_status[index] ?
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,
                                                  AppConstants.primaryColorDark]
                                            ) :
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[Colors.grey.shade100,Colors.grey.shade100]
                                            )
                                        ),
                                        child: Center(
                                          child: Text(element.toString(),style: Theme.of(context).textTheme!.bodyMedium!.copyWith(
                                              color: bhk_type_status[index] ?
                                              Colors.white :
                                              Colors.grey.shade700,
                                              fontSize: 14
                                          ),textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ),
                                  ));
                                }).values.toList(),
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Range KES 0-0 ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),

                        /*Padding(
                padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: SfSliderTheme(
                    data: SfSliderThemeData(
                        tooltipBackgroundColor: AppConstants.primaryColorAccent,
                    ),
                    child: SfRangeSlider(
                      min: startVal,
                      max: endVal,
                      values: _values,
                      interval: 25000,
                      showTicks: false,
                      activeColor: AppConstants.primaryColorAccent,
                      inactiveColor: AppConstants.greyColor,
                      showLabels: true,
                      enableTooltip: true,
                      tooltipShape: SfPaddleTooltipShape(),
                      minorTicksPerInterval: 1,
                      onChanged: (SfRangeValues values){
                        setState(() {
                          _values = values;
                          print("The values are " + _values.start.toString() + " end: " + _values.end.toString());
                        });
                      },
                    ),
                  ),
                )
              ),*/
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          child:  RangeSliderFlutter(
                            // key: Key('3343'),
                            values: [startVal, endVal],
                            rangeSlider: true,
                            //  tooltip: null,
                            tooltip: RangeSliderFlutterTooltip(
                              alwaysShowTooltip: true,
                              //   boxStyle: RangeSliderFlutterToolTipBox(),
                              custom: (h){
                                return Container(
                                  width: 120,
                                  height: 48,
                                  child: Text(h.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppConstants.primaryColorAccent,fontWeight: FontWeight.bold
                                  ),),
                                  // color: Colors.blue,
                                );
                              },
                              rightSuffix: Text(" Br"),
                              leftSuffix: Text(" Br"),
                              // alwaysShowTooltip: true,
                              //  disabled: true
                            ),
                            max: 50000,
                            //    textPositionTop: -100,

                            handlerHeight: 30,
                            handler:  RangeSliderFlutterHandler(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            trackBar:RangeSliderFlutterTrackBar(
                              activeTrackBarHeight: 10,
                              inactiveTrackBarHeight: 10,
                              activeTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                  )
                                //   color: AppConstants.primaryColorAccent,
                              ),
                              inactiveTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                            ),

                            min: 0,
                            fontSize: 15,
                            textBackgroundColor:Colors.white,
                            onDragging: (handlerIndex, lowerValue, upperValue) {
                              startVal = lowerValue;
                              endVal = upperValue;
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Preferred Tenant ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: preferred_tenant_types.asMap().map((index, element){
                                  return MapEntry(index,Padding(
                                    padding: EdgeInsets.only(right: 5.0,bottom: 20.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setPreferenceStatus(index);
                                        /*setState(() {
                                          preference_type_status[index]=!preference_type_status[index];
                                        });*/
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            gradient:preference_type_status[index] ?
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,
                                                  AppConstants.primaryColorDark]
                                            ) :
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[Colors.grey.shade100,Colors.grey.shade100]
                                            )
                                        ),
                                        child: Center(
                                          child: Text(element.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: preference_type_status[index] ?
                                              Colors.white :
                                              Colors.grey.shade700,
                                              fontSize: 14
                                          ),textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ),
                                  ));
                                }).values.toList(),
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Furnishing ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: furnishing_types.asMap().map((index, element){
                                  return MapEntry(index,Padding(
                                    padding: EdgeInsets.only(right: 5.0,bottom: 20.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setFurnishingStatus(index);
                                       /* setState(() {
                                          furnishing_type_status[index]=!furnishing_type_status[index];
                                        });*/
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            gradient:furnishing_type_status[index] ?
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,
                                                  AppConstants.primaryColorDark]
                                            ) :
                                            LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[Colors.grey.shade100,Colors.grey.shade100]
                                            )
                                        ),
                                        child: Center(
                                          child: Text(element.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: furnishing_type_status[index] ?
                                              Colors.white :
                                              Colors.grey.shade700,
                                              fontSize: 14
                                          ),textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ),
                                  ));
                                }).values.toList(),
                              ),
                            )
                        ),
                      ],
                    ),
                  )
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child:Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: (){

                          createFilter();
                          /*Navigator.push(context, MaterialPageRoute(builder: (context)
                          => SearchPropertyResult(city: city_controller.text, town: town_controller.text,
                          search_property_types: [],)));*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                              )
                          ),

                          child: Center(
                            child: Text("Filter",style: Theme.of(context).textTheme!.bodyMedium!.copyWith(
                                color: Colors.white,fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),),
                          ),
                        ),
                      )
                  )
              )
            ],
          )
      ),

    );
  }

  initButtonStatus(){
    property_type_status=List.filled(property_types.length, false);
    bhk_type_status=List.filled(bhk_types.length, false);
    preference_type_status=List.filled(preferred_tenant_types.length, false);
    furnishing_type_status=List.filled(furnishing_types.length, false);
  }

  setPreferenceStatus(index){
    for(int i=0;i<preferred_tenant_types.length;i++){
      if(i==index){
        setState(() {
          preference_type_status[i]=!preference_type_status[i];
        });
      }

      else{
        setState(() {
          preference_type_status[i]=false;
        });
      }
    }
  }

  setFurnishingStatus(index){
    for(int i=0;i<furnishing_types.length;i++){
      if(i==index){
        setState(() {
          furnishing_type_status[i]=!furnishing_type_status[i];
        });
      }

      else{
        setState(() {
          furnishing_type_status[i]=false;
        });
      }
    }
  }

  Future<dynamic> createFilter() async{
    List<String> filter_property_types=[];
    List<String> filter_bhk_types=[];
    List<String> filter_preferred_tenant_types=[];
    List<String> filter_furnishing_types=[];



    property_types.asMap().forEach((index, element) {
      if(property_type_status[index]){
        filter_property_types.add(element);
      }
    });


    bhk_types.asMap().forEach((index, element) {
      if(bhk_type_status[index]){
        filter_bhk_types.add(element);
        print("bhk type added is: " + element.toString());
      }
    });

    preferred_tenant_types.asMap().forEach((index, element) {
      if(preference_type_status[index]){
        filter_preferred_tenant_types.add(element);
        print("preferred tenant added is: " + element.toString());
      }
    });

    furnishing_types.asMap().forEach((index, element) {
      if(furnishing_type_status[index]){
        filter_furnishing_types.add(element);
        print("furnishing type added is: " + element.toString());
      }
    });

    if(filter_property_types.isEmpty){
      filter_property_types=property_types;
    }

    if(filter_bhk_types.isEmpty){
      filter_bhk_types=bhk_types;
    }

    if(filter_preferred_tenant_types.isEmpty){
      filter_preferred_tenant_types=preferred_tenant_types;
    }

    if(filter_furnishing_types.isEmpty){
      filter_furnishing_types=furnishing_types;
    }

    Filter filter = Filter(city: city_controller.text,town: town_controller.text,
    filter_property_types: filter_property_types,filter_tenant_types: filter_preferred_tenant_types,
    filter_furnishing_types: filter_furnishing_types,startVal: startVal,endVal: endVal,
    filter_bhk_types: filter_bhk_types);

    Navigator.pop(context,filter);


    /*Navigator.push(context, MaterialPageRoute(builder: (context)
    => SearchPropertyResult(city: city_controller.text, town: town_controller.text,
      search_property_types: search_property_types,
      search_availability_types: search_availability_types,
      search_bhk_types: search_bhk_types,
      startVal: startVal,endVal: endVal,
    )));*/
  }
}