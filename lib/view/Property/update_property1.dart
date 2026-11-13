import 'package:flutter/material.dart';
import 'package:somalease/widget/circular_progress_container.dart';
import 'package:somalease/widget/module.dart';
import '../../services/module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class UpdateProperty1 extends StatefulWidget{
  UpdateProperty1({Key? key,required this.property}) : super(key: key);
   Property? property;

  @override
  _UpdateProperty1State createState()=> _UpdateProperty1State();
}

class _UpdateProperty1State extends State<UpdateProperty1>{


  TextEditingController master_name_controller=TextEditingController(text: '');
  TextEditingController master_location_controller = TextEditingController(text: '');
  TextEditingController property_description_controller = TextEditingController(text: '');
  TextEditingController builtup_area_controller = TextEditingController(text: '');
  TextEditingController carpet_area_controller = TextEditingController(text: '');
  TextEditingController rent_controller = TextEditingController(text: '');
  TextEditingController deposit_controller = TextEditingController(text: '');
  TextEditingController no_of_bedrooms_controller = TextEditingController(text: '');
  TextEditingController no_of_bathrooms_controller = TextEditingController(text: '');
  TextEditingController address_controller = TextEditingController(text: '');
  TextEditingController street_address_controller = TextEditingController(text: '');
  TextEditingController address_line2_controller = TextEditingController(text: '');
  TextEditingController postal_code_controller = TextEditingController(text: '');
  TextEditingController service_charge_fee_controller = TextEditingController(text: '');
  TextEditingController available_from_controller = TextEditingController(text: '');
  TextEditingController description_controller = TextEditingController(text: '');
  TextEditingController balcony_controller = TextEditingController(text: '');
  TextEditingController viewing_time_from_controller = TextEditingController(text: '');
  TextEditingController viewing_time_to_controller = TextEditingController(text: '');
  TextEditingController contact_person_controller = TextEditingController(text: '');
  TextEditingController contact_person1_controller = TextEditingController(text: '');
  TextEditingController phone_controller=TextEditingController(text: '');
  String property_name='';
  String listing_name='';
  List<File> images=[];


  DateTime available_from_date=DateTime.now();
  TimeOfDay viewing_time_from=TimeOfDay.now();
  TimeOfDay viewing_time_to=TimeOfDay.now();

  List<String> bhk_types=["Studio","+2BHK","+4BHK","+5BHK","+6BHK"];
  List<String> city_types=["Nairobi","Mombasa","Kisumu","Eldoret"];
  List<String> area_types=["Nairobi West","Kilimani","Syokimau","Nakuru"];
  List<String> listing_types=["Residential","Commercial","Land/Plot"];
  List<String> apartment_type=["Apartment","Independent House/Villa","Gated Community/Villa"];
  List<String> floors=["1","2","3","4","5","6","7","8","9","10","10+"];
  List<String> total_floors=["1","2","3","4","5","6","7","8","9","10","10+"];
  List<String> age_of_building=["0-3yrs","3-5 yrs","6-10yrs","Above 10yrs"];
  List<String> facings=["North","South","East","West"];
  List<String> parkings=["Bike","Car","Both","None"];
  List<String> furnishings=["Fully-Furnished","Semi-Furnished","Unfurnished"];
  //List<String> gated_security=["Yes","No"];
  List<String> power_backup =["Yes","No"];
  //List<String> balcony = ["Available","Not Available"];
  List<String> step_text=["Step 1 of 7 - Property Listing Type","Step 2 of 7 - Property Details",
    "Step 3 of 7 - Location Details","Step 4 of 7 - Rent and Availability","Step 5 of 7 - Amenities and Utility",
    "Step 6 of 7 - Viewings","Step 7 of 7 - Property Images"];
  List<String> preferred_tenants=["Family","No Preference"];
  List<String> service_charges=["Included in rent","Additional Charge"];
  List<String> water_supply=["Government","Borehole","Both"];
  List<String> electricity=["Prepaid(token)","Postpaid"];
  List<String> other_amenities=["Air Conditioner","Club","Gas"];
  List<String> viewing_days=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  List<File?> image_uploads=[];

  int? apartment_type_value=0,bhk_type_value=0,floor_value=0,age_value=0,facings_value=0,parkings_value=0,
      furnishing_value=0,gated_security_value=0,power_backup_value=0,balcony_value=0,
      city_type_value=0,area_type_value=0,listing_type_value=0,preferred_tenant_value=0,total_floors_value=0,
      service_charge_value=0,water_supply_value=0,electricity_value=0;
  int new_availability_option=0;
  String availability_option='';
  String non_veg='',gated_security='',gym='';

  bool is_rent_negotiable=false;
  File? _image,_image1,_image2,_image3;
  final picker = ImagePicker();
  bool isLoading=false,isSaving=false;
  ErrorContainer errorContainer = ErrorContainer();
  NotificationContainer notificationContainer = NotificationContainer();

  PropertyRepository propertyRepository = PropertyRepository();
  String message='';double division=1;
  double current_step=24;
  double progress_value=1;
  List<bool> other_amenities_status=[],viewing_status=[],listing_status=[];
  String saving_message='Saving data';
  bool onCurrentLocation=true;
  bool isAbsorbPointer=true;
  bool new_location_selected=true;
  TextEditingController searchController= TextEditingController();
  bool isMap=false;
  bool isLocationChosen=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
    //setButtonStatus();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: /*Text('Property Ad',style: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppConstants.primaryColor
        ),),*/
            Column(
              children: [
                /* Padding(
              padding: ,
            ),*/
                Padding(
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: Text(step_text.elementAt(division.floor()-1),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),
                Container(
                    width: 168,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade200
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: current_step * division ,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                              )
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
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
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        division==1 ?
                        listingTypeContainer() :

                        division== 2 ?
                        propertyDetails() :

                        division==3 ?
                        locationDetails():
                        division==4 ?
                        rentAndAvailability():
                        division==5 ?
                        amenitiesContainer() :
                        division==6  ?
                        viewingContainer() :
                        division==7 ?
                        uploadsContainer() :
                        SizedBox(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                division==1 ?
                                SizedBox():
                                Padding(
                                    padding: EdgeInsets.only(top: 0.0,bottom: 40.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        previousData();
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Center(
                                          child: Text("Previous",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.grey.shade700
                                          ),),
                                        ),
                                      ),
                                    )
                                )
                                ,
                                Padding(
                                    padding: EdgeInsets.only(top: 0.0,bottom: 40.0),
                                    child: division==7 ? GestureDetector(
                                      onTap: () async{
                                        setState(() {
                                          saving_message='Posting Property.Please wait...';
                                          isSaving=true;
                                        });
                                        var result = await updateProperty();
                                        setState(() {
                                          isSaving=false;
                                          saving_message='';
                                        });

                                        if(result is Property){
                                          notificationContainer.showNotificationDialog(
                                              'Property  been submitted successfully.', context, (){
                                            Navigator.pop(context);
                                            Navigator.pop(context,1);

                                          });
                                        }

                                        else{
                                          errorContainer.showInfoErrorDialog('Could not create property.Please try again', context, (){
                                            Navigator.pop(context);
                                          });
                                        }
                                        //setNextData();
                                        //  String value=getReducedValue();
                                        //  print("Reduced is " + value);
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                            )
                                          // border: Border.all(color: AppConstants.primaryColor)
                                        ),
                                        child: Center(
                                          child: Text("Update Listing",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ) :
                                    GestureDetector(
                                      onTap: (){
                                        /* if(division==4){
                                       // String result = calculatePossessionPeriod(available_from_controller.text);
                                        String result = dateToFormat(available_from_controller.text);
                                        print("result: " + result.toString());
                                      }

                                      else{
                                        setNextData();
                                      }*/

                                        setNextData();
                                        //   setPropertyName();
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                            )
                                          // border: Border.all(color: AppConstants.primaryColor)
                                        ),
                                        child: Center(
                                          child: Text("Next",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  )
              )
          ),
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorDark),
            ),
          ),
        )    :
        isSaving ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressContainer(
              message: saving_message,
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }

  Widget listingTypeContainer(){
    return  Padding(
      padding: EdgeInsets.only(bottom: 50.0,left: 20.0,right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Property Name",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: master_name_controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
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
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    // color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                      child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(

                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  //     labelStyle: textStyle,
                                  errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  // labelText:'Select Bank',
                                ),
                                child:DropdownButtonHideUnderline(
                                    child:DropdownButton(
                                      value: city_type_value,
                                      isDense: true,
                                      hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                        //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                      ),),

                                      onChanged: (int? newValue){
                                        city_type_value=newValue;
                                        state.didChange(newValue);


                                      },
                                      //  icon: null,
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                      items:city_types.map((value){
                                        return DropdownMenuItem(
                                          value: city_types.indexOf(value),
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
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Container(
                    // color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                      child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(

                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  //     labelStyle: textStyle,
                                  errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  // labelText:'Select Bank',
                                ),
                                child:DropdownButtonHideUnderline(
                                    child:DropdownButton(
                                      value: area_type_value,
                                      isDense: true,
                                      hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                        //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                      ),),

                                      onChanged: (int? newValue){
                                        area_type_value=newValue;
                                        state.didChange(newValue);


                                      },
                                      //  icon: null,
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                      items:area_types.map((value){
                                        return DropdownMenuItem(
                                          value: area_types.indexOf(value),
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
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Listing Type",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listing_types.asMap().map((index, element){
                  return MapEntry(index,
                      Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: (){
                              setListingStatus(index);
                            },
                            child: Container(
                              width: 90,
                              height: 48,
                              decoration:
                              listing_status[index] ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              )
                                  : BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8.0)

                              ),
                              child: Center(
                                child: Text(element,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: listing_status[index] ?Colors.white : Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ));
                }).values.toList()
            ),
          )
        ],
      ),
    );
  }

  Widget propertyDetails(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Property Type",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 30.0),
            child: Container(
              // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                child: FormField(
                    builder: (FormFieldState state){
                      return InputDecorator(

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            //     labelStyle: textStyle,
                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
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
                                icon: const Icon(Icons.keyboard_arrow_down,size: 15,),
                                items:apartment_type.map((value){
                                  return DropdownMenuItem(
                                    value: apartment_type.indexOf(value),
                                    child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                      fontSize: 14,fontWeight: FontWeight.w400,
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

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Preferred Tenant",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 30.0),
            child: Container(
              // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                child: FormField(
                    builder: (FormFieldState state){
                      return InputDecorator(

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            //     labelStyle: textStyle,
                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            // labelText:'Select Bank',
                          ),
                          child:DropdownButtonHideUnderline(
                              child:DropdownButton(
                                value: preferred_tenant_value,
                                isDense: true,
                                hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                  //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                ),),

                                onChanged: (int? newValue){
                                  preferred_tenant_value=newValue;
                                  state.didChange(newValue);


                                },
                                //  icon: null,
                                icon: const Icon(Icons.keyboard_arrow_down,size: 15,),
                                items:preferred_tenants.map((value){
                                  return DropdownMenuItem(
                                    value: preferred_tenants.indexOf(value),
                                    child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                      fontSize: 14,fontWeight: FontWeight.w400,
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

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("BHK Type",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 30.0),
            child: Container(
              // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                child: FormField(
                    builder: (FormFieldState state){
                      return InputDecorator(

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            //     labelStyle: textStyle,
                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
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
                                icon: const Icon(Icons.keyboard_arrow_down,size: 15,),
                                items:bhk_types.map((value){
                                  return DropdownMenuItem(
                                    value: bhk_types.indexOf(value),
                                    child:Text(value,style: TextStyle(color: Colors.grey.shade600,
                                      fontSize: 14,fontWeight: FontWeight.w400,
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

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("BuiltUp Area(sq.ft)",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: builtup_area_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Carpet Area(sq.ft)",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: carpet_area_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Floor",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Container(
                          // color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                            child: FormField(
                                builder: (FormFieldState state){
                                  return InputDecorator(

                                      decoration:  InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                        //     labelStyle: textStyle,
                                        errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
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
                                            icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
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
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Total Floors",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),),
                        ),
                        Container(
                          // color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                            child: FormField(
                                builder: (FormFieldState state){
                                  return InputDecorator(

                                      decoration:  InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                        //     labelStyle: textStyle,
                                        errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        // labelText:'Select Bank',
                                      ),
                                      child:DropdownButtonHideUnderline(
                                          child:DropdownButton(
                                            value: total_floors_value,
                                            isDense: true,
                                            hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                              //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                            ),),

                                            onChanged: (int? newValue){
                                              total_floors_value=newValue;
                                              state.didChange(newValue);


                                            },
                                            //  icon: null,
                                            icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                            items:total_floors.map((value){
                                              return DropdownMenuItem(
                                                value: total_floors.indexOf(value),
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
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget locationDetails(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          GestureDetector(
            onTap: (){
              print("The clicked map is " + isMap.toString());
              if(isMap==false){
                setState(() {
                  isMap=true;

                });
                setLocationChosen(false);
                setIsAbsorbPointer(false);
              }
            },
            child: MapContainer(
              searchController: searchController,
              //  isMap: isMap,
              isMap: getIsMap(),
              currentLocation: onCurrentLocation,
              onCurrentLocation: (location){
                onCurrentLocation=location;
                print("Current location changed to " + onCurrentLocation.toString());
              },
              isAbsorbPointer: isAbsorbPointer,
              new_location_selected: new_location_selected,
              isLocationChosen: isLocationChosen,
              type: 1,
              //  address: Address(location: Provider.of<Preferences>(context,listen: false).current_location),
              onTap: (changed) async{

                setState(() {

                  isMap=changed;
                  isAbsorbPointer=true;
                  isLocationChosen=true;
                  setLocationDetails();

                  print("Search Controller text is " + isMap.toString());
                });
              },
            ),
          ),
          isLocationChosen==true ?

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Address",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: address_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Street Address",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: street_address_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Address Line 2",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: address_line2_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Zip/Postal Code",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: postal_code_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )   :
          const SizedBox()


        ],
      ),
    );
  }

  Widget rentAndAvailability(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Property available for ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          new_availability_option=0;
                          availability_option='rent';
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 48,
                        decoration: availability_option=='rent' ?
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                            )
                        ):
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey.shade100,
                        ),
                        child: Center(
                          child: Text('Rent Only',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: availability_option=='rent'? Colors.white : Colors.grey.shade700
                          ),),
                        ),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          new_availability_option=1;
                          availability_option='lease';
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 48,
                        decoration: availability_option=='lease' ?
                        BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                            )
                        ):
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey.shade100,
                        ),
                        child: Center(
                          child: Text('Lease Only',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: availability_option=='lease' ? Colors.white: Colors.grey.shade700
                          ),),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),


          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Expected Rent",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: rent_controller,
                decoration: InputDecoration(
                  hintText: 'KES Per Month',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    is_rent_negotiable=!is_rent_negotiable;
                  });
                },
                child: Container(
                  width: 120,
                  height: 48,
                  decoration: is_rent_negotiable ?
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                      )
                  ):
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey.shade100,
                  ),
                  child: Center(
                    child: Text('Negotiable',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: is_rent_negotiable ? Colors.white : Colors.grey.shade700
                    ),),
                  ),
                ),
              )
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Expected deposit",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: deposit_controller,
                decoration: InputDecoration(
                  hintText: 'KES Amount',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(top: 0.0,bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Service Charge",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade700
                    ),),
                  ),
                  Container(
                    // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                      child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(

                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  //     labelStyle: textStyle,
                                  errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  // labelText:'Select Bank',
                                ),
                                child:DropdownButtonHideUnderline(
                                    child:DropdownButton(
                                      value: service_charge_value,
                                      isDense: true,
                                      hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                        //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                      ),),

                                      onChanged: (int? newValue){
                                        service_charge_value=newValue;
                                        state.didChange(newValue);


                                      },
                                      //  icon: null,
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                      items:service_charges.map((value){
                                        return DropdownMenuItem(
                                          value: service_charges.indexOf(value),
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
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Service Charge Fee",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: service_charge_fee_controller,
                decoration: InputDecoration(
                  hintText: 'Service charge fee',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade400
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),

          /* Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.grey.shade100,
            ),
            child: TextFormField(
              controller: address_line2_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),*/

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Available from",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: (){
                  _selectDate(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Container(
                        width: 120,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey.shade100,
                        ),
                        child: TextFormField(
                          controller: available_from_controller,
                          enabled: false,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700
                          ),
                          decoration: InputDecoration(
                            hintText: 'dd/mm/yyyy',
                            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade400
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.calendar,color: Colors.black,
                    )
                  ],
                ),
              )
          ),

          Padding(
              padding: EdgeInsets.only(top: 0.0,bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Furnishing",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade700
                    ),),
                  ),
                  Container(
                    // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                      child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(

                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  //     labelStyle: textStyle,
                                  errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
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
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
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
                ],
              )
          ),

          Padding(
              padding: EdgeInsets.only(top: 0.0,bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Parking",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade700
                    ),),
                  ),
                  Container(
                    // color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                      child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(

                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                  //     labelStyle: textStyle,
                                  errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
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
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
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
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Property Description",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade100,
              ),
              child: TextFormField(
                controller: description_controller,
                maxLines: 4,
                minLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget amenitiesContainer(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Bedroom(s)",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: no_of_bedrooms_controller,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade400
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text("Bathroom(s)",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        width: 120,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey.shade100,
                        ),
                        child: TextFormField(
                          controller: no_of_bathrooms_controller,
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade400
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text("Balcony(s)",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Container(
                        width: 120,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey.shade100,
                        ),
                        child: TextFormField(
                          controller: balcony_controller,
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade400
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Non Veg Allowed ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                non_veg='Yes';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: non_veg=='Yes' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('Yes',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: non_veg=='Yes' ? Colors.white : Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                non_veg='No';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: non_veg=='No' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('No',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: non_veg=='No' ? Colors.white: Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Gated Security ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                gated_security='Yes';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: gated_security=='Yes' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('Yes',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: gated_security=='Yes' ? Colors.white : Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                gated_security='No';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: gated_security=='No' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('No',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: gated_security=='No' ? Colors.white: Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Gym ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                gym='Yes';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: gym=='Yes' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('Yes',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: gym=='Yes' ? Colors.white : Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                gym='No';
                              });
                            },
                            child: Container(
                              width: 120,
                              height: 48,
                              decoration: gym=='No' ?
                              BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                  )
                              ):
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                child: Text('No',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: gym=='No' ? Colors.white: Colors.grey.shade700
                                ),),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Water Supply",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 30.0),
            child: Container(
              // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                child: FormField(
                    builder: (FormFieldState state){
                      return InputDecorator(

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            //     labelStyle: textStyle,
                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            // labelText:'Select Bank',
                          ),
                          child:DropdownButtonHideUnderline(
                              child:DropdownButton(
                                value: water_supply_value,
                                isDense: true,
                                hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                  //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                ),),

                                onChanged: (int? newValue){
                                  water_supply_value=newValue;
                                  state.didChange(newValue);


                                },
                                //  icon: null,
                                icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                items:water_supply.map((value){
                                  return DropdownMenuItem(
                                    value: water_supply.indexOf(value),
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
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Electricity",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),

          Padding(
            padding: EdgeInsets.only(top: 0.0,bottom: 40.0),
            child: Container(
              // color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  /*boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.0,1.0),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                          color: AppConstants.thirdColor.withOpacity(0.2)
                        //  color: Colors.black12
                      )]*/),
                child: FormField(
                    builder: (FormFieldState state){
                      return InputDecorator(

                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            //     labelStyle: textStyle,
                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            // labelText:'Select Bank',
                          ),
                          child:DropdownButtonHideUnderline(
                              child:DropdownButton(
                                value: electricity_value,
                                isDense: true,
                                hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                  //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                ),),

                                onChanged: (int? newValue){
                                  electricity_value=newValue;
                                  state.didChange(newValue);


                                },
                                //  icon: null,
                                icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                                items:electricity.map((value){
                                  return DropdownMenuItem(
                                    value: electricity.indexOf(value),
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

          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Other Amenities",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),


          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: other_amenities.asMap().map((index, element){
                return MapEntry(index,
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            //setAmenitiesStatus(index);
                            setState(() {
                              other_amenities_status[index]=!other_amenities_status[index];
                            });
                          },
                          child: Container(
                            width: 120,
                            height: 48,
                            decoration: other_amenities_status[index] ?
                            BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                )
                            ):
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.grey.shade100,
                            ),
                            child: Center(
                              child: Text(element,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: other_amenities_status[index] ? Colors.white : Colors.grey.shade700
                              ),),
                            ),
                          ),
                        )
                    ));
              }).values.toList(),
            ),
          )
        ],),
    );
  }

  Widget viewingContainer(){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Available for viewing on the following days",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child:  Container(
                width: MediaQuery.of(context).size.width * 0.70,
                // height: MediaQuery.of(context).size.height * 0.35,
                // color: Colors.black,
                child: GridView.builder(itemCount:  viewing_days.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 50,
                      ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                      maxCrossAxisExtent: 150/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemBuilder: (context,index){

                    return GestureDetector(
                        onTap: (){
                          /*setState(() {
                            viewing_days
                          });*/

                          setState(() {
                            viewing_status[index]=!viewing_status[index];
                          });
                        },
                        child: Container(
                          decoration: viewing_status[index] ?
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                              )
                          ):
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.grey.shade100,
                          ),
                          child: Center(
                            child: Text(viewing_days.elementAt(index),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: viewing_status[index] ? Colors.white : Colors.grey.shade700
                            ),),
                          ),
                        )
                    );
                  },
                )
            ),
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                            onTap: (){
                              _selectFromTime(context);
                            },
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text("From",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey.shade700,fontWeight: FontWeight.normal
                                  ),),
                                ),
                                Container(
                                  width: 140,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: TextFormField(
                                    controller: viewing_time_from_controller,
                                    enabled: false,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.grey.shade700,fontSize: 12
                                    ),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: '--:--',
                                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade400
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        suffixIcon: Icon(CupertinoIcons.time,color: Colors.grey,)
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                            onTap: (){
                              _selectToTime(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Text("To",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey.shade700,fontWeight: FontWeight.normal
                                  ),),
                                ),
                                Container(
                                  width: 140,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: TextFormField(
                                    controller: viewing_time_to_controller,
                                    enabled: false,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.grey.shade700,fontSize: 12
                                    ),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: '--:--',
                                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade400
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        suffixIcon: Icon(CupertinoIcons.time,color: Colors.grey,)
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0,right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("Contact Person",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade700
                        ),),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.grey.shade100,
                          ),
                          child: TextFormField(
                            controller: contact_person_controller,
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade700
                        ),),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.grey.shade100,
                          ),
                          child: TextFormField(
                            controller: contact_person1_controller,
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60.0,right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text("Phone",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: phone_controller,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade400
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],),
    );
  }

  Widget uploadsContainer(){
    return Padding(
      padding: EdgeInsets.only(bottom: 70.0,left: 20.0,right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text("Upload Photos",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: (){
                  selectPhoto(ImageSource.gallery);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(
                          //color: Colors.black,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(
                          child: Text("Choose File",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black
                          ),),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text("Max file size: 2 MB",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700,fontSize: 14
            ),),
          ),

          image_uploads.isNotEmpty ?
          Column(
            children: image_uploads.asMap().map((index, element){
              return MapEntry(index,Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(element!.path.split('/').last.toString(),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700
                            ),),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                image_uploads.remove(element);
                              });
                            },
                            icon: Icon(CupertinoIcons.clear,),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
            }).values.toList(),
          ) : SizedBox(),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text("Upload Videos",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16.0)
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 35,
                    decoration: BoxDecoration(
                      //color: Colors.black,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("Choose File",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black
                      ),),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text("Max file size: 2 MB",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700,fontSize: 14
            ),),
          ),
        ],
      ),
    );
  }

  setPropertyName(){

    if(listing_status.any((element) => element==true)){
      listing_name=listing_types.elementAt(listing_status.indexWhere((element) => element==true));
      print("Listing name is :" + listing_name);
    }

    property_name=bhk_types.elementAt(bhk_type_value!).toString() +' ' +  listing_name + ' for ' +
        availability_option + ' in ' + address_controller.text;
    print("The property name is " + property_name);
  }

  Future<dynamic> updateProperty() async{
    setPropertyName();
    PropertyMaster propertyMaster = PropertyMaster(
        id: widget.property!.propertyMaster!.id,
        property_master_name: master_name_controller.text,
        //property_master_name: property_name,
        property_master_location: address_controller.text,
        property_listing_type: listing_name,
        status: '',created_at: '',finished_at: '');

    Property property = Property(
        id: widget.property!.id, apartment_type: apartment_type.elementAt(apartment_type_value!),
        bhk_type: bhk_types.elementAt(bhk_type_value!),
        property_name: property_name, property_price: rent_controller.text,
        no_of_bedrooms:no_of_bathrooms_controller.text,
        no_of_bathrooms: no_of_bathrooms_controller.text,
        balcony: balcony_value!.toString(),
        possession: calculatePossessionPeriod(available_from_controller.text),
        power_backup: power_backup.elementAt(power_backup_value!),
        landlord_id: widget.property!.landlord_id,
        property_master_id: widget.property!.propertyMaster!.id);

    PropertyDescription propertyDescription = PropertyDescription(
        id: widget.property!.property_description.elementAt(0).id,
        description: description_controller.text,
        property_id: widget.property!.id,
        carpet_area: carpet_area_controller.text,
        availability_date: dateToFormat(available_from_controller.text),
        // availability_date: available_from_controller.text,
        electricity: electricity.elementAt(electricity_value!),
        gym: gym=='Yes' ? 1 : 0,
        non_veg_allowed: non_veg=='Yes' ? 1 : 0,
        preferred_tenant: preferred_tenants.elementAt(preferred_tenant_value!),
        service_charge: service_charges.elementAt(service_charge_value!),
        service_charge_fee: int.parse(service_charge_fee_controller.text),
        water_supply: water_supply.elementAt(water_supply_value!),
        other_amenities: getReducedValue()
    );
    PropertyOverview propertyOverview = PropertyOverview(
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
        gated_security: gated_security.isEmpty ? "No" : gated_security,
        property_id: widget.property!.id,
        expected_availability:  availability_option,
        expected_rent: double.parse(rent_controller.text),
        expected_deposit: double.parse(deposit_controller.text),
        rent_negotiable: is_rent_negotiable ? 1 : 0,
        created_at: '', updated_at: '');

    PropertyLocation propertyLocation = PropertyLocation(
        id: widget.property!.property_location.elementAt(0).id,
        city: address_controller.text,
        locality: address_controller.text,
        landmark_street: address_controller.text,
        property_id: widget.property!.id,
        address: address_controller.text,
        street_address: street_address_controller.text,
        address_line_2: address_line2_controller.text,
        postal_code: postal_code_controller.text
    );

    List<PropertyDay> property_days=[];

    viewing_days.asMap().forEach((index, element){
      if(viewing_status[index]){
        PropertyDay day=PropertyDay(
            id: 0, viewing_day: element, from_time: viewing_time_from_controller.text,
            to_time: viewing_time_to_controller.text,
            contact_person: contact_person_controller.text,
            phone: phone_controller.text,
            property_id: widget.property!.id);
        property_days.add(day);
      }
    });

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
    var result = await propertyRepository.updatePropertyMaster(propertyMaster,token ).then((value) async{
      if(value is PropertyMaster){
        property.property_master_id= value.id;
        var savePropertyDetails = await propertyRepository.updateProperty(property, token,
            Provider.of<Preferences>(context,listen: false).user!.user_id).then((value1) async{
          if(value1 is Property){
          //  propertyDescription.property_id = value1.id;
          //  propertyOverview.property_id= value1.id;
          //  propertyLocation.property_id=value1.id;

            var result1 = await propertyRepository.updatePropertyDescription(propertyDescription, token);
            var result2 = await propertyRepository.updatePropertyOverview(propertyOverview, token);
            var result3 = await propertyRepository.updatePropertyLocation(propertyLocation, token);

            print("The size of images is " + images.length.toString());
           /* images.forEach((element) async{
              var result4= await propertyRepository.addPropertyImage(element, value1.id, token);
            });

            property_days.forEach((element) async{
              element.property_id=value1.id;
              var result5= await propertyRepository.addPropertyDays(element, token);
            });*/



            return value1;
          }

          else{
            return value1;
          }
        });

        return savePropertyDetails;
      }

      else{
        return value;
      }
    });

    return result;

  }

  setNextData(){
    if(division==1){
      setState(() {
        division++;
      });
    }

    else{
      setState(() {
        division++;
      });
    }
  }

  previousData(){
    setState(() {
      division--;
    });
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: available_from_date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.white,
                  onPrimary: AppConstants.primaryColorDark,
                  surface: AppConstants.primaryColorDark,
                  onSurface: Colors.white,
                ),
                //dialogBackgroundColor: Colors.blue[500],
                dialogBackgroundColor: AppConstants.primaryColorDark
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      available_from_date = newSelectedDate;
      //  date_from= DateFormat.yMMMd().format(_selectedDate);
      //DateFormat date_format= DateFormat("yyyy-MM-dd 00:00:00");
      DateFormat date_format=DateFormat("dd/MM/yyyy");
      setState((){
        available_from_controller.text=date_format.format(available_from_date);
      });
      print("The date is " + available_from_controller.text);

    }
  }

  _selectFromTime(BuildContext context) async {


    TimeOfDay? newSelectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.white,
                  onPrimary: AppConstants.primaryColorDark,
                  surface: AppConstants.primaryColorDark,
                  onSurface: Colors.white,
                ),
                //dialogBackgroundColor: Colors.blue[500],
                dialogBackgroundColor: AppConstants.primaryColorDark
            ),
            child: child!,
          );
        });

    if (newSelectedTime != null) {

      print("Time: " + newSelectedTime.format(context).toString());
      //   DateTime parsedTime = DateFormat.jm().parse(newSelectedTime.format(context).toString());
      // DateTime parsedTime = DateFormat("HH:mm:ss").parse(newSelectedTime.format(context).toString());
      final now = DateTime.now();
      DateTime parsedTime= DateTime(now.year, now.month, now.day,newSelectedTime.hour,newSelectedTime.minute);
      DateFormat date_format=DateFormat("HH:mm:ss");
      setState((){
        viewing_time_from_controller.text=date_format.format(parsedTime);
      });
      print("The date is " + viewing_time_from_controller.text);

    }
  }

  _selectToTime(BuildContext context) async {


    TimeOfDay? newSelectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.white,
                  onPrimary: AppConstants.primaryColorDark,
                  surface: AppConstants.primaryColorDark,
                  onSurface: Colors.white,
                ),
                //dialogBackgroundColor: Colors.blue[500],
                dialogBackgroundColor: AppConstants.primaryColorDark
            ),
            child: child!,
          );
        });

    if (newSelectedTime != null) {
      // DateTime parsedTime = DateFormat.jm().parse(newSelectedTime.format(context).toString());
      DateFormat date_format=DateFormat("HH:mm:ss");
      final now = DateTime.now();
      DateTime parsedTime= DateTime(now.year, now.month, now.day,newSelectedTime.hour,newSelectedTime.minute);
      setState((){
        viewing_time_to_controller.text=date_format.format(parsedTime);
      });
      print("The date is " + viewing_time_to_controller.text);


    }
  }

  setButtonStatus(){
    other_amenities_status=List.filled(other_amenities.length,false);
    viewing_status=List.filled(viewing_days.length, false);
    listing_status=List.filled(listing_types.length,false);
  }

  String calculatePossessionPeriod(String availability_period){
    String new_date=availability_period.substring(6,10) + "-" + availability_period.substring(3,5) +
        "-" + availability_period.substring(0,2);

    // print("New date is " + new_date);
    //   return new_date;
    DateTime new_date_time= DateTime.parse(new_date);

    DateTime current_date_time = DateTime.now();

    Duration duration = current_date_time.difference(new_date_time);
    int day=0;

    if(new_date_time.isAfter(current_date_time)){
      day=duration.inDays.abs();
    }

    else{
      day=duration.inDays;
    }


    print("day is " + day.toString());
    if(day <= 1){
      return "Immediately";
    }

    else if(day > 1 && day <= 15){
      return "Within 15 Days";
    }

    else if(day > 15 && day <=30){
      return "Within 30 Days";
    }

    else if(day > 30){
      return "After 30 Days";
    }

    else{
      return "After 30 Days";
    }
  }

  /*setAmenitiesStatus(int index){
    for(int i=0;i<other_amenities_status.length;i++){
      if(i==index){
        setState(() {
          other_amenities_status[i]=!other_amenities_status[i];
        });
      }

      else{
        setState(() {
          other_amenities_status[i]=false;
        });
      }
    }
  }*/

  setViewingStatus(int index){
    for(int i=0;i<viewing_status.length;i++){
      if(i==index){
        setState(() {
          viewing_status[i]=!viewing_status[i];
        });
      }

      else{
        setState(() {
          viewing_status[i]=false;
        });
      }
    }
  }

  setListingStatus(int index){
    for(int i=0;i<listing_status.length;i++){
      if(i==index){
        setState(() {
          listing_status[i]=!listing_status[i];
        });
      }

      else{
        setState(() {
          listing_status[i]=false;
        });
      }
    }
  }
  String getReducedValue(){
    List<String> new_amenities=[];

    other_amenities.asMap().forEach((index, element) {
      if(other_amenities_status[index]){
        new_amenities.add(element);
      }
    });

    if(new_amenities.isNotEmpty){
      String result = new_amenities.reduce((value, element){

        value=value + ',' + element;

        return value;
      });

      print("Result is " + result.toString());
      return result;
    }

    else{
      return 'None';
    }


  }

  String dateToFormat(String date){

    String new_date= date.substring(6,10) + "-" + date.substring(3,5) +
        "-"  + date.substring(0,2);
    print("Date to be parsed is " + new_date);
    DateTime new_date_time = DateTime.parse(new_date);
    DateFormat date_format=DateFormat("yyyy-MM-dd");
    String formatted_date= date_format.format(new_date_time);
    formatted_date=formatted_date + " " + DateTime.now().toString().substring(10,19);
    print("The new date is " + formatted_date);
    return formatted_date;
  }

  Future selectPhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        image_uploads.add(_image);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

 /* Property property = Property(
      id: 0, apartment_type: apartment_type.elementAt(apartment_type_value!),
      bhk_type: bhk_types.elementAt(bhk_type_value!),
      property_name: property_name, property_price: rent_controller.text,
      no_of_bedrooms:no_of_bathrooms_controller.text,
      no_of_bathrooms: no_of_bathrooms_controller.text,
      balcony: balcony_value!.toString(),
      possession: calculatePossessionPeriod(available_from_controller.text),
      power_backup: power_backup.elementAt(power_backup_value!),
      landlord_id: 0,
      property_master_id: 0);
*/

setData(){
    master_name_controller=TextEditingController(text: widget.property!.propertyMaster!.property_master_name);
    master_location_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).address);
    description_controller = TextEditingController(text: widget.property!.property_description.elementAt(0).description);
    builtup_area_controller = TextEditingController(text: widget.property!.property_overviews.elementAt(0).builtup_area.toString());
    carpet_area_controller = TextEditingController(text: widget.property!.property_description.elementAt(0).carpet_area.toString());
    rent_controller = TextEditingController(text: widget.property!.property_price.toString());
    deposit_controller = TextEditingController(text: widget.property!.property_overviews.elementAt(0).expected_deposit.toString());
    no_of_bedrooms_controller = TextEditingController(text: widget.property!.no_of_bedrooms.toString());
    no_of_bathrooms_controller = TextEditingController(text: widget.property!.no_of_bathrooms.toString());
    address_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).address.toString());
    street_address_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).street_address.toString());
    address_line2_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).address_line_2.toString());
    postal_code_controller = TextEditingController(text: widget.property!.property_location.elementAt(0).postal_code.toString());
    service_charge_fee_controller = TextEditingController(text: widget.property!.property_description.elementAt(0).service_charge_fee.toString());
    available_from_controller = TextEditingController(text: set_availability_from(widget.property!.property_description.elementAt(0).availability_date.toString()));
    balcony_controller = TextEditingController(text: widget.property!.balcony.toString());
    viewing_time_from_controller = TextEditingController(text: widget.property!.property_days.elementAt(0).from_time.toString());
    viewing_time_to_controller = TextEditingController(text: widget.property!.property_days.elementAt(0).to_time.toString());
    contact_person_controller = TextEditingController(text: widget.property!.property_days.elementAt(0).contact_person.toString());
    TextEditingController contact_person1_controller = TextEditingController(text: '');
    phone_controller=TextEditingController(text: widget.property!.property_days.elementAt(0).phone.toString());

    bhk_type_value=bhk_types.indexOf(widget.property!.bhk_type.toString());
    apartment_type_value=apartment_type.indexOf(widget.property!.apartment_type.toString());
    floor_value=floors.indexOf(widget.property!.property_overviews.elementAt(0).floor.toString());
    total_floors_value=total_floors.indexOf(widget.property!.property_overviews.elementAt(0)
    .total_floor.toString());
    age_value=age_of_building.indexOf(widget.property!.property_overviews.elementAt(0).age_of_building.toString());
    facings_value=facings.indexOf(widget.property!.property_overviews.elementAt(0).facing.toString());
    parkings_value=parkings.indexOf(widget.property!.property_overviews.elementAt(0).parking.toString());
    furnishing_value=furnishings.indexOf(widget.property!.property_overviews.elementAt(0).furnishing_status.toString());
    gated_security=widget.property!.property_overviews.elementAt(0).gated_security;
    power_backup_value=power_backup.indexOf(widget.property!.power_backup.toString());
    preferred_tenant_value=preferred_tenants.indexOf(widget.property!.property_description.elementAt(0).preferred_tenant.toString());
    service_charge_value=service_charges.indexOf(widget.property!.property_description.elementAt(0).service_charge);
    service_charge_fee_controller.text=widget.property!.property_description.elementAt(0).service_charge_fee.toString();
    water_supply_value=water_supply.indexOf(widget.property!.property_description.elementAt(0).water_supply.toString());
    electricity_value=electricity.indexOf(widget.property!.property_description.elementAt(0).electricity.toString());
    gym=widget.property!.property_description.elementAt(0).gym==1 ? "Yes" : "No";
    non_veg=widget.property!.property_description.elementAt(0).non_veg_allowed==1 ? "Yes" : "No";
    is_rent_negotiable=widget.property!.property_overviews.elementAt(0).rent_negotiable==1 ? true : false;
    setListingTypes();
    setOtherAmenities();
    setAgreementType();
    setViewingDays();
    Provider.of<Preferences>(context,listen: false).tempLocation=widget.property!.property_location.first;
    // area_type_value=area_types.indexOf(widget.property.)


  }

  setListingTypes(){
    listing_status=List.filled(listing_types.length, false);
    listing_types.asMap().forEach((index, element){
      if(element==widget.property!.propertyMaster!.property_listing_type){
        listing_status[index]=true;
      }
    });
  }

  setOtherAmenities(){
    other_amenities_status=List.filled(other_amenities.length, false);
    other_amenities.asMap().forEach((index, element){
      if(element==widget.property!.property_description.elementAt(0).other_amenities){
        other_amenities_status[index]=true;
      }
    });
  }

  setViewingDays(){
    viewing_status=List.filled(viewing_days.length, false);
    //(widget.search_property_types.any((search_element) => element.apartment_type.contains(search_element)
    viewing_days.asMap().forEach((index, element){
      if(widget.property!.property_days.any((day_element) => day_element.viewing_day.contains(element))){
        viewing_status[index]=true;
      }
    });
  }

  setAgreementType(){
  if(widget.property!.property_overviews.elementAt(0).expected_availability=='rent'){
    new_availability_option=0;
    availability_option='rent';
  }

  else if(widget.property!.property_overviews.elementAt(0).expected_availability=='lease'){
    new_availability_option=1;
    availability_option='lease';
  }
  }

  String set_availability_from(String date){
   String new_date=date.substring(8,10) + "/" + date.substring(5,7) + "/" + date.substring(0,4);
   print("new date is " + new_date.toString());
   return new_date;
  }

  setLocationChosen(bool chosen){
    setState(() {
      isLocationChosen=chosen;
    });
  }

  setIsAbsorbPointer(bool absorbPointer){
    setState(() {
      isAbsorbPointer=absorbPointer;
    });
  }

  setLocationDetails(){
    address_controller.text=Provider.of<Preferences>(context,listen: false).tempLocation!.address;
    street_address_controller.text=Provider.of<Preferences>(context,listen: false).tempLocation!.street_address;
    address_line2_controller.text=Provider.of<Preferences>(context,listen: false).tempLocation!.address_line_2;
    postal_code_controller.text=Provider.of<Preferences>(context,listen: false).tempLocation!.postal_code.toString();
  }

  bool getIsMap(){
    return isMap;
  }
}