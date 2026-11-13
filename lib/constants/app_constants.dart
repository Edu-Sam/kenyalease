import 'module.dart';
import 'package:flutter/material.dart';

class AppConstants{
  // static final Color primaryColor=HexColor.fromHex("#010634");
  static Color primaryColor= HexColor.fromHex("#bd406e");
  static Color primaryColorAccent = HexColor.fromHex("#992767");
  static Color primaryColorDark = HexColor.fromHex("#672b73");
  static Color secondaryColor = HexColor.fromHex("#bf416e");
 // static Color secondaryColor=HexColor.fromHex("#692c73");
  static Color thirdColor=HexColor.fromHex("#aa3f2a");
  static Color thirdColorAccent = HexColor.fromHex("#b75b40");
  static Color thirdColorDark = HexColor.fromHex("#790804");
  static Color iconColor=const Color.fromRGBO(170,90,27,1);
  static Color iconColor2=const Color.fromRGBO(181,109,57,1);
  // static Color fourthColor=HexColor.fromHex("#7E5109");
  static Color fourthColor=const Color.fromRGBO(170,90,27,1);
  static final Color backgroundColor=HexColor.fromHex("F6F5F5");
  static final Color greyColor=HexColor.fromHex("#DADADA");
  static final Color serviceBackground = HexColor.fromHex("#fff4d1");
  static final Color listingBanner = HexColor.fromHex("#feefbb");
  static final Color listingBannerAccent = HexColor.fromHex("#fffef3");
  static final Color appOrangeColor=HexColor.fromHex("#fcb349");
  static final Color appActivityColorAccent = HexColor.fromHex("#f8fcfc");
  static final Color appActivityColor = HexColor.fromHex("#f0f8f8");
  static final Color textBackgroundColor = HexColor.fromHex("#f8f8fe");
  static final Color navigationBackgroundColor = HexColor.fromHex("#f8f8fe");
  static final Color bannerTextColor = HexColor.fromHex("#7769c9");
  static final Color bannerIconColor = HexColor.fromHex("#85a7e6");
 // static final Color messageColor = HexColor.fromHex("#fff4ee");
  //static final Color messageRecepientColor = HexColor.fromHex("#fff4ee");
  static final Color messageColor=HexColor.fromHex("#f8f8fe");
  static final Color messageRecepientColor = HexColor.fromHex("#fff4ee");
  static final Color manage_icon_color=HexColor.fromHex("#b20a18");
  static const double dialogBorderRadius=8.0;
  static const double horizontal_margin=16.0;
  static const double widget_height1=48;
  static const width_offset=1;
  static const height_offset=1;

  static const double base_width=375.0;   ///Iphone 11 Pro
  static const double tablet_base_width=600.0; /// Tablets

  static const double vertical_margin=20.0;


  static bool isBigger(double screenSize){
    if(screenSize > base_width){
      return true;
    }

    else{
      return false;
    }

  }

  static bool isBigger600(double screenSize){
    if(screenSize > base_width){
      return true;
    }

    else{
      return false;
    }
  }

  static bool isBigger375(double screenSize){
    if(screenSize > base_width-1){
      return true;
    }

    else{
      return false;
    }
  }


  static double getScaleFactor(double screenSize) {
    if (isBigger375(screenSize)) {
      return 1;
    }

    else {
      return (screenSize/base_width);
      //return 0.8;
    }
  }

  static double applyScaleFactor(double screenSize){
    return (screenSize/base_width);
  }

}