import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/module.dart';

class ServiceContainer extends StatelessWidget{
  ServiceContainer({Key? key,required this.specialization,required this.field_icon}): super(key: key);
  String specialization;
  String field_icon;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(specialization.isNotEmpty || field_icon.isNotEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
            )
          // color: Colors.grey.shade100
        ),
            /*decoration: BoxDecoration(
                color: AppConstants.serviceBackground.withOpacity(0.5),
                shape: BoxShape.circle,
            ),*/

            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/' + field_icon.toString())
                  )
                ),
              )/*Icon(CupertinoIcons.person,
             //   color: Colors.red,
                color: AppConstants.primaryColorAccent,

              ),*/
            ),

          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(field_icon)
                    )
                ),
              ),*/

                Padding(
                  padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
                  child: Text(specialization,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppConstants.primaryColorDark,fontSize: 12,fontWeight: FontWeight.w400,

                  ),),
                )
              ],
            ),
          ),
        ],
      );
    }

    else{
      return Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0.0,3.0),
                  spreadRadius: 1.0,
                  blurRadius: 1.0,
                  color: Colors.black12
              )
            ]),

        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Text('...',style: TextStyle(color: Colors.black,fontSize: 40),),
                ),
              ),


            ],
          ),
        ),
      );
    }
  }
}