import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/view/module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PropertyDetailsContainer extends StatefulWidget{
  PropertyDetailsContainer({Key? key,required this.property}) : super(key: key);
  Property? property;

  @override
  _PropertyDetailsContainerState createState()=> _PropertyDetailsContainerState();
}

class _PropertyDetailsContainerState extends State<PropertyDetailsContainer>{

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Property Details',style: Theme.of(context).textTheme.headline6!.copyWith(
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
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Align(
                 alignment: Alignment.center,
                 child:  Padding(
                   padding: EdgeInsets.only(top: 20.0,),
                   child: Text(widget.property!.property_name,style: Theme.of(context).textTheme!.headline6!.copyWith(
                       color: Colors.black54
                   ),),
                 ),
               ),

                Padding(
                  padding: EdgeInsets.only(top: 0.0,bottom: 20.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.50,
                      //color: Colors.black,
                      child:Column(
                        children: [
                          Expanded(
                            child: CarouselSlider(
                              items: widget.property!.property_image.asMap().map((index, element){
                                return MapEntry(index,Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                            /*Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height * 0.06,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                            child: Text(widget.property!.bhk_type + 'for ' + 'rent in' + widget.property!.property_location.elementAt(0).city,
                                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                  color: Colors.black54
                                                              ),),
                                                          ),

                                                          Padding(
                                                            padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                            child: Text(widget.property!.property_name,
                                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                  color: Colors.black54
                                                              ),),
                                                          ),
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

                                                              },
                                                              child: Icon(CupertinoIcons.heart,color: AppConstants.primaryColor,),

                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 0.0),
                                                            child: InkWell(
                                                              onTap: (){

                                                              },
                                                              child: Icon(CupertinoIcons.phone,color: AppConstants.primaryColor,),

                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ),*/
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 0.26,

                                              decoration: BoxDecoration(
                                                //   color: Colors.black,
                                                //  borderRadius: BorderRadius.circular(24.0),
                                                  image: DecorationImage(
                                                      image: AssetImage('assets/images/property_demo.png'),
                                                      fit: BoxFit.cover
                                                  )
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
                                                            child: Text('KES ' + widget.property!.property_price,style: Theme.of(context).textTheme
                                                                .bodySmall!.copyWith(color: Colors.black54),),
                                                          ),
                                                        ),
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
                                                            child: Text('Fully furnished',style: Theme.of(context).textTheme
                                                                .bodySmall!.copyWith(color: Colors.black54),),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
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
                                                          /* Container(
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
                                        child: Text('Fully furnished',style: Theme.of(context).textTheme
                                            .bodySmall!.copyWith(color: Colors.black54),),
                                      ),
                                    )*/
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
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
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                            ),
                          ),

                          Row(
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
                                          : Colors.black)
                                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),


                        ],
                      )
                  )
                ),

               Align(
                 alignment: Alignment.center,
                 child:  Padding(
                   padding: EdgeInsets.only(bottom: 10.0),
                   child: Text("General Info",style: Theme.of(context).textTheme.headline6!.copyWith(
                       color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                   ),),
                 ),
               ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(widget.property!.property_name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,fontWeight: FontWeight.w600
                  ),),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text('Location:' + widget.property!.property_location.elementAt(0).address,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,fontWeight: FontWeight.w500
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text('Property type: ' + widget.property!.apartment_type,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500
                  ),),
                ),

               Align(
                 alignment: Alignment.center,
                 child:  Padding(
                   padding: EdgeInsets.only(bottom: 10.0),
                   child: Text("Description",style: Theme.of(context).textTheme.headline6!.copyWith(
                       color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                   ),),
                 ),
               ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(widget.property!.property_description.elementAt(0).description,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,fontWeight: FontWeight.w600
                  ),),
                ),

               Align(
                 alignment: Alignment.center,
                 child:  Padding(
                   padding: EdgeInsets.only(bottom: 10.0,top: 20.0),
                   child: Text("Overview",style: Theme.of(context).textTheme.headline6!.copyWith(
                       color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                   ),),
                 ),
               ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    //color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('BHK Type',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.bhk_type,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Floors',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).total_floor.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Parking',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).parking.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Facing',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).facing,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Gated Security',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).gated_security,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('BuiltUp Area',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).builtup_area.toString()
                                              + ' Sq ft',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Age of building',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).age_of_building.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              /*Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('BuiltUp Area',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).
                                              + ' Sq ft',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Unit Information",style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black54,fontSize: 18
                    ),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    //color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('No of Bedrooms',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.no_of_bedrooms,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColorDark,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('No of bathrooms',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                         //   border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.no_of_bathrooms,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColorDark,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Balcony',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                        //    border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.balcony=='0' ? 'Not Available' : 'Available',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColorDark,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Furnishing',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,fontWeight: FontWeight.w600,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                           // border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).furnishing_status,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColorDark,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Power Backup',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black87,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                         //   border: Border.all(color: Colors.grey.shade300)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.power_backup.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: AppConstants.thirdColorDark,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text("Rent Details",style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black54,fontSize: 18
                    ),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    //color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Expected Rent',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text('Ksh ' + widget.property!.property_overviews.elementAt(0).expected_rent.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text('Expected Deposit',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.black54,fontWeight: FontWeight.normal,
                                        fontSize: 14
                                    ),),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                             border: Border.all(color: Colors.grey.shade300),
                                             borderRadius: BorderRadius.circular(6.0)
                                        ),
                                        child: Center(
                                          child: Text(widget.property!.property_overviews.elementAt(0).expected_deposit.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.black54,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          UpdateProperty(property: widget.property)));
                        },
                        child: Container(
                       //   width: 120,
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 48,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                              ),
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          child: Center(
                            child: Text('Edit',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white,fontSize: 15
                            ),),
                          ),
                        ),
                      ),
                      /*Container(
                        width: 120,
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(16.0)
                        ),
                        child: Center(
                          child: Text('Delete',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black54,fontSize: 15
                          ),),
                        ),
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 // /updateproperty
}