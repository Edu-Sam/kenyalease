import 'package:flutter/material.dart';
import 'module.dart';
import '../constants/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
//import '../models/module.dart';
import 'module.dart';


class CustomBottomBar extends StatelessWidget{
  CustomBottomBar({Key? key,this.custom_bottom_bar_items,this.is_active,required this.navigationColor,
  required this.showTuneIn}):super(key:key);
  List<CustomBottomBarItem>?custom_bottom_bar_items;
  int?  is_active;
  bool showTuneIn;
  Color navigationColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,

          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 65/*(65 + MediaQuery.of(context).padding.bottom)   * AppConstants.getScaleFactor(
          Provider.of<Preferences>(context,listen: false).device_width
      )*/,

              decoration: BoxDecoration(
                color:AppConstants.navigationBackgroundColor,
                 // color: Colors.grey
                //color: navigationColor,
                /* gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[AppConstants.navigationBarColor,AppConstants.navigationAccentColor,AppConstants.navigationAccentColor]
        ),*/
                // border: Border(top: BorderSide(color: Colors.grey.shade100)),

              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: custom_bottom_bar_items!.asMap().map((i,element) =>
                      MapEntry(i,CustomBottomBarItem(
                        icon_description: element.icon_description,
                        icon: element.icon,
                        isActive: element.isActive,
                        onTap: element.onTap,
                        index: element.index,
                        activeNavigationColor: element.activeNavigationColor,
                        navigationColor: element.navigationColor,
                        notification: element.notification,

                      ))).values.toList()
              ),
            ),

            showTuneIn ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child:  Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.thirdColorAccent])
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.speaker_2_fill,color: Colors.white,
                      ),
                      Text("Tune in",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white
                      ),)
                    ],
                  ),
                ),
              ),
            ):
            SizedBox()
          ],
        )
      ],
    );
  }
}

/**
 *  Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
    padding: EdgeInsets.only(bottom: 30.0),
    child: Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppConstants.primaryColor,AppConstants.thirdColorAccent])
    )
    ),
    ),
    )
 *
 * **/