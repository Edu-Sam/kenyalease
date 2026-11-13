import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../constants/module.dart';

class ImageAppBar extends StatefulWidget implements PreferredSizeWidget{
  ImageAppBar({Key? key,required this.app_title,required this.height,required this.onExit,this.actions,this.leading,
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
  _ImageAppBarState createState()=>_ImageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ImageAppBarState extends State<ImageAppBar>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appBar=AppBar(
      //backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            color: Colors.transparent,
          ),
          Container(
            color: Colors.white.withOpacity(0.2),
          ),
          
        ],
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