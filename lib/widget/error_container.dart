import 'package:flutter/material.dart';
import '../constants/module.dart';
import 'package:provider/provider.dart';
import '../models/module.dart';

class ErrorContainer{

  showErrorDialog(int error_code,BuildContext context,Function onRetry) async{

    return Future.delayed(Duration.zero,()=>
        showDialog(context: context,barrierDismissible: true, builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, updateState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius)
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 295 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,
                          listen: false).device_width)*/,
                      //  height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius),),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstants.horizontal_margin,
                            horizontal: AppConstants.horizontal_margin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(bottom: 23,top: 13.0),
                              child: Text(getErrorStatus(error_code),textAlign: TextAlign.center,style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight:  FontWeight.w700,fontSize: 14
                              ),),
                            ),
                            // Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: TextButton(
                                  onPressed: () async{
                                    onRetry();

                                  },
                                  child: Text('Ok',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900,
                                      color: Colors.white),),
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppConstants.primaryColorDark
                                    //   backgroundColor: Colors.redAccent.shade700
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            );
          });
        })
    );
  }

  showInfoErrorDialog(String error_code,BuildContext context,Function onRetry) async{

    return Future.delayed(Duration.zero,()=>
        showDialog(context: context,barrierDismissible: true, builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, updateState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius)
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 295,
                      //  height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius),),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstants.horizontal_margin,
                            horizontal: AppConstants.horizontal_margin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(bottom: 23,top: 13.0),
                              child: Text(error_code,textAlign: TextAlign.center,style: TextStyle(
                                  color: AppConstants.primaryColorDark,
                                  fontWeight:  FontWeight.w700,fontSize: 14
                              ),),
                            ),
                            // Spacer(),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: TextButton(
                                  onPressed: () async{
                                    onRetry();

                                  },
                                  child: Text('Ok',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900,
                                      color: Colors.white),),
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppConstants.primaryColorDark
                                    //   backgroundColor: Colors.redAccent.shade700
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            );
          });
        })
    );
  }

  int getDialogType(int dialogType){
    if(dialogType==null){
      return 0;
    }

    else{
      return dialogType;
    }
  }

  bool checkIsOk(int isOkButton){
    if(isOkButton==null){
      return false;
    }

    else{
      if(isOkButton==0){
        return false;
      }
      else{
        return true;
      }
    }
  }



  String getErrorStatus(int errorCode){
    if(errorCode==403){
      return 'Something went Wrong';

    }

    else if(errorCode==1){
      return 'Something went Wrong';

    }

    else if(errorCode==403){
      return 'Something went Wrong';

    }

    else if(errorCode==401){
      return 'Something went wrong';
      //  return something_went_wrong_401;
    }

    else if(errorCode==404){
      return 'Server not found';
      // return something_went_wrong_404;
    }

    else if(errorCode==503){
      return 'Something went wrong';
      // return something_went_wrong_503;
    }

    else if(errorCode==550){
      return 'Something went wrong';
      // return something_went_wrong_550;
    }

    else if(errorCode==500){
      return 'Something went wrong';
      // return 'Please connect to the internet';
      // return something_went_wrong_500;
    }

    else if(errorCode==552){
      return 'Email in use';
      // return something_went_wrong_552;
    }

    else if(errorCode==553){
      return 'Phone number in use';
      // return something_went_wrong_553;
    }

    else if(errorCode==554){
      return 'Phone number doesnt exist';
      // return something_went_wrong_554;
    }

    else if(errorCode==555){
      return 'Phone number and email in use';
      //  return something_went_wrong_555;
    }



    else{
      return 'Something went wrong';
      // return something_went_wrong_559;
    }
  }






}