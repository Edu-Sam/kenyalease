import 'package:flutter/material.dart';
import '../../widget/module.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../module.dart';
import 'package:provider/provider.dart';
import '../../models/module.dart';
import '../../services/module.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as new_location;

class Dashboard extends StatefulWidget{
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState()=> _DashboardState();
}

class _DashboardState extends State<Dashboard>{

  //List<String> account_type=['Tenant','Landlord/Owner','Service Provider'];
  List<Role> account_type=[];
  int? account_type_value=0;
  int owner_bottom_bar_index=0;
  int tenant_bottom_bar_index=0;
  int provider_bottom_bar_index=0;
  int developer_bottom_bar_index=0;
  String role_name='';
  int role_type=0;
  new_location.Location location=new_location.Location();
  bool _serviceEnabled=false;
  bool locationEnabled=false;
  MapApi mapApi=MapApi();


@override
void initState() {
    // TODO: implement initState
    super.initState();
    initUserProfile();
    account_type=Provider.of<Preferences>(context,listen: false).account_role_types;
    Provider.of<Preferences>(context,listen: false).current_account=account_type.elementAt(0).firstname;
    //int role_id=Provider.of<Preferences>(context,listen: false).user!.role_id;
    role_name=account_type.first.firstname;
    /*account_type_value=role_name.contains('Tenant/Buyer') ? 0 : role_name.contains('Landlord/Property Owner') ? 1 :
    role_name.contains('Service Provider') ? 2 :
        role_name.contains('Property Developer') ? 3 : 0;*/
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appBars(),
      body: account_type.elementAt(account_type_value!).firstname=='Tenant/Buyer' ?
      TenantAccount(bottom_bar_index: tenant_bottom_bar_index,) :
      account_type.elementAt(account_type_value!).firstname=='Landlord/Property Owner' ?
      OwnerAccount(bottom_bar_index: owner_bottom_bar_index,) :
      account_type.elementAt(account_type_value!).firstname=='Service Provider' ?
      ProviderAccount(bottom_bar_index: provider_bottom_bar_index) :
      account_type.elementAt(account_type_value!).firstname=='Property Developer' ?
      DeveloperAccount(bottom_bar_index: developer_bottom_bar_index) :
      const SizedBox(),
      bottomNavigationBar: bottomNavigationBars(),
      floatingActionButton: account_type.elementAt(account_type_value!).firstname=='Service Provider' ? FloatingActionButton(
        child: const Icon(CupertinoIcons.add,color: Colors.white,size: 35,),
        onPressed: () async{

          Navigator.push(context,MaterialPageRoute(builder: (context) => CreatePropertyService(),
              settings: const RouteSettings(name: '/propertyservice'))).then((value){
           /* if(value is int && value==1){
              setState(() {
                initUserProfile();
              });
            }*/
          });
        },
        backgroundColor: AppConstants.primaryColor,
      ) : const SizedBox(),
    );
  }

  Widget bottomNavigationBars(){

    //if(account_type_value==0){
     if(account_type.elementAt(account_type_value!).firstname=='Tenant/Buyer'){
      return CustomBottomBar(
        custom_bottom_bar_items: tenantBarItems(),
        showTuneIn: tenant_bottom_bar_index==0,
        is_active: tenant_bottom_bar_index,
        navigationColor: Colors.transparent,
      );
    }
    else if(account_type.elementAt(account_type_value!).firstname=='Landlord/Property Owner'){
      return CustomBottomBar(
        custom_bottom_bar_items: ownerBarItems(),
        showTuneIn: owner_bottom_bar_index==0 || owner_bottom_bar_index==3,
        is_active: owner_bottom_bar_index,
        navigationColor: Colors.transparent,
      );
    }

    else if(account_type.elementAt(account_type_value!).firstname=='Service Provider'){
      return CustomBottomBar(
        custom_bottom_bar_items: providerBarItems(),
        showTuneIn: provider_bottom_bar_index==0 || provider_bottom_bar_index==3,
        is_active: provider_bottom_bar_index,
        navigationColor: Colors.transparent,
      );
    }

    else if(account_type.elementAt(account_type_value!).firstname=='Property Developer'){
       return CustomBottomBar(
         custom_bottom_bar_items: developerBarItems(),
         showTuneIn: developer_bottom_bar_index==0 || developer_bottom_bar_index==3,
         is_active: developer_bottom_bar_index,
         navigationColor: Colors.transparent,
       );
     }

    else{
      return SizedBox();
    }
  }



  List<CustomBottomBarItem> ownerBarItems(){
    return <CustomBottomBarItem>[
      CustomBottomBarItem(
        icon: Icon(Icons.home,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(
            Provider.of<Preferences>(context,listen: false).device_width
        ),*/),
        icon_description: 'Home',
        onTap: (){
        //  setControllers();
          setState(() {

            owner_bottom_bar_index=0;

          });
        },

        isActive: owner_bottom_bar_index == 0 ? 1 : 0,
        //   activeNavigationColor: Colors.black,
        //    activeNavigationColor: AppConstants.primaryColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),

      CustomBottomBarItem(
          icon: owner_bottom_bar_index==1 ? Icon(Icons.help,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ):

          Icon(CupertinoIcons.tag_solid,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ),
          icon_description: 'Listings',
          onTap: (){
            /* setState(() {
              bottom_bar_index=1;
            });*/
            //refreshUI(1);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListingsCatalogue(),
                settings: const RouteSettings(name: '/listingcatalogue')));
          },

          isActive: owner_bottom_bar_index==1 ? 1: 0,
          // activeNavigationColor: Colors.black,
          activeNavigationColor: AppConstants.navigationBackgroundColor,
          navigationColor: Colors.transparent,
          notification: 0
      ),

      CustomBottomBarItem(
        icon: Icon(Icons.widgets,color: Colors.grey.shade700,
            size: 22//, * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
        ),
        icon_description: 'Manage',
        onTap: (){
          setState(() {
            owner_bottom_bar_index=2;
          });
          //refreshUI(0);

        },

        isActive:  owner_bottom_bar_index == 2 ? 1 : 0,
        //  activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),



      CustomBottomBarItem(

        icon: Icon(CupertinoIcons.bell,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/),
        icon_description: 'Notifications',
        onTap: (){
          setState(() {
            owner_bottom_bar_index=3;
          });
          /*refreshUI(3);*/
        },

        isActive: owner_bottom_bar_index==3 ? 1: 0,
        //activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),
    ];
  }

  List<CustomBottomBarItem> tenantBarItems(){
    return <CustomBottomBarItem>[
      CustomBottomBarItem(
        icon: Icon(Icons.home,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(
            Provider.of<Preferences>(context,listen: false).device_width
        ),*/),
        icon_description: 'Home',
        onTap: (){
        //  setControllers();
          setState(() {

            tenant_bottom_bar_index=0;

          });

        },

        isActive: tenant_bottom_bar_index == 0 ? 1 : 0,
        //   activeNavigationColor: Colors.black,
        //    activeNavigationColor: AppConstants.primaryColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),

      CustomBottomBarItem(
          icon: tenant_bottom_bar_index==1 ? Icon(Icons.help,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ):

          Icon(Icons.camera,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ),
          icon_description: 'Support',
          onTap: (){
            setState(() {
              tenant_bottom_bar_index=1;
            });
            //refreshUI(1);
            /*Navigator.push(context, MaterialPageRoute(builder: (context) => ListingsCatalogue(),
                settings: const RouteSettings(name: '/listingcatalogue')));*/
          },

          isActive: tenant_bottom_bar_index==1 ? 1: 0,
          // activeNavigationColor: Colors.black,
          activeNavigationColor: AppConstants.navigationBackgroundColor,
          navigationColor: Colors.transparent,
          notification: 0
      ),

      CustomBottomBarItem(
        icon: Icon(CupertinoIcons.money_dollar,color: Colors.grey.shade700,
            size: 22//, * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
        ),
        icon_description: 'Payments',
        onTap: (){
          setState(() {
            tenant_bottom_bar_index=2;
          });
          //refreshUI(0);

        },

        isActive:  tenant_bottom_bar_index == 2 ? 1 : 0,
        //  activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),



      CustomBottomBarItem(

        icon: Icon(CupertinoIcons.doc_fill,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/),
        icon_description: 'Agreements',
        onTap: (){
          setState(() {
            tenant_bottom_bar_index=3;
          });
          /*refreshUI(3);*/
        },

        isActive: tenant_bottom_bar_index==3 ? 1: 0,
        //activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),
    ];
  }

  List<CustomBottomBarItem> providerBarItems(){
    return <CustomBottomBarItem>[
      CustomBottomBarItem(
        icon: Icon(Icons.home,color: Colors.white,
            size: 22 /* * AppConstants.getScaleFactor(
            Provider.of<Preferences>(context,listen: false).device_width
        ),*/),
        icon_description: 'Home',
        onTap: (){
          setState(() {
            provider_bottom_bar_index=0;
          });
          //refreshUI(2);
        },

        isActive: provider_bottom_bar_index == 0 ? 1 : 0,
        //   activeNavigationColor: Colors.black,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),

      CustomBottomBarItem(
          icon: provider_bottom_bar_index==1 ? Icon(Icons.help,color: Colors.white,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ):

          Icon(Icons.help,color: Colors.white,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ),
          icon_description: 'My Listings',
          onTap: (){
            setState(() {
              provider_bottom_bar_index=1;
            });
            //refreshUI(1);

          },

          isActive: provider_bottom_bar_index==1 ? 1: 0,
          // activeNavigationColor: Colors.black,
          activeNavigationColor: Colors.black87,
          navigationColor: Colors.transparent,
          notification: 0
      ),

      CustomBottomBarItem(
        icon: Icon(CupertinoIcons.money_dollar_circle,color: Colors.white,
            size: 22//, * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
        ),
        icon_description: 'Payment',
        onTap: (){
          setState(() {
            provider_bottom_bar_index=2;
          });
          //refreshUI(0);

        },

        isActive:  provider_bottom_bar_index == 2 ? 1 : 0,
        //  activeNavigationColor: Colors.black,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),



      CustomBottomBarItem(

        icon: Icon(CupertinoIcons.doc_fill,color: Colors.white,
            size: 22 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/),
        icon_description: 'Agreement',
        onTap: (){
          setState(() {
            provider_bottom_bar_index=3;
          });
          /*refreshUI(3);*/
        },

        isActive: provider_bottom_bar_index==3 ? 1: 0,
        //activeNavigationColor: Colors.black,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),
    ];
  }

  List<CustomBottomBarItem> developerBarItems(){
    return <CustomBottomBarItem>[
      CustomBottomBarItem(
        icon: Icon(Icons.home,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(
            Provider.of<Preferences>(context,listen: false).device_width
        ),*/),
        icon_description: 'Home',
        onTap: (){
          //  setControllers();
          setState(() {

            developer_bottom_bar_index=0;

          });
        },

        isActive: developer_bottom_bar_index == 0 ? 1 : 0,
        //   activeNavigationColor: Colors.black,
        //    activeNavigationColor: AppConstants.primaryColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),

      CustomBottomBarItem(
          icon: developer_bottom_bar_index==1 ? Icon(Icons.help,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ):

          Icon(CupertinoIcons.tag_solid,color: Colors.grey.shade700,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ),
          icon_description: 'Listings',
          onTap: (){
            /* setState(() {
              bottom_bar_index=1;
            });*/
            //refreshUI(1);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListingsCatalogue(),
                settings: const RouteSettings(name: '/listingcatalogue')));
          },

          isActive: developer_bottom_bar_index==1 ? 1: 0,
          // activeNavigationColor: Colors.black,
          activeNavigationColor: AppConstants.navigationBackgroundColor,
          navigationColor: Colors.transparent,
          notification: 0
      ),

      CustomBottomBarItem(
        icon: Icon(Icons.widgets,color: Colors.grey.shade700,
            size: 22//, * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
        ),
        icon_description: 'Manage',
        onTap: (){
          setState(() {
            developer_bottom_bar_index=2;
          });
          //refreshUI(0);

        },

        isActive:  developer_bottom_bar_index == 2 ? 1 : 0,
        //  activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),



      CustomBottomBarItem(

        icon: Icon(CupertinoIcons.bell,color: Colors.grey.shade700,
            size: 22 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/),
        icon_description: 'Notifications',
        onTap: (){
          setState(() {
            developer_bottom_bar_index=3;
          });
          /*refreshUI(3);*/
        },

        isActive: developer_bottom_bar_index==3 ? 1: 0,
        //activeNavigationColor: Colors.black,
        //  activeNavigationColor: AppConstants.navigationBackgroundColor,
        activeNavigationColor: Colors.black87,
        navigationColor: Colors.transparent,
        notification: 0,
      ),
    ];
  }

  PreferredSizeWidget appBars(){

    if(account_type.elementAt(account_type_value!).firstname=='Tenant/Buyer'){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: tenant_bottom_bar_index==0 ?  Padding(
          padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
          child: Container(
            // color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.50,
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
                          fillColor: Colors.transparent,
                          // fillColor: Colors.grey.shade100,
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
                              value: account_type_value,
                              isDense: true,
                              hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                              ),),

                              onChanged: (int? newValue){
                                setState(() {
                                  account_type_value=newValue;
                                  state.didChange(newValue);
                                  Provider.of<Preferences>(context,listen: false).current_account=account_type.elementAt(account_type_value!).firstname;
                                });


                              },
                              //  icon: null,
                              icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                              items:account_type.map((value){
                                return DropdownMenuItem(
                                  value: account_type.indexOf(value),
                                  child:Text(value.firstname,style: TextStyle(color: Colors.grey.shade600,
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
        ) :
        tenant_bottom_bar_index==1 ?
        Text("Support",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade600,fontWeight: FontWeight.w500,
            fontSize: 20
        ),) :
        tenant_bottom_bar_index==2 ?
        Text("Payments",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade600,fontWeight: FontWeight.w500,
            fontSize: 20
        ),) :
        tenant_bottom_bar_index==3 ?
        Text("Agreements",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade600,fontWeight: FontWeight.w500,
            fontSize: 20
        ),) : const SizedBox(),
        centerTitle: true,
        actions: [
          tenant_bottom_bar_index==0 ? Row(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ChatCatalogue()));
              }, icon: Icon(Icons.chat_bubble,color: Colors.grey.shade300,)),
              IconButton(
                onPressed: (){

                },
                icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
              )
            ],
          ) :
          IconButton(
            icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,),
            onPressed: (){

            },
          )
        ],
      );
    }
    else if(account_type.elementAt(account_type_value!).firstname=='Landlord/Property Owner'){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
        Padding(
          padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
          child: Container(
            // color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.50,
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
                           fillColor: Colors.transparent,
                         // fillColor: Colors.grey.shade100,
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
                              value: account_type_value,
                              isDense: true,
                              hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                              ),),

                              onChanged: (int? newValue){
                               setState(() {
                                 account_type_value=newValue;
                                 state.didChange(newValue);
                                 Provider.of<Preferences>(context,listen: false).current_account=account_type.elementAt(account_type_value!).firstname;
                               });


                              },
                              //  icon: null,
                              icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                              items:account_type.map((value){
                                return DropdownMenuItem(
                                  value: account_type.indexOf(value),
                                  child:Text(value.firstname,style: TextStyle(color: Colors.grey.shade600,
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
        /*Text('Somalease',style: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppConstants.primaryColor
        ),),*/
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChatCatalogue()));
          }, icon: Icon(Icons.chat_bubble,color: Colors.grey.shade300,)),
          IconButton(
            onPressed: (){

              //  makeCall(Provider.of<Preferences>(context,listen: false).user!.phone);
            },
            icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
          )
        ],
      );
    }

    else if(account_type.elementAt(account_type_value!).firstname=='Service Provider'){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Padding(
          padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
          child: Container(
            // color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.50,
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
                          fillColor: Colors.transparent,
                          // fillColor: Colors.grey.shade100,
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
                              value: account_type_value,
                              isDense: true,
                              hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                              ),),

                              onChanged: (int? newValue){
                                setState(() {
                                  account_type_value=newValue;
                                  state.didChange(newValue);
                                  Provider.of<Preferences>(context,listen: false).current_account=account_type.elementAt(account_type_value!).firstname;
                                });


                              },
                              //  icon: null,
                              icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                              items:account_type.map((value){
                                return DropdownMenuItem(
                                  value: account_type.indexOf(value),
                                  child:Text(value.firstname,style: TextStyle(color: Colors.grey.shade600,
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
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChatCatalogue()));
          }, icon: Icon(Icons.chat_bubble,color: Colors.grey.shade300,)),
          IconButton(
            onPressed: (){

            },
            icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
          )
        ],
      );
    }

    else if(account_type.elementAt(account_type_value!).firstname=='Property Developer'){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
        Padding(
          padding: EdgeInsets.only(top: 0.0,bottom: 0.0),
          child: Container(
            // color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.50,
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
                          fillColor: Colors.transparent,
                          // fillColor: Colors.grey.shade100,
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
                              value: account_type_value,
                              isDense: true,
                              hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                              ),),

                              onChanged: (int? newValue){
                                setState(() {
                                  account_type_value=newValue;
                                  state.didChange(newValue);
                                  Provider.of<Preferences>(context,listen: false).current_account=account_type.elementAt(account_type_value!).firstname;
                                });


                              },
                              //  icon: null,
                              icon: const Icon(Icons.keyboard_arrow_down,size: 12,),
                              items:account_type.map((value){
                                return DropdownMenuItem(
                                  value: account_type.indexOf(value),
                                  child:Text(value.firstname,style: TextStyle(color: Colors.grey.shade600,
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
        /*Text('Somalease',style: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppConstants.primaryColor
        ),),*/
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChatCatalogue()));
          }, icon: Icon(Icons.chat_bubble,color: Colors.grey.shade300,)),
          IconButton(
            onPressed: (){

              //  makeCall(Provider.of<Preferences>(context,listen: false).user!.phone);
            },
            icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
          )
        ],
      );
    }
    else{
      return AppBar();
    }
  }

  Future<dynamic> _checkPermission() async{

    var permission=await Permission.location.status;
    print("location permission is " + permission.toString());
    if(permission.isRestricted){
      var status = await Permission.location.request();
      if (status.isGranted) {
        //   location_permission=true;
        //   Provider.of<Preferences>(context,listen: false).location_permission=true;
        return await checkPermissionStatus();
      }

// You can can also directly ask the permission about its status.
      else if(status.isDenied) {

        //    location_permission=false;
        Provider.of<Preferences>(context,listen: false).location_permission=false;
        /***Turned Off***/// openLocationSettings();
        print("Option 1");
        await openPermissionSettings();
        return false;
        // The OS restricts access, for example because of parental controls.
      }

      else{
        //   location_permission=false;
        Provider.of<Preferences>(context,listen: false).location_permission=false;
        /**Turned Off**/ //openLocationSettings();
        print("Option 2");
        await openPermissionSettings();
        return false;
      }
    }


    else if(permission.isDenied) {
      var status = await Permission.location.request();
      if (status.isGranted) {
        //   location_permission=true;
        //   Provider.of<Preferences>(context,listen: false).location_permission=true;
        return await checkPermissionStatus();
      }
      //location_permission=false;
      /* Provider.of<Preferences>(context,listen: false).location_permission=false;
      /***Turned Off***/// openLocationSettings();
      print("Option 1");
      //  await openPermissionSettings();
      return false;*/
      // The OS restricts access, for example because of parental controls.
    }


    else{
      // location_permission=true;
      Provider.of<Preferences>(context,listen: false).location_permission=true;
      return await checkPermissionStatus();
    }
  }

  Future<bool> checkPermissionStatus() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print("Location permission is " + _serviceEnabled.toString());
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        //await openLocationSettings();
        /**Turned Off***/  // await openPermissionSettings();
        return false;
      }

      else{
        setState(() {
          Provider.of<Preferences>(context,listen: false).location_permission=true;
        });
        return true;
      }

    }

    else if(_serviceEnabled){
      Provider.of<Preferences>(context,listen: false).location_permission=true;
      // location_permission=true;
      return true;
    }

    else{
      //   await openLocationSettings();
      /**Turned Off***///  await openPermissionSettings();
      return false;
    }
  }

  Future<void> openPermissionSettings() async{
    Geolocator.openAppSettings();
  }


  Future<dynamic> initUserProfile() async{
    var result=await _checkPermission();

    if(result is bool){
      setState(() {
        Provider.of<Preferences>(context,listen: false).location_permission=result;

      });
      var setLocation=await _getCurrentLocation();
      return setLocation;
    }

    else{
      return result;
    }
  }

  Future<dynamic> _getCurrentLocation() async {
    //Position res = await Geolocator.getCurrentPosition();
    Position res= await _determinePosition();
    if(locationEnabled){
      //Address address= await mapApi.getAddress(res.latitude, res.longitude);
      var address = await mapApi.getLocationFromCoordinates(res.latitude,res.longitude);
      setState(() {
        Provider.of<Preferences>(context,listen: false).current_location!.lat=res.latitude;
        Provider.of<Preferences>(context,listen: false).current_location!.long=res.longitude;


      });
      return res;
    }

    else{
      return null;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      setState(() {
        locationEnabled=serviceEnabled;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setState(() {
          locationEnabled=serviceEnabled;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      locationEnabled=serviceEnabled;
      return Future.error(

          'Location permissions are permanently denied, we cannot request permissions.');
    }
    locationEnabled=serviceEnabled;
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}