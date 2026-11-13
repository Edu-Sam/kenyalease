import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/services/agreementRepository.dart';
import 'package:somalease/services/tenantRepository.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import '../../widget/module.dart';
import 'package:provider/provider.dart';
import '../../services/module.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class RentalAgreement extends StatefulWidget{
  RentalAgreement({Key? key,required this.property_masters}) : super(key: key);
  List<PropertyMaster> property_masters;

  @override
  _RentalAgreementState createState()=> _RentalAgreementState();
}

class _RentalAgreementState extends State<RentalAgreement>{

  int? properties_value=0;
  List<PropertyMaster> property_masters=[];
 // List<String> tenants=["Person 1","Person 2","Person 3","Person 4"];
  List<User> tenants=[];

  PageController? _pageController;
  int tab_index=0;
  TenantRepository tenantRepository = TenantRepository();
  PropertyRepository propertyRepository = PropertyRepository();
  TextEditingController property_detail_controller = TextEditingController();
  TextEditingController tenant_detail_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  bool isLoading=false;
  List<Property> properties=[];
  List<bool> properties_status=[],tenant_status=[];
  Property? selected_property;
  User? selected_tenant;
  DateTime agreement_date_from=DateTime.now(),agreement_date_to=DateTime.now();
  TextEditingController agreement_from_controller = TextEditingController();
  TextEditingController agreement_to_controller = TextEditingController();
  PlatformFile? objFile;
  AgreementRepository agreementRepository = AgreementRepository();
  bool isCreatingAgreement=false;
  String message='';
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  Validation validation = Validation();
  String error_message='';
  NotificationContainer notificationContainer = NotificationContainer();
  ErrorContainer errorContainer = ErrorContainer();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserProfile();
    /*_pageController=PageController(initialPage: tab_index);
    property_masters=widget.property_masters;
    getTenants();*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController!.dispose();
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
            title: Text('Agreements',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            leading: IconButton(
              icon:  Icon(CupertinoIcons.back,color: AppConstants.primaryColorDark,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Form(
                    key: form_key,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: Text("Create a rental agreement in the form below",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,fontSize: 16
                                ),),
                            )
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    _selectDate(context);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text("From",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      ),
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
                                            controller: agreement_from_controller,
                                            validator: (text){
                                              return validation.name1Validator(text!);
                                            },
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


                                    ],
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    _selectToDate(context);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text("To",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      ),
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
                                            controller: agreement_to_controller,
                                            validator: (text){
                                               return validation.name1Validator(text!);
                                            },
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
                                      /*  Icon(
                                      CupertinoIcons.calendar,color: Colors.black,
                                    )*/
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                toModalBottomSheet(context,0);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 48,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    //   color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: TextFormField(
                                  controller: property_detail_controller,
                                  validator: (text){
                                    return validation.name1Validator(text!);
                                  },
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: 'Select Property',
                                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.grey.shade500,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide:  BorderSide(color: Colors.grey.shade400)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: BorderSide(color: Colors.grey.shade400)
                                      )

                                  ),
                                ),
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                toModalBottomSheet(context,1);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: TextFormField(
                                  controller: tenant_detail_controller,
                                  validator: (text){
                                    return validation.name1Validator(text!);
                                  },
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: 'Select Tenant',
                                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.grey.shade500,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide:  BorderSide(color: Colors.grey.shade400)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: BorderSide(color: Colors.grey.shade400)
                                      )

                                  ),
                                ),
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 48,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16.0)
                            ),
                            child: TextFormField(
                              controller: description_controller,
                              //     enabled: false,
                              minLines: 4,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Agreement Notes',
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide:  BorderSide(color: Colors.grey.shade400)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(color: Colors.grey.shade400)
                                  )

                              ),
                            ),
                          ),
                        ),

                        objFile== null ?
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                getFile();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16.0)
                                ),
                                child:
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.add,color: Colors.grey.shade700,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text("Upload File",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade700
                                        ),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ) :

                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(16.0)
                            ),
                            child:
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.doc_fill,color: Colors.grey.shade700,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(objFile!.name.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade700
                                        ),),
                                      )
                                    ],
                                  ),

                                  IconButton(
                                    icon: Icon(CupertinoIcons.clear,color: AppConstants.primaryColorDark,),
                                    onPressed: (){
                                      setState(() {
                                        objFile=null;
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                            ,
                          ),
                        ),


                      ],
                    ),
                  )
                )
            ),
          ),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () async{

                  if(objFile==null){
                    setState(() {
                      error_message='Please upload rental agreement document';
                    });
                  }

                  if(form_key.currentState!.validate()){
                    setState(() {
                      error_message='';
                      message='Creating Agreement';
                      isCreatingAgreement=true;
                    });

                    var result = await addAgreement();
                    setState(() {
                      isCreatingAgreement=false;
                      message='';

                    });
                    if(result is Agreement){
                        notificationContainer.showNotificationDialog('Rental Agreement has been sent to tenent',
                            context, (){
                          Navigator.pop(context);
                          Navigator.pop(context,1);
                            });
                    }

                    else{
                      errorContainer.showInfoErrorDialog('Error creating rental agreement.Please try again',
                          context, (){
                        Navigator.pop(context);
                          });
                    }
                  }


                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                      )
                  ),
                  child: Center(
                    child: Text("Send",style: Theme.of(context).textTheme!.headline6!.copyWith(
                        color: Colors.white
                    ),),
                  ),
                ),
              )
          ),
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorAccent),
            ),
          ),
        ) :
        isCreatingAgreement ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressContainer(
              message: message,
            ),
          ),
        )  :
        const SizedBox()
      ],
    );
  }

  Future<dynamic> getTenants() async{
    var result = await tenantRepository.getTenants(Provider.of<Preferences>(context,listen: false).user!.remember_token);
    if(result is List<User>){
      setState(() {
        tenants=result;
      });

      print("Size of tenants is " + tenants.length.toString());
    }

    else{
      setState(() {
        tenants=[];
      });
    }
    return result;
  }

  Future<void> getFile() async{
    var picked=await FilePicker.platform.pickFiles();

    if(picked !=null){
      setState(() {
        objFile=picked.files.single;
      });
    }
  }

  Future<void> toModalBottomSheet(BuildContext context,int is_property) async{
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))
        ),
        isScrollControlled: true,

        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (context,updateState){
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.vertical(top:Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                    child:is_property==0 ?  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text("Agreement for Property: ",style: TextStyle(color: Colors.black54,fontSize: 18,
                            fontWeight: FontWeight.w700,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("Select property",style: TextStyle(
                              color: Colors.black54,fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),),
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.35,
                            // color: Colors.black,
                            child: GridView.builder(itemCount:  properties.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 120,
                                  ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                                  maxCrossAxisExtent: 150/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10),
                              itemBuilder: (context,index){

                                return GestureDetector(
                                  onTap: (){
                                    updateState(() {
                                      setPropertyStatus(index);
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                             gradient: LinearGradient(
                                               begin: Alignment.topLeft,
                                               end: Alignment.bottomRight,
                                               colors: <Color>[Colors.white,AppConstants.listingBanner]
                                             )
                                           // color: Colors.grey.shade100
                                        ),
                                        child: Center(
                                          child: Text(properties.elementAt(index).property_name.toString(),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: AppConstants.primaryColorAccent,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                            ),
                                          textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      properties_status[index] ?
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:  Icon(Icons.check_circle_outline,color: AppConstants.primaryColorAccent,),
                                        ),
                                      )    : SizedBox()
                                    ],
                                  )
                                );


                                /*else{
                    return const SizedBox();
                  }*/


                                /*else if(index ==4){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CategoryCatalogue(categories: user_categories),
                            settings: const RouteSettings(name: '/categorycatalogue')
                        ));
                      },
                      child: SpecialistWidget(specialization: '',field_icon: '',),
                    );
                  }*/


                              },
                            )
                        ),


                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 50,
                                  child: TextButton(
                                    child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 14,
                                        fontWeight: FontWeight.w600),),
                                    onPressed: (){
                                     if(properties_status.any((element) => element==true)){
                                       selected_property=properties.elementAt(properties_status.indexWhere((element) =>
                                       element==true));
                                       setState(() {
                                         property_detail_controller.text=selected_property!.property_name;
                                       });
                                     }
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor:AppConstants.primaryColorAccent
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 50,
                                  child: OutlinedButton(
                                    child: Text("CANCEL",style: TextStyle(color: HexColor.fromHex("#010634"),fontSize: 14,
                                        fontWeight: FontWeight.w600),),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    ) :
                   SingleChildScrollView(
                     child:  Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                           child: Text("Tenant ",style: TextStyle(color: Colors.black54,fontSize: 18,
                             fontWeight: FontWeight.w700,),),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 20.0),
                           child: Text("Select Tenant",style: TextStyle(
                               color: Colors.black54,fontSize: 12,
                               fontWeight: FontWeight.w500
                           ),),
                         ),

                         Container(
                             width: MediaQuery.of(context).size.width,
                             // height: MediaQuery.of(context).size.height * 0.35,
                             // color: Colors.black,
                             child: Column(
                                 children: tenants.asMap().map((index, element){
                                   return MapEntry(index,
                                       Padding(
                                         padding: EdgeInsets.only(bottom: 20.0,left: 0.0,right: 0.0),
                                         child: GestureDetector(
                                           onTap: (){
                                             updateState((){
                                               setTenantStatus(index);
                                             });
                                           },
                                           child: Container(
                                               width: MediaQuery.of(context).size.width,
                                               height: 52,
                                               decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   borderRadius: BorderRadius.circular(8.0),
                                                   border: Border.all(color: Colors.grey.shade300)
                                               ),
                                               child: Padding(
                                                 padding: EdgeInsets.symmetric(
                                                     horizontal: 20.0
                                                 ),
                                                 child: Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Padding(
                                                       padding: EdgeInsets.only(top: 0.0,),
                                                       child: Text(element.firstname + ' ' + element.lastname,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                           color: Colors.black54,fontSize: 12,
                                                           fontWeight: FontWeight.w400
                                                       ),),
                                                     ),

                                                     tenant_status[index] ?
                                                     Icon(Icons.check_circle_outline,color: Colors.green,)     :
                                                     SizedBox()


                                                   ],
                                                 ),
                                               )
                                           ),
                                         )
                                       ));
                                 }).values.toList()
                             )
                         ),


                         Padding(
                             padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 0.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Container(
                                   width: MediaQuery.of(context).size.width * 0.35,
                                   height: 50,
                                   child: TextButton(
                                     child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 14,
                                         fontWeight: FontWeight.w600),),
                                     onPressed: (){
                                       if(tenant_status.any((element) => element==true)){
                                         selected_tenant=tenants.elementAt(tenant_status.indexWhere((element) =>
                                         element==true));
                                         setState(() {
                                           tenant_detail_controller.text=selected_tenant!.firstname + " " +
                                           selected_tenant!.lastname;
                                         });
                                       }
                                       Navigator.pop(context);
                                     },
                                     style: TextButton.styleFrom(
                                         backgroundColor:AppConstants.primaryColorAccent
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width * 0.35,
                                   height: 50,
                                   child: OutlinedButton(
                                     child: Text("CANCEL",style: TextStyle(color: HexColor.fromHex("#010634"),fontSize: 14,
                                         fontWeight: FontWeight.w600),),
                                     onPressed: (){
                                       Navigator.pop(context);
                                     },
                                     style: OutlinedButton.styleFrom(
                                         backgroundColor: Colors.white
                                     ),
                                   ),
                                 ),
                               ],
                             )
                         )
                       ],
                     ),
                   )
                  )
              );
            },
          );
        });
  }

  Future<dynamic> getProperties() async{

    var result = await propertyRepository.getPropertiesByLandlordID(Provider.of<Preferences>(context,listen: false)
    .user!.remember_token,Provider.of<Preferences>(context,listen: false).user!.user_id);
    if(result is List<Property>){
      setState(() {
        properties=result;
      });
    }

    else{
      setState(() {
        properties=[];
      });
    }
    return result;
  }

  Future<void> initUserProfile() async{
    setState(() {
      isLoading=true;
    });
    _pageController=PageController(initialPage: tab_index);
    property_masters=widget.property_masters;
    var result1=await getTenants();
    var result2=await getProperties();
    properties_status= List.filled(properties.length, false);
    tenant_status=List.filled(tenants.length, false);
    setState(() {
      isLoading=false;
    });
  }

  setPropertyStatus(int index){
    for(int i=0;i<properties.length;i++){
      if(i==index){
        setState(() {
          properties_status[i]=true;
        });
      }

      else{
        setState(() {
          properties_status[i]=false;
        });
      }
    }
  }

  setTenantStatus(int index){
    for(int i=0;i<tenants.length;i++){
      if(i==index){
        setState(() {
          tenant_status[i]=true;
        });
      }

      else{
        setState(() {
          tenant_status[i]=false;
        });
      }
    }
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: agreement_date_from,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 20000)),
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
      agreement_date_from = newSelectedDate;
      //  date_from= DateFormat.yMMMd().format(_selectedDate);
      //DateFormat date_format= DateFormat("yyyy-MM-dd 00:00:00");
      DateFormat date_format=DateFormat("dd/MM/yyyy");
      setState((){
        agreement_from_controller.text=date_format.format(agreement_date_from);
      });
      print("The date is " + agreement_from_controller.text);

    }
  }

  _selectToDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: agreement_date_to,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 20000)),
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
      agreement_date_to = newSelectedDate;
      //  date_from= DateFormat.yMMMd().format(_selectedDate);
      //DateFormat date_format= DateFormat("yyyy-MM-dd 00:00:00");
      DateFormat date_format=DateFormat("dd/MM/yyyy");
      setState((){
        agreement_to_controller.text=date_format.format(agreement_date_to);
      });
      print("The date is " + agreement_to_controller.text);

    }
  }

  Future<dynamic> addAgreement() async{
    print("Tenant id is " + selected_tenant!.id.toString());
    Agreement agreement = Agreement(id: 0,property_id: selected_property!.id,agreement_description: description_controller.text,
    start_date: dateToFormat(agreement_from_controller.text),
    end_date: dateToFormat(agreement_to_controller.text),
      tenant_id: selected_tenant!.id
    );

    agreement.file=objFile;
     var result = await agreementRepository.createAgreement(Provider.of<Preferences>(context,listen: false)
         .user!.remember_token, selected_property!.id, agreement);

     return result;
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
}