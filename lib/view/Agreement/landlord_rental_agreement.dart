import 'package:flutter/material.dart';
import 'package:somalease/widget/module.dart';
import '../../models/module.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../../services/module.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';


class LandlordRentalAgreement extends StatefulWidget{
  LandlordRentalAgreement({Key? key,required this.agreement}) : super(key:key);
  Agreement? agreement;

  @override
  _LandlordRentalAgreementState createState()=> _LandlordRentalAgreementState();
}

class _LandlordRentalAgreementState extends State<LandlordRentalAgreement>{

  bool isLoading=false;
  PropertyRepository propertyRepository = PropertyRepository();
  Property? property;
  NotificationContainer notificationContainer = NotificationContainer();
  AgreementRepository agreementRepository = AgreementRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPropertyByID(widget.agreement!.property_id);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,color: Colors.black54,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text("Agreement #" + widget.agreement!.id.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
          ),),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,),
              onPressed: (){

              },
            )
          ],),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: isLoading ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorDark),
              ),
            ),
          ) :
          SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text("Rental Agreement " + widget.agreement!.start_date.toString() + " to " +
                                widget.agreement!.end_date.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(property!.propertyMaster!.property_master_name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700
                            ),),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade400,),

                    Padding(
                      padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
                      child: Text("Created " + widget.agreement!.created_at.substring(0,10) + " " +
                          widget.agreement!.created_at.substring(11,19),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade700
                        ),),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(widget.agreement!.agreement_description.toString(),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade700
                              ),),
                          ),

                          widget.agreement!.file_path.isNotEmpty ?  Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.width * 0.30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/pdf_icon.jpeg"),
                                      fit: BoxFit.contain

                                  )
                              ),
                            ),
                          ) : const SizedBox()
                        ],
                      ),
                    ),
                    widget.agreement!.accepted==1 ?
                    Padding(
                      padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,color: Colors.green,),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text("Accepted",style: Theme.of(context).textTheme.bodyMedium
                              !.copyWith(color: Colors.green),),
                          )
                        ],
                      ),
                    ) :

                    Padding(
                      padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_outlined,color: Colors.orangeAccent,),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text("Pending",style: Theme.of(context).textTheme.bodyMedium
                            !.copyWith(color: Colors.orangeAccent.shade700),),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              )
          ),
        ),

    );
  }

  Future<dynamic> getPropertyByID(int propertyId) async{
    setState(() {
      isLoading=true;
    });

    var result = await propertyRepository.getPropertyById(Provider.of<Preferences>(context,listen: false)
        .user!.remember_token, propertyId);

    if(result is Property){
      setState(() {
        property=result;
        isLoading=false;
      });

      return result;
    }

    else{
      setState(() {
        isLoading=false;
      });
      return result;
    }
  }

  Widget agreementRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120/* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,
              listen: false).device_width)*/,
          height: 50,
          child: TextButton(
            onPressed: () async{
              Navigator.pop(context);

            },
            child: Text('CANCEL',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900,/*fontFamily: GoogleFonts.inter().fontFamily*/
                color: AppConstants.thirdColor/*Theme.of(context).accentColor*/),),
            style: TextButton.styleFrom(
              //primary: Theme.of(context).primaryColor,
                backgroundColor: AppConstants.greyColor
            ),
          ),
        ),
        Container(
          width: 120 /** AppConstants.getScaleFactor(Provider.of<Preferences>(context,
            listen: false).device_width)*/,
          height: 50,
          child: TextButton(
            onPressed: () async{
              Navigator.pop(context);

              setState(() {
                isLoading=true;
              });

              var result = await acceptAndSign();
              setState(() {
                isLoading=false;
              });
              if(result is int){
                if(result == 200){
                  showTopSnackBar(context,const CustomSnackBar.success(message:
                  'Agreement signed and submitted successfully'));
                  Navigator.pop(context,1);


                }

                else{
                  showTopSnackBar(context,const CustomSnackBar.error(message:
                  'Error signing agreement.Please try again'));
                }
              }

              else{
                showTopSnackBar(context,const CustomSnackBar.error(message:
                'Error signing agreement.Please try again'));
              }
              /*await logout().then((value){
                setState(() {
                  message='';
                  isLoading=false;
                });
              });

              Navigator.pushNamedAndRemoveUntil(context,'/rootpage', (Route<dynamic> route) => false);*/
            },
            child: const Text('Proceed',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w900,/*fontFamily: GoogleFonts.inter().fontFamily*/
                color: Colors.white),),
            style: TextButton.styleFrom(
                backgroundColor: AppConstants.primaryColorAccent
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> acceptAndSign() async{
    var result = await agreementRepository.signAndAcceptAgreement(widget.agreement!.id,
        Provider.of<Preferences>(context,listen: false).user!.remember_token,
        Provider.of<Preferences>(context,listen: false).user!.firstname +
            Provider.of<Preferences>(context,listen: false).user!.lastname +
            widget.agreement!.id.toString() + Provider.of<Preferences>(context,listen: false).user
        !.user_id.toString()
    );

    return result;
  }
}