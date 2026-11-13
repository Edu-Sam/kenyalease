import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import '../../widget/module.dart';
import 'package:somalease/constants/app_constants.dart';
import 'package:provider/provider.dart';

class AddStaff extends StatefulWidget{
  AddStaff({Key? key}) : super(key: key);

  @override
  _AddStaffState createState()=> _AddStaffState();
}

class _AddStaffState extends State<AddStaff>{

   List<Property> main_property=[];
   int? property_value=0;
   List<bool> properties_status=[],staff_role_status=[];
   Property? selected_property;
   StaffRole? selected_staff_role;
   TextEditingController property_detail_controller= TextEditingController(text: '');
   TextEditingController staff_role_controller = TextEditingController(text: '');
   TextEditingController name_controller = TextEditingController(text: '');
   TextEditingController email_controller = TextEditingController(text: '');
   List<StaffRole> main_staff_roles=[];
   bool isLoading=false;
   bool isFetchingRoles=false;
   PropertyRepository propertyRepository = PropertyRepository();
   StaffRoleRepository staffRoleRepository = StaffRoleRepository();
   NotificationContainer notificationContainer = NotificationContainer();
   ErrorContainer errorContainer = ErrorContainer();
   StaffRepository staffRepository = StaffRepository();
   GlobalKey<FormState> form_key= GlobalKey<FormState>();
   Validation validation = Validation();
   String message='';
   String error_message='';

   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    getPropertiesByLandlordID();
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
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,color: Colors.black54,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: Text("Add Staff",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
            ),),
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,))
            ],),

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: isLoading  ?
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorDark),
                ),
              ),
            ) :

            SingleChildScrollView(
              child: Form(
                key: form_key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
                      child: Text("Select Property",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),

                    Padding(
                        padding: EdgeInsets.only(bottom: 20.0,left: 20.0,right: 20.0),
                        child: GestureDetector(
                          onTap: (){
                            toModalBottomSheet(context, 0);
                          },
                          child: Container(
                            // color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: TextFormField(
                                controller: property_detail_controller,
                                validator: (text){
                                  return validation.name1Validator(text!);
                                },
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'e.g XYZ Apartment',
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey.shade400
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                ),
                              )
                          ),
                        )
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 0.0,bottom: 20.0),
                      child: Text("Name",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0,left: 20.0,right: 20.0),
                      child: Container(
                        // color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                            controller: name_controller,
                            validator: (text){
                              return validation.name1Validator(text!);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              hintText: 'e.g John Doe',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                            ),
                          )
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 0.0,bottom: 20.0),
                      child: Text("Email",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0,left: 20.0,right: 20.0),
                      child: Container(
                        // color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                            controller: email_controller,
                            validator: (text){
                              return validation.name1Validator(text!);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              hintText: 'e.g xyz@gmail.com',
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade400
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                            ),
                          )
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
                      child: Text("Select Role",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
                      ),),
                    ),

                    Padding(
                        padding: EdgeInsets.only(bottom: 20.0,left: 20.0,right: 20.0),
                        child: GestureDetector(
                          onTap: (){
                            toModalBottomSheet(context, 1);
                          },
                          child: Container(
                            // color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: TextFormField(
                                controller: staff_role_controller,
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'e.g CareTaker',
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey.shade400
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                ),
                              )
                          ),
                        )
                    ),

                  ],
                ),
              )
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () async{
                 if(form_key.currentState!.validate()){
                   setState(() {
                     error_message='';
                     message='Creating staff.Please wait...';
                     isFetchingRoles=true;
                   });

                   var result = await createStaff();
                   setState(() {
                     isFetchingRoles=false;
                     message='';
                   });
                   if(result is int && result ==201){
                     notificationContainer.showNotificationDialog('Staff has been saved Successfully', context, (){
                       Navigator.pop(context);
                       Navigator.pop(context,1);
                     });
                   }

                   else{
                     errorContainer.showInfoErrorDialog('Error Saving staff', context, (){
                       Navigator.pop(context);
                     });
                   }
                 }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: Text("Add Staff",style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white
                  ),),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                    )
                ),
              ),
            )
          )
        ),
        isFetchingRoles ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressContainer(
              message: message,
            ),
          ),
        )    :
        const SizedBox()
      ],
    );
  }

   Future<dynamic> toModalBottomSheet(BuildContext context,int is_property) async{
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
                             child: Text("Property: ",style: TextStyle(color: Colors.black54,fontSize: 18,
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
                               child: GridView.builder(itemCount:  main_property.length,
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
                                               child: Text(main_property.elementAt(index).propertyMaster!.property_master_name,
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
                                       onPressed: () async{
                                         if(properties_status.any((element) => element==true)){
                                           selected_property=main_property.elementAt(properties_status.indexWhere((element) =>
                                           element==true));
                                           setState(() {
                                             property_detail_controller.text=selected_property!.propertyMaster!.property_master_name;
                                           });
                                         }
                                         Navigator.pop(context,1);
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
                                       child: Text("CANCEL",style: TextStyle(color: Colors.grey,fontSize: 14,
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
                       ) : Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                             child: Text("Staff  Role for Property: ",style: TextStyle(color: Colors.black54,fontSize: 18,
                               fontWeight: FontWeight.w700,),),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20.0),
                             child: Text("Select staff role",style: TextStyle(
                                 color: Colors.black54,fontSize: 12,
                                 fontWeight: FontWeight.w500
                             ),),
                           ),

                           Container(
                               width: MediaQuery.of(context).size.width,
                               // height: MediaQuery.of(context).size.height * 0.35,
                               // color: Colors.black,
                               child: GridView.builder(itemCount:  main_staff_roles.length,
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
                                           setStaffRoleStatus(index);
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
                                               child: Text(main_staff_roles.elementAt(index).name,
                                                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                   color: AppConstants.primaryColorAccent,
                                                   fontWeight: FontWeight.w500,
                                                   fontSize: 12,
                                                 ),
                                                 textAlign: TextAlign.center,
                                               ),
                                             ),
                                           ),
                                           staff_role_status[index] ?
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
                                       child: Text("OK1",style: const TextStyle(color: Colors.white,fontSize: 14,
                                           fontWeight: FontWeight.w600),),
                                       onPressed: () async{
                                         if(staff_role_status.any((element) => element==true)){
                                           selected_staff_role=main_staff_roles.elementAt(staff_role_status.indexWhere((element) =>
                                           element==true));
                                           setState(() {
                                             staff_role_controller.text=selected_staff_role!.name;
                                           });
                                         }
                                         Navigator.pop(context,1);
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
                                       child: Text("CANCEL",style: TextStyle(color: Colors.grey,fontSize: 14,
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
                       )
                       /*SingleChildScrollView(
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
                       )*/
                   )
               );
             },
           );
         });
   }

   setPropertyStatus(int index){
     for(int i=0;i<main_property.length;i++){
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

   setStaffRoleStatus(int index){
     for(int i=0;i<main_staff_roles.length;i++){
       if(i==index){
         setState(() {
           staff_role_status[i]=true;
         });
       }

       else{
         setState(() {
           staff_role_status[i]=false;
         });
       }
     }
   }

   Future<dynamic> getPropertiesByLandlordID() async{
     setState(() {
       isLoading=true;
     });
     var result = await propertyRepository.getPropertiesByLandlordID(Provider.of<Preferences>(context,listen: false)
         .user!.remember_token,Provider.of<Preferences>(context,listen: false).user!.user_id);
     var result1= await getStaffRoleByID();
     if(result is List<Property>){
       setState(() {
         main_property=result;
         properties_status= List.filled(main_property.length, false);

         isLoading=false;
       });
       return result;
     }

     else{
       setState(() {
         main_property=[];
         properties_status=[];
         isLoading=false;
       });
       return result;
     }


   }

   Future<dynamic> getStaffRoleByID() async{
     setState(() {
       isLoading=true;
     });
     var result = await staffRoleRepository.getStaffByLandlordID(Provider.of<Preferences>(context,listen: false)
         .user!.user_id, Provider.of<Preferences>(context,listen: false).user!.remember_token);

     if(result is List<StaffRole>){
       setState(() {
         main_staff_roles=result;
         staff_role_status= List.filled(main_staff_roles.length, false);
         isLoading=false;
       });
     }

     else{
       setState(() {
         main_staff_roles=[];
         isLoading=false;
       });
     }
     return result;
   }

   Future<dynamic> createStaff() async{
     Staff staff= Staff(id: 0,role_id: selected_staff_role!.id,property_id: selected_property!.id,
     name: name_controller.text,email: email_controller.text);

     var result = await staffRepository.createStaff(staff, Provider.of<Preferences>(context,listen: false)
     .user!.remember_token);

     return result;
   }


}