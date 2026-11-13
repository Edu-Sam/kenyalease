import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/widget/error_container.dart';
import '../../constants/module.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import '../module.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';


class SearchPropertyResult extends StatefulWidget{
  SearchPropertyResult({Key? key,required this.city,required this.town,required this.search_property_types,
  required this.search_bhk_types,required this.search_availability_types,
  required this.startVal,required this.endVal
  }) : super(key: key);
  String city;
  String town;
  List<String> search_property_types;
  List<String> search_bhk_types;
  List<String> search_availability_types;
  double startVal;
  double endVal;

  @override
  _SearchPropertyResultState createState()=> _SearchPropertyResultState();
}

class _SearchPropertyResultState extends State<SearchPropertyResult>{

  TextEditingController city_controller = TextEditingController(text: '');
  TextEditingController town_controller = TextEditingController(text: '');
  List<Property> rent_properties=[],search_properties=[],filter_properties=[];
  ErrorContainer errorContainer = ErrorContainer();
  PropertyRepository propertyRepository = PropertyRepository();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<PropertyImage> property_images=[PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
      is_primary: 0,property_id: 0),
    PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
        is_primary: 0,property_id: 0),
    PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
        is_primary: 0,property_id: 0)
  ];

  bool isLoading=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    city_controller=TextEditingController(text: widget.city);
    town_controller=TextEditingController(text: widget.town);
    getProperties();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
       isLoading ?
       Container(width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
         color: Colors.white,
         child: Center(
           child: CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
           ),
         ),
       ) :
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
            title:  Row(
              //mainAxisAlignment: MainAxisAlignment.,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Container(
                    width: 100,
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
                ),
                Container(
                  width: 100,
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child:  GestureDetector(
                  child: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,),
                ),
              )
            ],
          ),

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 20.0),
                child: Column(
                  children: search_properties.asMap().map((index, element){
                    return MapEntry(index,rentPropertiesContainer(element));
                  }).values.toList(),
                ),
              ),
            ),
          ),

         bottomNavigationBar: Container(
           width: MediaQuery.of(context).size.width,
           height: 60,
           decoration: BoxDecoration(
             color: AppConstants.navigationBackgroundColor
           ),
           child: Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width * 0.50,
                 height: 60,
                 decoration: BoxDecoration(
                   color: Colors.transparent,
                   border: Border(right: BorderSide(color: Colors.grey.shade400))
                 ),
                 child: Center(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(CupertinoIcons.chevron_up_chevron_down,color: Colors.grey.shade700,
                       size: 18,),
                       Padding(
                         padding: EdgeInsets.only(left: 10.0),
                         child: Text("Sort",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                           color: Colors.grey.shade700
                         ),),
                       )
                     ],
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.50,
                 height: 60,
                 decoration: BoxDecoration(
                     color: Colors.transparent,

                 ),

                 child: Center(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.filter_alt,color: Colors.grey.shade700,
                         size: 18,),
                       Padding(
                         padding: EdgeInsets.only(left: 10.0),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             FilterProperty(filter: null,),settings: const
                             RouteSettings(name: '/filter'))).then((value){
                               if(value is Filter){
                                 setState(() {
                                   search_properties=[];
                                   rent_properties.forEach((element) {
                                     print("element apartment: " + element.apartment_type.toString());
                                     print("element property price: " + element.property_price.toString());
                                     print("element possession: " + element.possession.toString());
                                     print("element bhk: " + element.bhk_type.toString());
                                     print("start val: " + value.startVal.toString() + " : endVal: " + value.endVal.toString());
                                     print("city: " + element.property_location.elementAt(0).city.toString());
                                     print("Current city: " + value.city.toString());
                                     if((value.filter_property_types.any((filter_element) => element.apartment_type.contains(filter_element))
                                     ) &&(value.filter_bhk_types.any((bhk_element) => element.bhk_type.contains(bhk_element)))
                                     && (element.property_location.elementAt(0).city.contains(value.city.toString()) /*||
                                         element.property_location.elementAt(0).city.contains(value.town.toString())*/)
                                        /* &&(value.filter_tenant_types.any((tenant_element) => element.property_description.elementAt(0).preferred_tenant.contains(tenant_element)))
                                         &&(value.filter_furnishing_types.any((furnishing_element) => element.property_overviews.elementAt(0).furnishing_status.contains(furnishing_element)))*/

                                         &&(double.parse(element.property_price) > value.startVal && double.parse(element.property_price) <= value.endVal)
                                     ){
                                       search_properties.add(element);
                                     }
                                   });
                                 });
                               }
                             });
                           },
                           child: Text("Filter",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                               color: Colors.grey.shade700
                           ),),
                         )
                       )
                     ],
                   ),
                 ),
               ),
             ],
           ),
         ),
        ),
      ],
    );
  }

  Future<dynamic> getProperties() async{
    widget.search_property_types.forEach((element) {
      print("Apartment property type: " + element.toString());
    });
    setState(() {
      isLoading=true;
    });
    var result = await propertyRepository.getProperties(Provider.of<Preferences>(context,listen: false).user!.remember_token);

    if(result is List<Property>){
      print("The size of property is " + result.length.toString());
      setState(() {
        rent_properties = result;
        rent_properties.forEach((element) {
          print("element apartment: " + element.apartment_type.toString());
          print("element property price: " + element.property_price.toString());
          print("element possession: " + element.possession.toString());
          print("element bhk: " + element.bhk_type.toString());
          print("start val: " + widget.startVal.toString() + " : endVal: " + widget.endVal.toString());
          if((widget.search_property_types.any((search_element) => element.apartment_type.contains(search_element))
          ) &&(widget.search_bhk_types.any((bhk_element) => element.bhk_type.contains(bhk_element)))
          &&(widget.search_availability_types.any((availability_element) => element.possession.contains(availability_element)))

          &&(double.parse(element.property_price) > widget.startVal && double.parse(element.property_price) <= widget.endVal)
          ){
            search_properties.add(element);
          }
        });
           isLoading=false;
      });

      return result;
    }
//search_element.contains(element.apartment_type)
    else{
       setState(() {
        isLoading=false;
      });
      return errorContainer.showInfoErrorDialog('Could not fetch properties', context, (){
        Navigator.pop(context);
      });
    }

  }

  Widget rentPropertiesContainer(Property property){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.35,
        //color: Colors.black,
        child:Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: property_images.asMap().map((index, element){
                  return MapEntry(index,Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              PropertyDetailsContainer(property: property)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      //  color: Colors.black,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                child: Text(property.property_name/*element.bhk_type + 'for ' + 'rent in' + element.property_location.elementAt(0).city*/,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black54
                                                  ),),
                                              ),

                                              /*Padding(
                                            padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                            child: Text(element.property_name,
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: Colors.black54
                                              ),),
                                          ),*/
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Icon(CupertinoIcons.location_solid,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    _launchWhatsapp('+254702181403');
                                                  },
                                                  child: Icon(CupertinoIcons.heart,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 0.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    makeCall('+254702181403');
                                                  },
                                                  child: Icon(CupertinoIcons.phone,color: AppConstants.primaryColor,),

                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  color: Colors.black,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.50,
                                        height: MediaQuery.of(context).size.height * 0.20,

                                        decoration: BoxDecoration(
                                          //   color: Colors.black,
                                          //  borderRadius: BorderRadius.circular(24.0),
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/property_demo.png'),
                                                fit: BoxFit.cover
                                            )
                                        ),

                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: search_properties.asMap().entries.map((entry) {
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
                                                        Colors.grey.shade100

                                                      /* color: (Theme.of(context).brightness == Brightness.dark
                                                                    ? Colors.white
                                                                    : AppConstants.primaryColorDark)
                                                                    .withOpacity(_current == entry.key ? 1 : 0.4)*/),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 110,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('KES ' + property.property_price.toString(),style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            ),
                                            Container(
                                              width: 110,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('Fully furnished',style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            ),

                                            Container(
                                              width: 110,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('1200 Sq Built up\nArea',style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                       /* Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:  Offset(1.0,1.0),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 1.0,
                                                        color: Colors.black12

                                                    )
                                                  ],),
                                                child: Center(
                                                  child: Text('1200 Sq Built up\nArea',style: Theme.of(context).textTheme
                                                      .bodySmall!.copyWith(color: Colors.black54),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )*/
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
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

            /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rent_properties.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),*/
          ],
        )
    );


  }

  _launchWhatsapp(String phone_number) async {

    var url ='whatsapp://send?text=${phone_number}';
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalNonBrowserApplication,);
    // var url = 'https://wa.me/?text=${plan.plan_title} \n ${new_plan_details}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  makeCall(String phone_number) async{
    final call = Uri.parse('tel:' + phone_number);
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

}