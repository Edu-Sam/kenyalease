import 'package:flutter/material.dart';
import '../constants/module.dart';
//import '../models/module.dart';
import 'package:provider/provider.dart';

class CustomBottomBarItem extends StatelessWidget{
  CustomBottomBarItem({Key? key,required this.icon_description,required this.icon,
    this.isActive,this.index,this.onTap,required this.activeNavigationColor,required this.navigationColor,
    required this.notification});
  Function? onTap;
  Widget icon;
  String icon_description;
  int? isActive=0;
  int? index;
  Color activeNavigationColor;
  Color navigationColor;
  int notification;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          onTap!();
        },
        child: Padding(
            padding: EdgeInsets.only(
                left: 5.0,right: 5.0
            ),
            child: Stack(
              children: [
                Container(
                  //   color: Colors.transparent,
                  //   color: isActive==1 ? activeNavigationColor : navigationColor,
                  color: isActive==1 ? activeNavigationColor : Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height:  65,/*(65 + MediaQuery.of(context).padding.bottom) * AppConstants.getScaleFactor(
                      Provider.of<Preferences>(context,listen: false).device_width
                  ),*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 0.0),
                        child: icon,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0,left: 10.0),
                        child: Text(icon_description,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade700,fontSize: 11,fontWeight: FontWeight.w400
                        ),),
                      )
                    ],
                  ),
                ),
                notification > 0 ?
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: isActive == 1 ? Colors.white : Colors.white,
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text(notification.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color:isActive==1 ? Colors.black : Colors.black,fontSize: 10,fontWeight: FontWeight.w600
                          ),),
                        ),
                      ),
                    )
                ) : SizedBox()
              ],
            )
        ),
      ),
    );
  }
}