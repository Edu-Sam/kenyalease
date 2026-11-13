import 'package:flutter/material.dart';
import 'package:somalease/widget/image_app_bar.dart';
import '../../models/module.dart';
import '../../widget/module.dart';
import '../../constants/module.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import '../module.dart';
import 'package:provider/provider.dart';


class PropertyDetailContainer extends StatefulWidget{
  PropertyDetailContainer({Key? key,required this.property}) : super(key: key);
  Property? property;

  @override
  _PropertyDetailContainerState createState()=> _PropertyDetailContainerState();
}

class _PropertyDetailContainerState extends State<PropertyDetailContainer>{

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<PropertyImage> property_images=[PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
  is_primary: 0,property_id: 0),
    PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
        is_primary: 0,property_id: 0),
    PropertyImage(id: 0,file_name: '',file_path: '',file_type: '',
        is_primary: 0,property_id: 0)
  ];
  bool showDescription=false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Property Details1',style: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppConstants.primaryColor
        ),),
        centerTitle: true,
        leading: IconButton(
          icon:  Icon(CupertinoIcons.back,color: AppConstants.primaryColorDark,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),*/
      /*appBar: ImageAppBar(
        height: 52,
        app_title: Text(''),
        onExit: (){
          Navigator.pop(context);
        },
        leading: IconButton(
          icon:Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){

          },
        ),
      ),*/
     extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade100,
        child: Stack(
       //   mainAxisSize: MainAxisSize.min,
      //    alignment: Alignment.topCenter,
         // fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade100,
                    child:  Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 0.0,bottom: 5.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.35,
                                //color: Colors.green,
                                color: Colors.black,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Expanded(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CarouselSlider(

                                              items: /*widget.property!.*/property_images.asMap().map((index, element){
                                                return MapEntry(index,Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                                                    child:  Container(
                                                      width: MediaQuery.of(context).size.width * 0.70,
                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                      decoration: BoxDecoration(
                                                        //   color: Colors.black,
                                                        //  borderRadius: BorderRadius.circular(24.0),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/property_demo.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: property_images.asMap().entries.map((entry) {
                                                                return GestureDetector(
                                                                  onTap: () => _controller.animateToPage(entry.key),
                                                                  child: Container(
                                                                    width: 12.0,
                                                                    height: 12.0,
                                                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color:_current==entry.key ?
                                                                        AppConstants.primaryColorDark:
                                                                        Colors.grey.shade100

                                                                      /* color: (Theme.of(context).brightness == Brightness.dark
                                                                    ? Colors.white
                                                                    : AppConstants.primaryColorDark)
                                                                    .withOpacity(_current == entry.key ? 1 : 0.4)*/),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ));
                                              }).values.toList(),
                                              carouselController: _controller,
                                              options: CarouselOptions(
                                                  autoPlay: true,
                                                  enlargeCenterPage: false,
                                                  viewportFraction: 1,
                                                  aspectRatio: 1,
                                                  onPageChanged: (index, reason) {
                                                    setState(() {
                                                      _current = index;
                                                    });
                                                  }),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: IconButton(
                                                onPressed: () {
                                                  // Use the controller to change the current page
                                                  _controller.previousPage();
                                                },
                                                icon: Icon(CupertinoIcons.back,color: Colors.white,),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  // Use the controller to change the current page
                                                  _controller.nextPage();
                                                },
                                                icon: Icon(CupertinoIcons.forward,color: Colors.white,),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),

                                    /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.property!.property_image.asMap().entries.map((entry) {
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
                                          : AppConstants.primaryColorDark)
                                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),*/


                                  ],
                                )
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 0.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(1.0,1.0),
                                            spreadRadius: 1.0,
                                            blurRadius: 1.0,
                                            color: Colors.black26
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                height: MediaQuery.of(context).size.height * 0.10,
                                                decoration: BoxDecoration(
                                                    border: Border(right: BorderSide(color: Colors.grey.shade200))
                                                ),
                                                // color: Colors.black,
                                                child:  Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 5.0),
                                                      child: Text(widget.property!.bhk_type + 'for ' + 'rent in ' +
                                                          widget.property!.property_location.elementAt(0).address
                                                            .toString(),
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600
                                                        ),),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 0.0),
                                                      child: Text( widget.property!.property_location.elementAt(0).address
                                                          .toString(),
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400
                                                        ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              /*VerticalDivider(
                                            color: Colors.black54,
                                            width: 100,
                                            indent: 0,
                                            endIndent: 0,

                                          ),*/
                                              Padding(
                                                  padding: EdgeInsets.only(left : 20.0),
                                                  child: Container(
                                                    //   color: Colors.black,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: 5.0),
                                                          child: Text('KES ' + widget.property!.property_price.toString()
                                                              + '/=+',
                                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                color: Colors.grey.shade600,fontWeight: FontWeight.w400,
                                                                fontSize: 12
                                                            ),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: 5.0),
                                                          child: Text('Service Charge\nPer month\n' + widget.property
                                                    !.property_overviews.elementAt(0).builtup_area.toString() + 'Sqft',
                                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                color: Colors.grey.shade600,fontWeight: FontWeight.w400,
                                                                fontSize: 12
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              )

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            children: [
                                              Icon(CupertinoIcons.bolt_fill,color: AppConstants.primaryColor,),
                                              Padding(
                                                padding: EdgeInsets.only(left: 5.0),
                                                child: Text("94 People viewed this property in the last 24 hours",
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: AppConstants.primaryColor,fontWeight:
                                                  FontWeight.w600,
                                                      fontSize: 12
                                                  ),),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1.0,1.0),
                                              spreadRadius: 1.0,
                                              blurRadius: 1.0,
                                              color: Colors.black26
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Deposit'
                                            //widget.property!.property_overviews.elementAt(0).expected_deposit.toString()
                                            ,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.grey.shade600,fontWeight: FontWeight.w400,
                                              fontSize: 14
                                          ),
                                          ),

                                          Text(

                                            widget.property!.property_overviews.elementAt(0).expected_deposit.toString()
                                            ,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.grey.shade600,fontWeight: FontWeight.w400,
                                              fontSize: 14
                                          ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  //   height: MediaQuery.of(context).size.height * 0.40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(1.0,1.0),
                                            spreadRadius: 1.0,
                                            blurRadius: 1.0,
                                            color: Colors.black26
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                // width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(CupertinoIcons.bed_double,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(widget.property!.no_of_bedrooms.toString() +
                                                                  ' Bedroom',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' No of Bedroom',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                //  width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(CupertinoIcons.building_2_fill,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                widget.property!.apartment_type.toString(),
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Property Type',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                // width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.bathroom_outlined,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(widget.property!.no_of_bathrooms.toString() +
                                                                  ' Bathroom',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' No of Bathroom',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                //  width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.key_outlined,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                widget.property!.possession.toString(),
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Possession',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                // width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.room_service_rounded,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(widget.property!.property_description.elementAt(0)
                                                              .non_veg_allowed ==1 ? "Yes" : "No",

                                                               // widget.property!.property_description.elementAt(0).non_veg_allowed.toString(),
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Non-Veg Allowed',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                //  width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.person,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                widget.property!.property_overviews.elementAt(0).gated_security.toString(),
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Gated Security',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                // width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(CupertinoIcons.archivebox,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: FittedBox(

                                                                  child: Container(
                                                                    child: Text(widget.property!.property_overviews.elementAt(0)
                                                              .furnishing_status.toString()
                                                                      ,
                                                                      style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                          color: Colors.black,fontSize: 14,
                                                                          fontWeight: FontWeight.w700
                                                                      ),
                                                                    ),
                                                                  )
                                                              ),

                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Furnishing',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 0.0,right: 0.0),
                                              child: Container(
                                                //  width: MediaQuery.of(context).size.width * 0.45,
                                                width: 165,
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.person,color: Colors.grey.shade500,
                                                        size: 40,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 5.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(

                                                                widget.property!.property_overviews.elementAt(0)
                                                            .parking.toString()=='Both' ? "Bike And Car" : widget.property!.property_overviews.elementAt(0)
                                                                    .parking.toString(),
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.black,fontSize: 14,
                                                                    fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: 5.0),
                                                              child: Text(
                                                                ' Parking',
                                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                                    color: Colors.grey.shade700,fontSize: 12,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.30,
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1.0,1.0),
                                              spreadRadius: 1.0,
                                              blurRadius: 1.0,
                                              color: Colors.black26
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                          children: [

                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Divider(color: Colors.grey,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * 0.18,
                                                child: ListView(
                                                  scrollDirection: Axis.horizontal,
                                                  padding: EdgeInsets.only(left: 20.0),
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 20.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.80,
                                                        height: MediaQuery.of(context).size.height * 0.18,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.shade400)
                                                        ),

                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(CupertinoIcons.calendar,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Posted On ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text("Apr 8 2023",style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(CupertinoIcons.building_2_fill,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Age of building ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text("Newly Constructed",style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(CupertinoIcons.building_2_fill,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Floor ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text('0/5'/*widget.property!.property_overviews.elementAt(0)
                                                                .floor.toString()*/,style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            // DottedLine(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 20.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.80,
                                                        height: MediaQuery.of(context).size.height * 0.18,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.shade400)
                                                        ),

                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.balcony,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Balcony ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text(widget.property!.no_of_bathrooms.toString(),style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(CupertinoIcons.person,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Preferred Tenant ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text('Anyone'/*widget.property!.property_description.elementAt(0)
                                                                .preferred_tenant.toString()*/,style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(CupertinoIcons.building_2_fill,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Power Backup ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text(widget.property!.power_backup.toString()/*widget.property!.property_overviews.elementAt(0)
                                                                .floor.toString()*/,style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            // DottedLine(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 20.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.80,
                                                        height: MediaQuery.of(context).size.height * 0.18,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.shade400)
                                                        ),

                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.balcony,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Facing ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text('NA',style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.water,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Water Supply ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text('Borewell'/*widget.property!.property_description.elementAt(0)
                                                                .preferred_tenant.toString()*/,style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            DottedLine(),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0,bottom: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.settings,color: Colors.grey.shade700,),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0),
                                                                        child: Text("Maintenance ",style: Theme.of(context).textTheme
                                                                            .bodyMedium!.copyWith(color: Colors.black,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                                    child: Text(widget.property!.power_backup.toString()/*widget.property!.property_overviews.elementAt(0)
                                                                .floor.toString()*/,style: Theme.of(context).textTheme
                                                                        .bodyMedium!.copyWith(color: Colors.black,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12)),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            // DottedLine(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5.0),
                                child: AnimatedContainer(
                                  width: MediaQuery.of(context).size.width,
                                  height: showDescription==false ?
                                  MediaQuery.of(context).size.height * 0.25 :
                                  double.infinity,
                                  duration: Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(1.0,1.0),
                                            spreadRadius: 1.0,
                                            blurRadius: 1.0,
                                            color: Colors.black26
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Divider(color: Colors.grey,),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0,),
                                          child: Text("Description",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade600
                                          ),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0,),
                                          child: Text(widget.property!.property_description.elementAt(0)
                                      .description.toString()/*"Clean,Secure Apartments"*/,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.grey.shade600
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0,left: 0.0,right: 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(1.0,1.0),
                                            spreadRadius: 1.0,
                                            blurRadius: 1.0,
                                            color: Colors.black26
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20.0,),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                          child: Text("Amenities",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColor
                                          ),),
                                        ),
                                        GridView.count(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20.0,
                                          mainAxisSpacing: 10.0,
                                          childAspectRatio: 9/8,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.wifi,color: AppConstants.appOrangeColor,
                                                    size: 50,),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text('Lift',style: Theme.of(context).textTheme
                                                        .bodySmall!.copyWith(color: AppConstants.thirdColor,
                                                        fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.wifi,color: AppConstants.appOrangeColor,
                                                    size: 50,),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text('Lift',style: Theme.of(context).textTheme
                                                        .bodySmall!.copyWith(color: AppConstants.thirdColor,
                                                        fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.wifi,color: AppConstants.appOrangeColor,
                                                    size: 50,),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text('Lift',style: Theme.of(context).textTheme
                                                        .bodySmall!.copyWith(color: AppConstants.thirdColor,
                                                        fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.wifi,color: AppConstants.appOrangeColor,
                                                    size: 50,),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text('Lift',style: Theme.of(context).textTheme
                                                        .bodySmall!.copyWith(color: AppConstants.thirdColor,
                                                        fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(color: Colors.grey.shade400,indent: 20.0,
                                          endIndent: 20.0,),
                                        GestureDetector(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: Text("Show less",style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(
                                                    color: AppConstants.thirdColor
                                                ),),

                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(right: 5.0),
                                                  child: Icon(Icons.keyboard_arrow_up_outlined,color: AppConstants.thirdColor,),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(1.0,1.0),
                                                spreadRadius: 1.0,
                                                blurRadius: 1.0,
                                                color: Colors.black26
                                            )
                                          ]
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              /*Text('This property is available for viewing on Monday,Wednesday \n'
                                                  'and Saturday from 5:00pm-7:00pm',style: Theme.of(context).textTheme
                                                .bodySmall!.copyWith(color: Colors.grey.shade700)),*/
                                                Text('This property is available for viewing on ' + getPropertyDays(
                                                    widget.property!.property_days
                                                ),style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.grey.shade700),),

                                                Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text("Contact for viewing",style: Theme.of(context)
                                                          .textTheme.bodyMedium!.copyWith(
                                                        color: AppConstants.thirdColor
                                                    ),),
                                                )
                                              ],
                                          ),
                                      ),
                                  ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom:10.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(1.0,1.0),
                                                spreadRadius: 1.0,
                                                blurRadius: 1.0,
                                                color: Colors.black26
                                            )
                                          ]
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(bottom: 10.0),
                                                  child: Text("Report what was not correct in this property",
                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                          color: Colors.grey.shade700
                                                      ),),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(bottom: 0.0),
                                                  child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){

                                                          },
                                                          child: Container(
                                                            width: 120,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color:
                                                                Colors.grey.shade500,
                                                                ),
                                                                borderRadius: BorderRadius.circular(5.0)
                                                            ),
                                                            child: Center(
                                                              child: Text("Listed By Broker",style:
                                                              Theme.of(context).textTheme
                                                                  .bodyMedium!.copyWith(
                                                                  color: Colors.black87
                                                              ),),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){

                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color:
                                                                Colors.grey.shade500,
                                                                ),
                                                                borderRadius: BorderRadius.circular(5.0)
                                                            ),
                                                            child: Center(
                                                              child: Text("Rented Out",style:
                                                              Theme.of(context).textTheme
                                                                  .bodyMedium!.copyWith(
                                                                  color: Colors.black87
                                                              ),),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){

                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(color:
                                                                Colors.grey.shade500,
                                                                ),
                                                                borderRadius: BorderRadius.circular(5.0)
                                                            ),
                                                            child: Center(
                                                              child: Text("Wrong Info",style:
                                                              Theme.of(context).textTheme
                                                                  .bodyMedium!.copyWith(
                                                                  color: Colors.black87
                                                              ),),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                  ),
                                              )
                                            ],
                                          ),
                                      ),
                                  ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1.0,1.0),
                                              spreadRadius: 1.0,
                                              blurRadius: 1.0,
                                              color: Colors.black26
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 170,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: AppConstants.thirdColorDark))
                                                 //     color: Colors.black
                                                  ),
                                                  child: Center(
                                                      child: Text("Activity On This Property",style:
                                                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                             color: Colors.black54
                                                        ),),
                                                  ),
                                              ),

                                              Padding(
                                                  padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                                                  child: Row(

                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets.only(right: 5.0),
                                                          child:Container(
                                                              width: 100,
                                                               height: 80,
                                                              decoration: BoxDecoration(
                                                            //      color:Colors.red
                                                                color: AppConstants.appActivityColorAccent
                                                              ),
                                                            child: Column(
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        width: 30,
                                                                        height: 30,
                                                                        color: AppConstants.appActivityColor,
                                                                        child: Center(
                                                                          child: Icon(
                                                                            CupertinoIcons.person_fill,
                                                                            color: Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      Padding(
                                                                        padding: EdgeInsets.only(left: 10.0,top: 6.0),
                                                                        child: Text("0",style: Theme.of(context)
                                                                            .textTheme.bodySmall!.copyWith(
                                                                            color: Colors.black54
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                      padding:EdgeInsets.only(top: 10.0),
                                                                      child: Text("Unique Views",
                                                                          style: Theme.of(context).textTheme.bodySmall
                                                                          !.copyWith(
                                                                              color: Colors.black54,
                                                                              fontSize: 14
                                                                          ),),
                                                                  )
                                                                ],
                                                            )
                                                          )
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(right: 5.0),
                                                            child:Container(
                                                                width: 100,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                  //      color:Colors.red
                                                                    color: AppConstants.appActivityColorAccent
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width: 30,
                                                                          height: 30,
                                                                          color: AppConstants.appActivityColor,
                                                                          child: Center(
                                                                            child: Icon(
                                                                              CupertinoIcons.heart_fill,
                                                                              color: Colors.black54,
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        Padding(
                                                                          padding: EdgeInsets.only(left: 10.0,top: 6.0),
                                                                          child: Text("0",style: Theme.of(context)
                                                                              .textTheme.bodySmall!.copyWith(
                                                                              color: Colors.black54
                                                                          ),),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:EdgeInsets.only(top: 10.0),
                                                                      child: Text("Shortlists",
                                                                        style: Theme.of(context).textTheme.bodySmall
                                                                        !.copyWith(
                                                                            color: Colors.black54,
                                                                            fontSize: 14
                                                                        ),),
                                                                    )
                                                                  ],
                                                                )
                                                            )
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(right: 5.0),
                                                            child:Container(
                                                                width: 100,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                  //      color:Colors.red
                                                                    color: AppConstants.appActivityColorAccent
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width: 30,
                                                                          height: 30,
                                                                          color: AppConstants.appActivityColor,
                                                                          child: Center(
                                                                            child: Icon(
                                                                              CupertinoIcons.person_fill,
                                                                              color: Colors.black54,
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        Padding(
                                                                          padding: EdgeInsets.only(left: 10.0,top: 6.0),
                                                                          child: Text("0",style: Theme.of(context)
                                                                              .textTheme.bodySmall!.copyWith(
                                                                              color: Colors.black54
                                                                          ),),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:EdgeInsets.only(top: 10.0),
                                                                      child: Text("Contacted",
                                                                        style: Theme.of(context).textTheme.bodySmall
                                                                        !.copyWith(
                                                                            color: Colors.black54,
                                                                            fontSize: 14
                                                                        ),),
                                                                    )
                                                                  ],
                                                                )
                                                            )
                                                        ),
                                                      ],
                                                  ),
                                              )
                                            ],
                                        ),
                                    ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(1.0,1.0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 1.0,
                                                    color: Colors.black26
                                                )
                                              ]
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 50.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 10.0),
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.90,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey.shade400)
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.only(bottom: 30.0),
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 10.0),
                                                                child: Stack(
                                                                  alignment: Alignment.bottomRight,
                                                                  children: [
                                                                    Container(width: MediaQuery.of(context).size.width,
                                                                      height: MediaQuery.of(context).size.height * 0.30,
                                                                      decoration: const BoxDecoration(
                                                                          image: DecorationImage(
                                                                              image: AssetImage("assets/images/emptyPropertyLarge.png")
                                                                          )
                                                                      ),
                                                                    ),

                                                                    Align(
                                                                      alignment: Alignment.bottomRight,
                                                                      child: GestureDetector(
                                                                        child: Container(
                                                                          width: 100,
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                              gradient: LinearGradient(
                                                                                  begin: Alignment.centerLeft,
                                                                                  end: Alignment.centerRight,
                                                                                  colors: <Color>[AppConstants.primaryColor,
                                                                                    AppConstants.primaryColorDark]
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0)
                                                                          ),
                                                                          child: Center(
                                                                              child: Text("Within a km",style:
                                                                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                                  color: Colors.white,
                                                                                  fontWeight:FontWeight.w600
                                                                              ),)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(bottom: 5.0,top: 20.0),
                                                                child: Text(widget.property!.bhk_type + ' Apartment ' + 'in ' +
                                                                    'Nairobi',
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.w700
                                                                  ),),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets.only(top: 20),
                                                                  child: IntrinsicHeight(
                                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                              height: 80,
                                                                              child: Column(
                                                                                  children:[
                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(bottom: 10),
                                                                                      child: Text("Deposit",style: Theme
                                                                                          .of(context).textTheme.bodySmall!.copyWith(
                                                                                          color: Colors.grey.shade700,
                                                                                          fontSize: 14
                                                                                      ),),
                                                                                    ),

                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(top: 10),
                                                                                      child: Text("KES " + widget.property
                                                                                      !.property_price.toString(),style: Theme
                                                                                          .of(context).textTheme.bodyMedium!.copyWith(
                                                                                          color: Colors.black,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w600
                                                                                      ),),
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                            ),
                                                                            VerticalDivider(),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                              height: 80,
                                                                              child: Column(
                                                                                  children:[
                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(bottom: 10),
                                                                                      child: Text("Area",style: Theme
                                                                                          .of(context).textTheme.bodySmall!.copyWith(
                                                                                          color: Colors.grey.shade700,
                                                                                          fontSize: 14
                                                                                      ),),
                                                                                    ),

                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(top: 10),
                                                                                      child: Text(widget.property
                                                                                      !.property_overviews.elementAt(0).builtup_area.toString() + 'Sqft',style: Theme
                                                                                          .of(context).textTheme.bodyMedium!.copyWith(
                                                                                          color: Colors.black,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w600
                                                                                      ),),
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                            ),
                                                                            VerticalDivider(),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                              height: 80,
                                                                              child: Column(
                                                                                  children:[
                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(bottom: 10),
                                                                                      child: Text("Possession",style: Theme
                                                                                          .of(context).textTheme.bodySmall!.copyWith(
                                                                                          color: Colors.grey.shade700,
                                                                                          fontSize: 14
                                                                                      ),),
                                                                                    ),

                                                                                    Padding(
                                                                                      padding:EdgeInsets.only(top: 10),
                                                                                      child: Text(widget.property!.possession.toString(),style: Theme
                                                                                          .of(context).textTheme.bodyMedium!.copyWith(
                                                                                          color: Colors.black,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w600
                                                                                      ),),
                                                                                    ),
                                                                                  ]
                                                                              ),
                                                                            ),
                                                                          ]
                                                                      )
                                                                  )
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                              ),

                                                              Divider(indent: 30,endIndent: 30),

                                                              Padding(
                                                                padding: EdgeInsets.only(left: 20.0,right: 20.0),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children:[
                                                                      Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(bottom: 10.0),
                                                                            child: Text("Rent amount: ",style: Theme
                                                                                .of(context).textTheme.bodySmall!.copyWith(
                                                                                color: Colors.grey.shade700,
                                                                                fontSize: 14
                                                                            ),),
                                                                          ),

                                                                          Padding(
                                                                            padding: EdgeInsets.only(bottom: 0.0),
                                                                            child: Text("KES " + widget.property!.property_price.toString(),
                                                                              style: Theme
                                                                                  .of(context).textTheme.bodyMedium!.copyWith(
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w600
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap: (){
                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                            ChatScreen(
                                                                              currentUser:Provider.of<Preferences>(context,listen: false)
                                                                              .user!.user_id.toString(),
                                                                              recepientID: widget.property!.landlord_id.toString(),
                                                                              message_title: widget.property!.property_name,
                                                                              property_name: widget.property!.propertyMaster!.property_master_name,
                                                                              sender_name: Provider.of<Preferences>(context,listen: false)
                                                                              .user!.firstname + ' ' + Provider.of<Preferences>(context,listen: false)
                                                                              .user!.lastname.toString(),
                                                                            )));
                                                                          },
                                                                        child: Container(
                                                                          width: 120,
                                                                          height: 52,
                                                                          decoration: BoxDecoration(
                                                                            gradient: LinearGradient(
                                                                                begin: Alignment.centerLeft,
                                                                                end: Alignment.centerRight,
                                                                                colors: <Color>[AppConstants.primaryColor,
                                                                                  AppConstants.primaryColorDark]
                                                                            ),
                                                                            //   borderRadius: BorderRadius.circular(10.0)
                                                                          ),
                                                                          child: Center(
                                                                              child: Text("Contact",style:
                                                                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                                  color: Colors.white,
                                                                                  fontWeight:FontWeight.w600
                                                                              ),)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                ),
                                                              )
                                                            ]
                                                        ),
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          //  color: Colors.white,
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                              ),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(1.0,1.0),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 1.0,
                                                  color: Colors.black26
                                              )
                                            ]
                                        ),
                                          child: Center(
                                            child: Text("More " + widget.property!.bhk_type + " for rent in Nairobi",
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))
                                          )
                                      )
                                    ],
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    color: Colors.transparent.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.arrow_back,color: Colors.white,
                              size: 40,),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.share,color: Colors.white,),
                              ),
                              IconButton(
                                onPressed: () {

                                },
                                icon: Icon(CupertinoIcons.heart_fill,color: Colors.white,),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              )
            )
          ],
        )
      ),
    );
  }

  String getPropertyDays(List<PropertyDay> property_days){
    String day='';
    property_days.asMap().forEach((index, element){
      day=day + element.viewing_day.toString();
      if(index==property_days.length -1 ){
        day=day+ ' ';
      }

      else if(index==property_days.length-2){
        day=day + " and ";
      }
      else{
        day=day + ',';
      }
    });

    day= day + "from " + property_days.elementAt(0).from_time.toString() + " to " + property_days.elementAt(0)
    .to_time;
    return day;
  }
}