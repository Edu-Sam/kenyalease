import 'package:flutter/material.dart';
import 'package:somalease/widget/circular_progress_container.dart';
import 'package:somalease/widget/error_container.dart';
import 'package:somalease/widget/module.dart';
import '../../services/module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';



class UpdateProperty extends StatefulWidget{
  UpdateProperty({Key? key,required this.property}) : super(key: key);
  final Property? property;

  @override
  _UpdatePropertyState createState()=> _UpdatePropertyState();

}

class _UpdatePropertyState extends State<UpdateProperty>{

  late TextEditingController master_name_controller;
  late TextEditingController master_location_controller;
  late TextEditingController property_description_controller;
  late TextEditingController builtup_area_controller;
  late TextEditingController rent_controller;
  late TextEditingController deposit_controller;
  late TextEditingController no_of_bedrooms_controller;
  late TextEditingController no_of_bathrooms_controller;

  List<String> bhk_types=["+2BHK","+4BHK","+5BHK","+6BHK"];
  List<String> apartment_type=["Apartment","Independent House/Villa","Gated Community/Villa"];
  List<String> floors=["1","2","3","4","5","6","7","8","9","10","10+"];
  List<String> age_of_building=["0-3yrs","3-5 yrs","6-10yrs","Above 10yrs"];
  List<String> facings=["North","South","East","West"];
  List<String> parkings=["Bike","Car","Both","None"];
  List<String> furnishings=["Fully-Furnished","Semi-Furnished","Unfurnished"];
  List<String> gated_security=["Yes","No"];
  List<String> power_backup =["Yes","No"];
  List<String> balcony = ["Available","Not Available"];
  int? apartment_type_value=0,bhk_type_value=0,floor_value=0,age_value=0,facings_value=0,parkings_value=0,
      furnishing_value=0,gated_security_value=0,power_backup_value=0,balcony_value=0;
  int new_availability_option=0;
  String? availability_option='';
  bool is_rent_negotiable=false;
  File? _image,_image1,_image2,_image3;
  final picker = ImagePicker();
  bool isLoading=false;
  ErrorContainer errorContainer = ErrorContainer();
  NotificationContainer notificationContainer = NotificationContainer();

  PropertyRepository propertyRepository = PropertyRepository();
  String message='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    master_name_controller=TextEditingController(text: widget.property!.property_name);
    master_location_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).city);
    property_description_controller = TextEditingController(text: widget.property!.property_description.elementAt(0).description);
    builtup_area_controller = TextEditingController(text: widget.property!.property_overviews.elementAt(0).builtup_area.toString());
    rent_controller = TextEditingController(text: widget.property!.property_overviews.elementAt(0).expected_rent.toString());
    deposit_controller = TextEditingController(text: widget.property!.property_overviews.elementAt(0).expected_deposit.toString());
    no_of_bedrooms_controller = TextEditingController(text: widget.property!.no_of_bedrooms.toString());
    no_of_bathrooms_controller = TextEditingController(text: widget.property!.no_of_bathrooms.toString());
    setData();

  }

  @override
  Widget build(BuildContext context) {
    print("Widget.property id is " + widget.property!.property_master_id.toString());
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Edit Property',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            leading: IconButton(
              icon:  Icon(CupertinoIcons.back,color: AppConstants.primaryColorDark,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0,top: 20.0
                        ),
                        child: Text("Property Information",style: Theme.of(context).textTheme
                            .bodySmall!.copyWith(color: AppConstants.primaryColorAccent,fontSize: 20,
                            fontWeight: FontWeight.w500),),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: TextFormField(
                            controller: master_name_controller,
                            decoration: InputDecoration(
                              hintText: 'Property Name',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: TextFormField(
                            controller: master_location_controller,
                            decoration: InputDecoration(
                              hintText: 'Property Location',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0,top: 20.0
                        ),
                        child: Text("Property Description",style: Theme.of(context).textTheme
                            .bodySmall!.copyWith(color: AppConstants.primaryColorAccent,fontSize: 20,
                            fontWeight: FontWeight.w500),),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 48,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: TextFormField(
                            controller: property_description_controller,
                            maxLines: 4,
                            minLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Property Description',

                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0,top: 20.0
                        ),
                        child: Text("Overview",style: Theme.of(context).textTheme
                            .bodySmall!.copyWith(color: AppConstants.primaryColorAccent,fontSize: 20,
                            fontWeight: FontWeight.w500),),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text("Property Info",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black54
                          ),),
                        ),
                      ),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              'Apartment Type*',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.black87
                            ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Container(
                              // color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0.0,1.0),
                                          spreadRadius: 1.0,
                                          blurRadius: 2.0,
                                          color: AppConstants.thirdColor.withOpacity(0.2)
                                        //  color: Colors.black12
                                      )]),
                                child: FormField(
                                    builder: (FormFieldState state){
                                      return InputDecorator(

                                          decoration:  InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                            //     labelStyle: textStyle,
                                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            // labelText:'Select Bank',
                                          ),
                                          child:DropdownButtonHideUnderline(
                                              child:DropdownButton(
                                                value: apartment_type_value,
                                                isDense: true,
                                                hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                  //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                ),),

                                                onChanged: (int? newValue){
                                                  apartment_type_value=newValue;
                                                  state.didChange(newValue);


                                                },
                                                //  icon: null,
                                                icon: const Icon(Icons.keyboard_arrow_down),
                                                items:apartment_type.map((value){
                                                  return DropdownMenuItem(
                                                    value: apartment_type.indexOf(value),
                                                    child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                      fontSize: 12,fontWeight: FontWeight.w400,
                                                      //      fontFamily: GoogleFonts.openSans().fontFamily
                                                    ),),
                                                  );
                                                }).toList(),
                                              )
                                          )
                                      );

                                    }
                                )
                            ),
                          ),
                        ],
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'BHK Type',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0,),
                                      child: Container(
                                        // color: Colors.white,
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0.0,1.0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 2.0,
                                                    color: AppConstants.thirdColor.withOpacity(0.2)
                                                  //  color: Colors.black12
                                                )]),
                                          child: FormField(
                                              builder: (FormFieldState state){
                                                return InputDecorator(

                                                    decoration:  InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                      //     labelStyle: textStyle,
                                                      errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      // labelText:'Select Bank',
                                                    ),
                                                    child:DropdownButtonHideUnderline(
                                                        child:DropdownButton(
                                                          value: bhk_type_value,
                                                          isDense: true,
                                                          hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                            //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                          ),),

                                                          onChanged: (int? newValue){
                                                            bhk_type_value=newValue;
                                                            state.didChange(newValue);


                                                          },
                                                          //  icon: null,
                                                          icon: const Icon(Icons.keyboard_arrow_down),
                                                          items:bhk_types.map((value){
                                                            return DropdownMenuItem(
                                                              value: bhk_types.indexOf(value),
                                                              child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                                fontSize: 12,fontWeight: FontWeight.w400,
                                                                //      fontFamily: GoogleFonts.openSans().fontFamily
                                                              ),),
                                                            );
                                                          }).toList(),
                                                        )
                                                    )
                                                );

                                              }
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Floors',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 2.0,
                                                  color: AppConstants.thirdColor.withOpacity(0.2)
                                                //  color: Colors.black12
                                              )]),
                                        child: FormField(
                                            builder: (FormFieldState state){
                                              return InputDecorator(

                                                  decoration:  InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    //     labelStyle: textStyle,
                                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    // labelText:'Select Bank',
                                                  ),
                                                  child:DropdownButtonHideUnderline(
                                                      child:DropdownButton(
                                                        value: floor_value,
                                                        isDense: true,
                                                        hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                        ),),

                                                        onChanged: (int? newValue){
                                                          floor_value=newValue;
                                                          state.didChange(newValue);


                                                        },
                                                        //  icon: null,
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        items:floors.map((value){
                                                          return DropdownMenuItem(
                                                            value: floors.indexOf(value),
                                                            child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                              fontSize: 12,fontWeight: FontWeight.w400,
                                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                                            ),),
                                                          );
                                                        }).toList(),
                                                      )
                                                  )
                                              );

                                            }
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Property Age*',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0,),
                                      child: Container(
                                        // color: Colors.white,
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0.0,1.0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 2.0,
                                                    color: AppConstants.thirdColor.withOpacity(0.2)
                                                  //  color: Colors.black12
                                                )]),
                                          child: FormField(
                                              builder: (FormFieldState state){
                                                return InputDecorator(

                                                    decoration:  InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                      //     labelStyle: textStyle,
                                                      errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      // labelText:'Select Bank',
                                                    ),
                                                    child:DropdownButtonHideUnderline(
                                                        child:DropdownButton(
                                                          value: age_value,
                                                          isDense: true,
                                                          hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                            //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                          ),),

                                                          onChanged: (int? newValue){
                                                            age_value=newValue;
                                                            state.didChange(newValue);


                                                          },
                                                          //  icon: null,
                                                          icon: const Icon(Icons.keyboard_arrow_down),
                                                          items:age_of_building.map((value){
                                                            return DropdownMenuItem(
                                                              value: age_of_building.indexOf(value),
                                                              child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                                fontSize: 12,fontWeight: FontWeight.w400,
                                                                //      fontFamily: GoogleFonts.openSans().fontFamily
                                                              ),),
                                                            );
                                                          }).toList(),
                                                        )
                                                    )
                                                );

                                              }
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Facing',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 2.0,
                                                  color: AppConstants.thirdColor.withOpacity(0.2)
                                                //  color: Colors.black12
                                              )]),
                                        child: FormField(
                                            builder: (FormFieldState state){
                                              return InputDecorator(

                                                  decoration:  InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    //     labelStyle: textStyle,
                                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    // labelText:'Select Bank',
                                                  ),
                                                  child:DropdownButtonHideUnderline(
                                                      child:DropdownButton(
                                                        value: facings_value,
                                                        isDense: true,
                                                        hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                        ),),

                                                        onChanged: (int? newValue){
                                                          facings_value=newValue;
                                                          state.didChange(newValue);


                                                        },
                                                        //  icon: null,
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        items:facings.map((value){
                                                          return DropdownMenuItem(
                                                            value: facings.indexOf(value),
                                                            child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                              fontSize: 12,fontWeight: FontWeight.w400,
                                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                                            ),),
                                                          );
                                                        }).toList(),
                                                      )
                                                  )
                                              );

                                            }
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0 ),
                        child: Text(
                          'Built Up Area',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black54
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0,top: 0.0
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: TextFormField(
                            controller: builtup_area_controller,

                            decoration: InputDecoration(

                                hintText: 'Built Up Area',
                                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey.shade400
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide(color: Colors.grey.shade200)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide(color: Colors.grey.shade200)
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 14),
                                  child: Text('Sq.ft'),
                                )
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text("Rent Details",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black54
                          ),),
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(top: 20.0,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Text("Property available for:",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.black87,fontWeight: FontWeight.w500
                              ),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //width: MediaQuery.of(context).size.width * 0.40,
                                  width: 160,
                                  child: RadioListTile(
                                      title:  Text('Only Rent'
                                          ,style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w500)
                                      ),
                                      value: 'rent',
                                      activeColor: AppConstants.primaryColor,
                                      groupValue: availability_option,
                                      onChanged: (text){
                                        setState(() {
                                          new_availability_option=0;
                                          availability_option=text.toString();
                                        });
                                      }),
                                ),


                                Container(
                                  //    width: MediaQuery.of(context).size.width * 0.40,
                                  width: 160,
                                  child: RadioListTile(
                                      title:  Text(
                                          'Only Lease',style: Theme.of(context).textTheme
                                          .bodyMedium!.copyWith(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w500)
                                      ),
                                      value: 'lease',
                                      activeColor: AppConstants.primaryColor,
                                      groupValue: availability_option,
                                      onChanged: (text){
                                        setState(() {
                                          new_availability_option=1;

                                          availability_option=text.toString();
                                        });
                                      }),
                                )

                              ],
                            )
                          ],
                        ),
                      ),

                      new_availability_option==0 ?
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 20.0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'Rent(in Ksh)',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: rent_controller,

                                        decoration: InputDecoration(

                                          hintText: 'Rent(In Ksh)',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'Deposit(In Ksh)',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: deposit_controller,

                                        decoration: InputDecoration(

                                          hintText: 'Deposit(In Ksh)',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          )
                      )
                          : new_availability_option==1 ?
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 20.0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'Amount to be Paid(in Ksh)',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: rent_controller,

                                        decoration: InputDecoration(

                                          hintText: 'Amount to be paid(In Ksh)',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'Deposit(In Ksh)',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: deposit_controller,

                                        decoration: InputDecoration(

                                          hintText: 'Deposit(In Ksh)',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          )
                      ) : const SizedBox(),
                    //



                      Padding(
                        padding: EdgeInsets.only(top: 0.0,left: 0.0,right: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: is_rent_negotiable,
                              checkColor: Colors.white,
                              activeColor: AppConstants.thirdColor,
                              onChanged: (value){
                                setState(() {
                                  is_rent_negotiable=value!;
                                });
                              },
                            ),


                            RichText(
                              textAlign: TextAlign.left,
                              text:  TextSpan(
                                  text: new_availability_option==0 ? 'Rent is negotiable' : 'Amount is negotiable',
                                  style: TextStyle(color: Colors.black87,fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[

                                  ]
                              ),
                            )

                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text("Amenities",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black54
                          ),),
                        ),
                      ),


                      Padding(
                          padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Furnishing',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0,),
                                      child: Container(
                                        // color: Colors.white,
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0.0,1.0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 2.0,
                                                    color: AppConstants.thirdColor.withOpacity(0.2)
                                                  //  color: Colors.black12
                                                )]),
                                          child: FormField(
                                              builder: (FormFieldState state){
                                                return InputDecorator(

                                                    decoration:  InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                      //     labelStyle: textStyle,
                                                      errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      // labelText:'Select Bank',
                                                    ),
                                                    child:DropdownButtonHideUnderline(
                                                        child:DropdownButton(
                                                          value: furnishing_value,
                                                          isDense: true,
                                                          hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                            //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                          ),),

                                                          onChanged: (int? newValue){
                                                            furnishing_value=newValue;
                                                            state.didChange(newValue);


                                                          },
                                                          //  icon: null,
                                                          icon: const Icon(Icons.keyboard_arrow_down),
                                                          items:furnishings.map((value){
                                                            return DropdownMenuItem(
                                                              value: furnishings.indexOf(value),
                                                              child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                                fontSize: 12,fontWeight: FontWeight.w400,
                                                                //      fontFamily: GoogleFonts.openSans().fontFamily
                                                              ),),
                                                            );
                                                          }).toList(),
                                                        )
                                                    )
                                                );

                                              }
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Parking',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 2.0,
                                                  color: AppConstants.thirdColor.withOpacity(0.2)
                                                //  color: Colors.black12
                                              )]),
                                        child: FormField(
                                            builder: (FormFieldState state){
                                              return InputDecorator(

                                                  decoration:  InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    //     labelStyle: textStyle,
                                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    // labelText:'Select Bank',
                                                  ),
                                                  child:DropdownButtonHideUnderline(
                                                      child:DropdownButton(
                                                        value: parkings_value,
                                                        isDense: true,
                                                        hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                        ),),

                                                        onChanged: (int? newValue){
                                                          parkings_value=newValue;
                                                          state.didChange(newValue);


                                                        },
                                                        //  icon: null,
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        items:parkings.map((value){
                                                          return DropdownMenuItem(
                                                            value: parkings.indexOf(value),
                                                            child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                              fontSize: 12,fontWeight: FontWeight.w400,
                                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                                            ),),
                                                          );
                                                        }).toList(),
                                                      )
                                                  )
                                              );

                                            }
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'No of bedrooms',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: no_of_bedrooms_controller,

                                        decoration: InputDecoration(

                                          hintText: 'No of bedrooms',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child:Text(
                                      'No of bathrooms',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0.0,top: 0.0
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(color: Colors.transparent)
                                      ),
                                      child: TextFormField(
                                        controller: no_of_bathrooms_controller,

                                        decoration: InputDecoration(

                                          hintText: 'No of bathrooms',
                                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: BorderSide(color: Colors.grey.shade200)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Gated Security',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0,),
                                      child: Container(
                                        // color: Colors.white,
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0.0,1.0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 2.0,
                                                    color: AppConstants.thirdColor.withOpacity(0.2)
                                                  //  color: Colors.black12
                                                )]),
                                          child: FormField(
                                              builder: (FormFieldState state){
                                                return InputDecorator(

                                                    decoration:  InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                      //     labelStyle: textStyle,
                                                      errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                        borderRadius: BorderRadius.circular(16.0),
                                                      ),
                                                      // labelText:'Select Bank',
                                                    ),
                                                    child:DropdownButtonHideUnderline(
                                                        child:DropdownButton(
                                                          value: gated_security_value,
                                                          isDense: true,
                                                          hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                            //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                          ),),

                                                          onChanged: (int? newValue){
                                                            gated_security_value=newValue;
                                                            state.didChange(newValue);


                                                          },
                                                          //  icon: null,
                                                          icon: const Icon(Icons.keyboard_arrow_down),
                                                          items:gated_security.map((value){
                                                            return DropdownMenuItem(
                                                              value: gated_security.indexOf(value),
                                                              child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                                fontSize: 12,fontWeight: FontWeight.w400,
                                                                //      fontFamily: GoogleFonts.openSans().fontFamily
                                                              ),),
                                                            );
                                                          }).toList(),
                                                        )
                                                    )
                                                );

                                              }
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0 ),
                                      child: Text(
                                        'Power Backup',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.42,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 2.0,
                                                  color: AppConstants.thirdColor.withOpacity(0.2)
                                                //  color: Colors.black12
                                              )]),
                                        child: FormField(
                                            builder: (FormFieldState state){
                                              return InputDecorator(

                                                  decoration:  InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    //     labelStyle: textStyle,
                                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    // labelText:'Select Bank',
                                                  ),
                                                  child:DropdownButtonHideUnderline(
                                                      child:DropdownButton(
                                                        value: power_backup_value,
                                                        isDense: true,
                                                        hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                        ),),

                                                        onChanged: (int? newValue){
                                                          power_backup_value=newValue;
                                                          state.didChange(newValue);


                                                        },
                                                        //  icon: null,
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        items:power_backup.map((value){
                                                          return DropdownMenuItem(
                                                            value: power_backup.indexOf(value),
                                                            child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                              fontSize: 12,fontWeight: FontWeight.w400,
                                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                                            ),),
                                                          );
                                                        }).toList(),
                                                      )
                                                  )
                                              );

                                            }
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.0 ),
                                    child: Text(
                                      'Balcony',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0.0,),
                                    child: Container(
                                      // color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.80,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 2.0,
                                                  color: AppConstants.thirdColor.withOpacity(0.2)
                                                //  color: Colors.black12
                                              )]),
                                        child: FormField(
                                            builder: (FormFieldState state){
                                              return InputDecorator(

                                                  decoration:  InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                                    //     labelStyle: textStyle,
                                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppConstants.thirdColor.withOpacity(0.2)),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    // labelText:'Select Bank',
                                                  ),
                                                  child:DropdownButtonHideUnderline(
                                                      child:DropdownButton(
                                                        value: balcony_value,
                                                        isDense: true,
                                                        hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                                        ),),

                                                        onChanged: (int? newValue){
                                                          balcony_value=newValue;
                                                          state.didChange(newValue);


                                                        },
                                                        //  icon: null,
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        items:balcony.map((value){
                                                          return DropdownMenuItem(
                                                            value: balcony.indexOf(value),
                                                            child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                                              fontSize: 12,fontWeight: FontWeight.w400,
                                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                                            ),),
                                                          );
                                                        }).toList(),
                                                      )
                                                  )
                                              );

                                            }
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text("Image Uploads",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black54
                          ),),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  selectPhoto(ImageSource.gallery);
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16.0),

                                  ),
                                  child: _image==null ? const Center(
                                    child: Icon(CupertinoIcons.add,color: Colors.grey,size: 60,),
                                  ) : ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.file(_image!,width: 150,height: 150,fit: BoxFit.cover,),),
                                )

                            ),
                            GestureDetector(
                                onTap: (){
                                  selectPhoto1(ImageSource.gallery,);
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16.0),

                                  ),
                                  child: _image1==null  ? const Center(
                                    child: Icon(CupertinoIcons.add,color: Colors.grey,size: 60,),
                                  ) : ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.file(_image1!,width: 150,height: 150,fit: BoxFit.cover,),),
                                )

                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                selectPhoto2(ImageSource.gallery);
                              },
                              child:
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16.0),

                                ),
                                child: _image2 == null ? const Center(
                                  child: Icon(CupertinoIcons.add,color: Colors.grey,size: 60,),
                                ) :  ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.file(_image2!,width: 150,height: 150,fit: BoxFit.cover,),),
                              ),
                            ),
                            GestureDetector(
                                onTap: (){
                                  selectPhoto3(ImageSource.gallery);
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16.0),

                                  ),
                                  child: _image3 == null ? const Center(
                                    child: Icon(CupertinoIcons.add,color: Colors.grey,size: 60,),
                                  ) : ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.file(_image3!,width: 150,height: 150,fit: BoxFit.cover,),),
                                )
                            ),
                          ],
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () async{
                              setState(() {
                                message='Creating property.please wait...';
                                isLoading=true;
                              });

                              var result = await update_property();
                              setState(() {
                                isLoading=false;
                                message='';
                              });

                              if(result is int && result==200){
                                notificationContainer.showNotificationDialog(
                                    'Property  has been update successfully.', context, (){
                                  Navigator.pushNamedAndRemoveUntil(context,'/ownerdashboard', (Route<dynamic> route) => false);

                                });
                              }

                              else{
                                errorContainer.showInfoErrorDialog('Could not create property.Please try again', context, (){
                                  Navigator.pop(context);
                                });
                              }

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                ),
                                borderRadius: BorderRadius.circular(16.0),

                              ),
                              child: Center(
                                child: Text("Update Property",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          )
                      )

                    ],
                  ),
                )
            ),
          ),
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressContainer(
              message: message,
            ),
          ),
        )    : SizedBox()
      ],
    );
  }

  Future selectPhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future selectPhoto1(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future selectPhoto2(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future selectPhoto3(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future<dynamic> update_property() async{


    Property property = Property(
        id: widget.property!.id, apartment_type: apartment_type.elementAt(apartment_type_value!),
        bhk_type: bhk_types.elementAt(bhk_type_value!),
        property_name: master_name_controller.text, property_price: rent_controller.text,
        no_of_bedrooms:no_of_bedrooms_controller.text,
        no_of_bathrooms: no_of_bathrooms_controller.text,
        balcony: balcony_value!.toString(),
        possession: 'Owner',
        power_backup: power_backup.elementAt(power_backup_value!),
        landlord_id: 0,
        property_master_id: widget.property!.property_master_id);

    /*PropertyDescription propertyDescription = PropertyDescription(
        id: widget.property!.property_description.elementAt(0).id, description: property_description_controller.text, property_id: 0);*/
    /*PropertyOverview propertyOverview = PropertyOverview(
        id: widget.property!.property_overviews.elementAt(0).id,
        age_of_building: age_of_building.elementAt(age_value!),
        total_floor: floors.elementAt(floor_value!),
        plot_area: 'Area',
        parking: parkings.elementAt(parkings_value!),
        floor: floors.elementAt(floor_value!),
        facing: facings.elementAt(facings_value!),
        ownership_type: 'Owner',
        builtup_area: builtup_area_controller.text,
        furnishing_status: furnishings.elementAt(furnishing_value!),
        gated_security: gated_security.elementAt(gated_security_value!),
        property_id: widget.property!.id,
        expected_availability:  availability_option!, expected_rent: double.parse(rent_controller.text),
        expected_deposit: double.parse(deposit_controller.text),
        rent_negotiable: is_rent_negotiable ? 1 : 0,
        created_at: '', updated_at: '');

    PropertyLocation propertyLocation = PropertyLocation(
        id: widget.property!.property_location.elementAt(0).id,
        city: master_location_controller.text,
        locality: master_location_controller.text,
        landmark_street: master_location_controller.text,
        property_id: widget.property!.id);

    List<File?> images=[];
    if(_image!=null){
      images.add(_image);
    }

    if(_image1!=null){
      images.add(_image1!);
    }

    if(_image2!=null){
      images.add(_image2);
    }

    if(_image3!=null){
      images.add(_image3);
    }

    String token = Provider.of<Preferences>(context,
        listen: false).user!.remember_token;

    propertyDescription.property_id = widget.property!.id;
    propertyOverview.property_id= widget.property!.id;
    propertyLocation.property_id=widget.property!.id;
      var savePropertyDetails = await propertyRepository.updateProperty(property, token,
          Provider.of<Preferences>(context,listen: false).user!.user_id).then((value1) async{



          var result1 = await propertyRepository.updatePropertyDescription(propertyDescription, token);
          var result2 = await propertyRepository.updatePropertyOverview(propertyOverview, token);
          var result3 = await propertyRepository.updatePropertyLocation(propertyLocation, token);


          return value1;
      });

      return savePropertyDetails;*/
  }

  setData(){
    apartment_type_value=apartment_type.indexOf(widget.property!.apartment_type.toString());
    parkings_value=parkings.indexOf(widget.property!.property_overviews.elementAt(0).parking);
    bhk_type_value=bhk_types.indexOf(widget.property!.bhk_type);
    floor_value=floors.indexOf(widget.property!.property_overviews.elementAt(0).floor);
    availability_option=widget.property!.property_overviews.elementAt(0).expected_availability.contains('rent') ?
        'rent':'lease';
    new_availability_option=availability_option=='rent' ? 0 : 1;
    is_rent_negotiable=widget.property!.property_overviews.elementAt(0).rent_negotiable==1 ? true : false;
  }


}

