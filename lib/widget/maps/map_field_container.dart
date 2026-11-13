import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/module.dart';
import 'package:provider/provider.dart';
import '../../models/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/constants/app_constants.dart';

class MapFieldContainer extends StatefulWidget{
  MapFieldContainer({Key? key,this.validator,required this.controller,
    required this.hintText,required this.onChange,this.minlines,this.prefixIcon,this.onTap,
    this.field_height,this.content_padding_width,this.content_padding_height,this.isEditable,this.onClear}):super(key: key);
  FormFieldValidator? validator;
  TextEditingController controller=TextEditingController();
  String hintText;
  Function(String)? onChange;
  int? minlines=1;
  Icon? prefixIcon;
  Function? onTap;
  double? field_height;
  double? content_padding_height;
  double? content_padding_width;
  bool? isEditable;
  Function? onClear;

  @override
  MapFieldContainerState createState()=> MapFieldContainerState();
}

class MapFieldContainerState extends State<MapFieldContainer>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.transparent,
      // color: Colors.white,
      //  elevation: 0,
      width: MediaQuery.of(context).size.width * 0.90,
      height: widget.field_height==null ? 48 /* * AppConstants.getScaleFactor(
          Provider.of<Preferences>(context,listen: false).device_width!
      )*/: widget.field_height,
      //  height: 48,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        maxLines: null,
        minLines: widget.minlines,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        enabled: widget.isEditable==null ? true : widget.isEditable,

        keyboardType: TextInputType.multiline,
        onTap: (){
          widget.onTap!();
        },

        onChanged: (text){
          if(text!=null){
            widget.onChange!(widget.controller.text);
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: GestureDetector(
            onTap: (){
              if(widget.onClear!=null){
                widget.onClear!();
              }
            },
            child: Icon(CupertinoIcons.clear,color: AppConstants.thirdColor,),
          ),
          contentPadding: EdgeInsets.only(top: widget.content_padding_height==null ? 1.0:
          widget.content_padding_height!,left: widget.content_padding_width==null ? 10.0:
          widget.content_padding_width!),
          prefixIcon: widget.prefixIcon!=null ? widget.prefixIcon: Icon(Icons.description,color: Colors.white,),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 17 /* * AppConstants.getScaleFactor(
                Provider.of<Preferences>(context,listen: false).device_width!
            )*/,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusColor: Theme.of(context).primaryColor,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}