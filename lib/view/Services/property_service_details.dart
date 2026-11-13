import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../module.dart';
import '../../models/module.dart';

class PropertyServiceDetails extends StatefulWidget{
  PropertyServiceDetails({Key? key,required this.propertyService,required this.service_type}):super(key:key);
  PropertyService? propertyService;
  String? service_type;


  @override
  _PropertyServiceDetailState createState()=> _PropertyServiceDetailState();
}

class _PropertyServiceDetailState extends State<PropertyServiceDetails>{


  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Provider information',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,color: AppConstants.primaryColor,),
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
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   /* Padding(
                      padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Icon(CupertinoIcons.briefcase),
                        ),
                      ),),*/

                   /* Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text('General Info',style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppConstants.primaryColorAccent,fontSize: 16
                      ),),
                    ),*/
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 0.0),
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(16.0),
                         boxShadow: [
                           BoxShadow(
                             offset: const Offset(1.0,1.0),
                             blurRadius: 1.0,
                             spreadRadius: 1.0,
                             color: Colors.black12
                           )
                         ]
                       ),
                       child:  Padding(
                         padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text(widget.propertyService!.name,style: Theme.of(context).textTheme.headline5!.copyWith(
                                   color: Colors.black54,fontWeight: FontWeight.w600
                               ),textAlign: TextAlign.start,),
                             ),

                             Divider(
                               endIndent: 0.0,
                               indent: 0.0,
                               color: Colors.grey.shade300,
                             ),

                             /*Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text("General Info",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                          ),),
                        ),*/
                             widget.service_type!.isNotEmpty ?
                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text('Category:' + widget.service_type!,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                   color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 16
                               ),
                                 textAlign: TextAlign.start,
                               ),
                             ) : const SizedBox(),


                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text('Location:' + widget.propertyService!.location_name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                   color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 14
                               ),),
                             ),


                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text('Email:' + widget.propertyService!.email,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                   color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 14
                               ),),
                             ),

                             Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text("Description",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                          ),),
                        ),

                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text(widget.propertyService!.description,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                   color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 14
                               ),),
                             ),

                             Divider(endIndent: 0.0,indent: 0.0,color: Colors.grey.shade300,),


                             Padding(
                               padding: EdgeInsets.only(bottom: 10.0),
                               child: Text("Contact Info",style: Theme.of(context).textTheme.headline6!.copyWith(
                                   color: AppConstants.primaryColor,fontWeight: FontWeight.w700
                               ),),
                             ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Icon(Icons.chat,color: AppConstants.primaryColor,),

                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Icon(CupertinoIcons.phone,color: AppConstants.primaryColor,),

                                    ),
                                  )
                                ],
                              ),
                            )
                           ],
                         ),
                       )
                     ),
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
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }
}

