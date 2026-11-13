import 'package:flutter/material.dart';
import 'package:somalease/view/module.dart';
import '../../services/module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListingsCatalogue extends StatefulWidget{
  ListingsCatalogue({Key? key}): super(key: key);

  @override
  ListingsCatalogueState createState()=> ListingsCatalogueState();
}

class ListingsCatalogueState extends State<ListingsCatalogue>{

  PropertyRepository propertyRepository = PropertyRepository();
  List<Property> main_property=[];
  List<Property> all_property=[],residential_property=[],sale_property=[],commercial_property=[];
  bool isLoading=false;
  List<String> property_types=["All","Rent","Sale","Commercial"];
  List<bool> property_type_status=[];
  bool isSwitched=false;
  int property_size=0;
  String property_switch='';
  List<String> banners=["Zero Commission","Faster Tenants","5m + Tenants/Buyer Connections"];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String property_status='pending';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initButtonStatus();
   // getProperties();
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
           title: Text('Listing',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
               color: Colors.grey.shade700,fontWeight: FontWeight.w500,
             fontSize: 18
           ),),
           centerTitle: true,
           leading:
           IconButton(
             icon: Icon(CupertinoIcons.back,color: Colors.black87,),
             onPressed: (){
               Navigator.pop(context);
             },
           ),
           actions: [
             IconButton(
                 onPressed: (){

                 },
                 icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,))
           ],

         ),
         body:  Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           color: Colors.white,
           child: all_property.isEmpty ?
           emptyListings() :
           SingleChildScrollView(
               child: Padding(
                 padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Padding(
                       padding: EdgeInsets.only(bottom: 20.0),
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 40,
                         child: ListView.builder(
                             itemCount: property_types.length,
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context,index){
                               return Padding(
                                 padding: EdgeInsets.only(
                                     right: 20.0
                                 ),
                                 child: GestureDetector(
                                   onTap: (){
                                     setButtonStatus(index,property_types.elementAt(index));
                                   },
                                   child: Container(
                                     width: 100,
                                     height: 40,
                                     decoration: property_type_status[index] ?
                                     BoxDecoration(
                                       // color: Colors.white,
                                       gradient: LinearGradient(
                                           begin: Alignment.centerLeft,
                                           end: Alignment.centerRight,
                                           colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                       ),
                                       borderRadius: BorderRadius.circular(8.0),
                                       //   border: Border.all(color: Colors.grey.shade300),
                                     ) :

                                     BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(8.0),
                                       border: Border.all(color: Colors.grey.shade300),
                                     ),
                                     child: Center(
                                       child: Text(property_types.elementAt(index),style: Theme.of(context).textTheme
                                           .bodyMedium!.copyWith(color: property_type_status[index] ?
                                       Colors.white :
                                       Colors.black87,
                                           fontWeight: FontWeight.w600),),
                                     ),
                                   ),
                                 ),
                               );
                             }),
                       ),
                     ),

                     Padding(
                       padding: EdgeInsets.only(bottom: 20.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: EdgeInsets.only(bottom: 0.0),
                             child: Text(main_property.length.toString() + (main_property.length > 1 ?  " Properties Listed" :
                             " Property Listed"),style: Theme.of(context).textTheme.headline6!.copyWith(
                                 color: AppConstants.primaryColorAccent,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 17
                             ),),
                           ),

                           Padding(
                             padding: EdgeInsets.only(bottom: 0.0),
                             child: Row(
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(left: 0.0),
                                   child: Text('Is Active',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                     color: Colors.black87,
                                   ),),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(left: 20.0,top: 0.0),
                                   child: Transform.scale(
                                     scale: 1.0,
                                     child: Switch(
                                       onChanged: toggleSwitch,
                                       value: isSwitched,
                                       activeColor: AppConstants.primaryColor,
                                       activeTrackColor: AppConstants.primaryColorAccent,
                                       inactiveThumbColor: Colors.grey,
                                       inactiveTrackColor: Colors.grey.shade400,
                                     ),
                                   ),
                                 ),


                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(bottom: 20.0),
                       child: Column(
                         children: main_property.asMap().map((index, element){
                           return MapEntry(index,element.propertyMaster!.status==property_status ? Padding(
                             padding: const EdgeInsets.only(bottom: 20.0),
                             child: GestureDetector(
                               onTap: (){
                                 /*Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                 PropertyDetailContainer(
                                   property: element,
                                 ),settings: const RouteSettings(name: '/propertydetail'))).then((value){
                                   if(value is int && value==1){
                                     setState(() {
                                       initButtonStatus();
                                       getPropertiesByLandlordID();
                                     });
                                   }
                                 });*/

                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                     UpdateProperty1(property: element),settings: const
                                 RouteSettings(name: '/updateproperty1')),).then((value){
                                   if(value is int && value==1){
                                     setState(() {
                                       initButtonStatus();
                                       getPropertiesByLandlordID();
                                     });
                                   }
                                 });
                               },
                               child: Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height * 0.24,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   border: Border.all(color: Colors.grey.shade300),

                                 ),
                                 child: Padding(
                                   padding:const EdgeInsets.only(top: 5.0,left: 0.0,right: 0.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Padding(
                                         padding: EdgeInsets.only(bottom: 20.0),
                                         child: element.propertyMaster!.status=='pending' ? Container(
                                           width: 70,
                                           height: 30,
                                           decoration:  BoxDecoration(
                                               color: Colors.grey.shade200
                                           ),
                                           child: Center(
                                             child: Text('Inactive',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                 color: Colors.grey.shade700
                                             ),),
                                           )
                                         ):
                                         element.propertyMaster!.status=='approved' ?
                                         Container(
                                           width: 70,
                                           height: 30,
                                           decoration:  BoxDecoration(
                                               gradient: LinearGradient(
                                                 begin: Alignment.topLeft,
                                                 end: Alignment.bottomRight,
                                                 colors: <Color>[AppConstants
                                                 .primaryColor,AppConstants.primaryColorAccent]
                                               )
                                           ),
                                           child: Center(
                                             child: Text('Active',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                 color: Colors.white
                                             ),),
                                           )
                                         )  : const SizedBox()
                                         ,),

                                       Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Padding(
                                                       padding: const EdgeInsets.only(bottom: 10.0,left: 0.0),
                                                       child: Container(
                                                         width:  MediaQuery.of(context).size.width * 0.50,
                                                         child:  Text(element.property_name,style: Theme.of(context).textTheme.bodySmall
                                                         !.copyWith(color: Colors.grey.shade600),),
                                                       )
                                                   ),

                                                   Padding(
                                                     padding: EdgeInsets.only(bottom: 10.0),
                                                     child: Container(
                                                       width:  MediaQuery.of(context).size.width * 0.50,
                                                       child:  Text(element.propertyMaster!.property_master_name + ',' + element.property_location.elementAt(0).street_address,style: Theme.of(context).textTheme.bodySmall
                                                       !.copyWith(color: Colors.grey.shade600),),
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: EdgeInsets.only(top: 0.0,bottom: 10.0),
                                                     child: Text("Rent: KES" + element.property_price.toString() +
                                                         '-' + element.property_location.elementAt(0).address,style: Theme
                                                         .of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade600),),
                                                   ),


                                                 ],
                                               ),
                                               Container(
                                                 width: 70,
                                                 height: 70,
                                                 decoration: BoxDecoration(
                                                     image: DecorationImage(
                                                         image: AssetImage("assets/images/property_demo.png"),
                                                         fit: BoxFit.cover
                                                     )
                                                 ),
                                               )

                                             ],
                                           )
                                       ),

                                       Divider(
                                         indent: 0.0,
                                         endIndent: 0.0,
                                       ),
                                       Padding(
                                           padding: EdgeInsets.only(bottom: 0.0,left: 20.0,right: 20.0,top: 0.0),
                                           child: IntrinsicHeight(
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text('3 Enquiries',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                     color: Colors.grey.shade700
                                                 ),),
                                                 Row(
                                                   children: [
                                                     Text('Edit',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                         color: AppConstants.thirdColorDark,fontWeight: FontWeight.normal,
                                                         fontSize: 12
                                                     ),),

                                                     VerticalDivider(color: Colors.black87,),

                                                     Text('Request Activation',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                         color: AppConstants.thirdColorDark,fontWeight: FontWeight.normal,
                                                         fontSize: 12
                                                     ),),

                                                     // VerticalDivider(color: Colors.black87,),

                                                   ],
                                                 )
                                               ],
                                             ),
                                           )
                                       )

                                     ],
                                   ),
                                 ),
                               ),
                             )
                           ) : const SizedBox());
                         }).values.toList(),
                       ),
                     )
                   ],
                 ),
               )
           ),
         ),
         bottomNavigationBar:  Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             GestureDetector(
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 40,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                       begin: Alignment.centerLeft,
                       end: Alignment.centerRight,
                       colors: <Color>[AppConstants.primaryColorDark,AppConstants.primaryColor,]
                   ),
                 ),
                 child: Center(
                   child: Text("Post FREE Property Listing",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                       color: Colors.white
                   )),
                 ),
               ),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     CreateProperty1(),settings: const RouteSettings(name: '/createproperty1'))).then((value){
                   if(value is int && value==1){
                     setState(() {
                       initButtonStatus();
                       getPropertiesByLandlordID();
                     });
                   }
                 });
               },
             ),
             Container(
               width: MediaQuery.of(context).size.width,
               height: 48,
               decoration: BoxDecoration(
                   gradient: LinearGradient(
                       begin: Alignment.centerLeft,
                       end: Alignment.centerRight,
                       colors: <Color>[AppConstants.listingBannerAccent,AppConstants.listingBanner]
                   )
               ),
               child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(
                         onPressed: (){

                         },
                         icon: Icon(
                           CupertinoIcons.phone_fill,color: AppConstants.thirdColor,
                         )),

                     Padding(
                       padding: EdgeInsets.only(left: 0.0),
                       child: Text("Get help with your property listing with\na missed call",
                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
                             color: AppConstants.thirdColor,fontSize: 10
                         ),),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left: 0.0),
                       child: Container(
                         width: MediaQuery.of(context).size.width * 0.25,
                         height: 30,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border.all(color: AppConstants.thirdColor),
                           borderRadius: BorderRadius.circular(8.0),
                         ),
                         child: Center(
                           child: Text("+254 700 123 456",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                               color: AppConstants.thirdColor,fontSize: 10
                           ),),
                         ),
                       ),
                     )
                   ],
                 ),
               )
             )
           ],
         ),
       ),

        isLoading ?
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
        const SizedBox()
      ],
    );
  }

  Widget emptyListings(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("For Landlords & Property Owners",style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppConstants.primaryColorAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                )
            ),

            Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Rent/Sell your property for free",style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.grey.shade700,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),),
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.white,AppConstants.listingBanner]
                  )
              ),
              child: Column(
                children: [
                  /*Expanded(
                  child: CarouselSlider(
                    items: banners.asMap().map((index, element){
                      return MapEntry(index,Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                    ),),
                                  child: Center(
                                    child: index== 0 ? Icon(
                                      Icons.money_outlined,color: Colors.white,size: 40,
                                    ): index==1 ?
                                    Icon(
                                      CupertinoIcons.time_solid,color: Colors.white,size: 40,
                                    ) :
                                    Icon(Icons.account_balance_sharp,color: Colors.white,size: 40,)
                                    ,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                  child: Text(element,style: Theme.of(context).textTheme!.bodyMedium!.copyWith(
                                    color: AppConstants.primaryColorAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),),
                                ),

                              ],
                            )
                          )
                      ));
                    }).values.toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 1.2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),*/
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child:  CarouselSlider(
                      items: banners.asMap().map((index, element){
                        return MapEntry(index,Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                                onTap: (){

                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                        ),),
                                      child: Center(
                                        child: index== 0 ? Icon(
                                          Icons.money_outlined,color: Colors.white,size: 40,
                                        ): index==1 ?
                                        Icon(
                                          CupertinoIcons.time_solid,color: Colors.white,size: 40,
                                        ) :
                                        Icon(Icons.account_balance_sharp,color: Colors.white,size: 40,)
                                        ,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                      child: Text(element,style: Theme.of(context).textTheme!.bodyMedium!.copyWith(
                                          color: AppConstants.primaryColorAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),),
                                    ),

                                  ],
                                )
                            )
                        ));
                      }).values.toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          aspectRatio: 1.2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: banners.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:_current==entry.key ?
                              AppConstants.primaryColorAccent:
                              Colors.grey.shade700

                            /* color: (Theme.of(context).brightness == Brightness.dark
                                                                    ? Colors.white
                                                                    : AppConstants.primaryColorDark)
                                                                    .withOpacity(_current == entry.key ? 1 : 0.4)*/),
                        ),
                      );
                    }).toList(),
                  ),


                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                    child: Text("Rent/Sell in 3 simple steps",style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppConstants.primaryColorAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("1",style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AppConstants.bannerTextColor
                        ),),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            //      color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Advertise your property on Somalease",style: Theme.of(context).textTheme.bodyMedium
                                !.copyWith(color: Colors.grey.shade700),),
                              ],
                            )
                        ),
                        Icon(
                          Icons.push_pin,color: AppConstants.bannerIconColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("2",style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AppConstants.bannerTextColor
                        ),),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            //      color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Connect with tenants/buyers",style: Theme.of(context).textTheme.bodyMedium
                                !.copyWith(color: Colors.grey.shade700),),
                              ],
                            )
                        ),
                        Icon(
                          CupertinoIcons.wifi,color: AppConstants.bannerIconColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("3",style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AppConstants.bannerTextColor
                        ),),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            //      color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Agree and close at your convenience",style: Theme.of(context).textTheme.bodyMedium
                                !.copyWith(color: Colors.grey.shade700),),
                              ],
                            )
                        ),
                        Icon(
                          CupertinoIcons.hand_thumbsup_fill,color: AppConstants.bannerIconColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Future<dynamic> getPropertiesByLandlordID() async{
    setState(() {
      main_property=[];
      all_property=[];
      residential_property=[];
      commercial_property=[];
      sale_property=[];
      isLoading=true;
    });
    var result = await propertyRepository.getPropertiesByLandlordID(Provider.of<Preferences>(context,listen: false)
    .user!.remember_token,Provider.of<Preferences>(context,listen: false).user!.user_id);
    if(result is List<Property>){
      setState(() {
        isLoading=false;
        main_property=result;
        all_property=result;
      });

      main_property.forEach((element) {
        if(element.propertyMaster!.property_listing_type=='Residential'){
          residential_property.add(element);
        }

        else if(element.propertyMaster!.property_listing_type=='Commercial'){
          commercial_property.add(element);
        }

        else if(element.propertyMaster!.property_listing_type=='Land/Plot'){
          sale_property.add(element);
        }
      });
      return result;
    }

    else{
      setState(() {
        isLoading=false;
        main_property=[];
      });
      return result;
    }


  }

  Future<dynamic> getProperties() async{
    setState(() {
      isLoading=true;
    });
    var result = await propertyRepository.getProperties(Provider.of<Preferences>(context,listen: false).user!.remember_token);

    if(result is List<Property>){
      setState(() {
        isLoading=false;
        main_property=result;
      });
      return result;
    }

    else{
      setState(() {
        isLoading=false;
        main_property=[];
      });
      return result;
    }

  }

  initButtonStatus(){
    property_type_status=List.filled(property_types.length, false);
    property_type_status.first=true;
  }

  setButtonStatus(int index,String property_listing_type){
    print("Property Listing type is " + property_listing_type.toString());
    for(int i=0;i<property_types.length;i++){
      if(i==index){
        setState(() {
          property_type_status[i]=true;
        });

        if(property_listing_type=='Rent'){
          setState(() {
            main_property=residential_property;
          });
        }

        else if(property_listing_type=='Commercial'){
          setState(() {
            main_property=commercial_property;
          });
        }

        else if(property_listing_type=='Sale'){
          print("Land plot selected");
          setState(() {
            main_property=sale_property;
          });
        }
        else{
          print("All property length is " + all_property.length.toString());
          setState(() {
            main_property=all_property;
          });
        }
      }

      else{
        setState(() {
          property_type_status[i]=false;
        });
      }
    }
  }

  void toggleSwitch(bool value){

    if(isSwitched==false){
      setState(() {

        isSwitched=true;
        property_status='approved';
      //  budget_switch="Use budget options";
      });
    }

    else{
      setState(() {
        isSwitched=false;
        property_status='pending';
     //   budget_switch="Enter min and max budget";
      });
    }
  }
}

/*
* Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[AppConstants.listingBannerAccent,AppConstants.listingBanner]
                )
            ),
          )
* **/