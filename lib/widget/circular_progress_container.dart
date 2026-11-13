import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/module.dart';
import '../models/module.dart';
import 'package:provider/provider.dart';

class CircularProgressContainer extends StatelessWidget{

  CircularProgressContainer({Key? key,required this.message}):super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius),
      child: Container(
        width: 295, /* *  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                AppConstants.dialogBorderRadius)),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child:  Text(message,style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.openSans().fontFamily),),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}