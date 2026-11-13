import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../constants/module.dart';

class ColoredAppBar extends StatefulWidget implements PreferredSizeWidget{
  ColoredAppBar({Key? key,required this.app_title,required this.height,required this.onExit,this.actions,this.leading,
    this.centerTitle,this.leading_width}): super(key: key);
  //String title;
  Widget app_title;
  double height;
  Function onExit;
  Widget? leading;
  List<Widget>? actions;
  bool? centerTitle;
  double? leading_width;


  @override
  ColoredAppBarState createState()=>ColoredAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ColoredAppBarState extends State<ColoredAppBar>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appBar=AppBar(
      //backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[AppConstants.primaryColorAccent,AppConstants.thirdColorAccent]
            )
        ),
      ),
      leadingWidth: widget.leading_width ?? 56,
      title: widget.app_title,
      automaticallyImplyLeading: false,
      centerTitle: widget.centerTitle ?? true,
      leading: widget.leading ?? IconButton(
        icon: Icon(CupertinoIcons.back,color: Theme.of(context).accentColor,size: 24 * AppConstants.getScaleFactor(getDeviceWidth()),),
        onPressed: (){
          // setState(() {
          widget.onExit();
          // });
        },
      ),
      actions: widget.actions,
    );
    return appBar;
  }

  double getDeviceWidth(){
    return MediaQuery.of(context).size.width;
  }




}