import 'package:flutter/material.dart';
import '../constants/module.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationContainer{
  String password_updated_tag='',before_adding_tag='',ok_tag='OK',cancel_tag='Cancel',to_continue_tag='',
      account_deleted_tag='Account Deleted Successfully';


  showNotificationDialog(String notification_code,BuildContext context,Function onRetry,{bool isNewWidget=false,
    Widget? newWidget,String? message}) async{

    return Future.delayed(Duration.zero,()=>
        showDialog(barrierDismissible: false,context: context, builder: (BuildContext context) {
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
                    //  height: MediaQuery.of(context).size.height * 0.20,
                      width: 295,
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
                              padding: EdgeInsets.only(bottom: 23.0,top: 13.0),
                              child: Text(notification_code/*getNotificationStatus(notification_code)*/,style: TextStyle(
                                  color: AppConstants.primaryColorDark,fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w700,fontSize: 14
                              ),),
                            ),

                            isNewWidget ?
                            Padding(
                              padding: EdgeInsets.only(bottom: 23.0,top: 0.0),
                              child: Text(message!/*getNotificationStatus(notification_code)*/,style: TextStyle(
                                  color: AppConstants.primaryColorDark,fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w400,fontSize: 14
                              ),),
                            ): const SizedBox(),
                            //Spacer(),
                            isNewWidget ?
                            newWidget! :
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: TextButton(
                                  onPressed: () async{
                                    onRetry();


                                  },
                                  child: Text(ok_tag,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900,fontFamily: GoogleFonts.inter().fontFamily,
                                      color: Colors.white),),
                                  style: TextButton.styleFrom(
                                    //primary: Theme.of(context).primaryColor,
                                    //  backgroundColor: Theme.of(context).primaryColor
                                      backgroundColor: AppConstants.primaryColorDark
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

  String getNotificationStatus(int notificationCode){
    if(notificationCode==1){
      // return 'Password updated Successfully';
      return password_updated_tag;
    }

    else if(notificationCode==2){
      return  'To add a product to basket \n Please add your address.';
    }

    else if(notificationCode==3){
      /*return 'To add a product to basket \n Please add your address.';*/
      //  return 'Please enter your address before adding  an item to your basket.';
      return before_adding_tag;
    }

    else if(notificationCode==4){
      // return 'To continue, please add an address';
      return to_continue_tag;
    }

    else if(notificationCode==5){
      return account_deleted_tag;
    }



    /*else if(notificationCode==401){
      return 'Something went wrong';
    }

    else if(notificationCode==404){
      return 'Server not found';
    }

    else if(notificationCode==503){
      return 'Something went wrong';
    }

    else if(notificationCode==550){
      return 'Something went wrong';
    }

    else if(notificationCode==500){
      return 'Please connect to the internet';
    }*/

    else{
      return 'Update Successful';
    }
  }
}