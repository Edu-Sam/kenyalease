import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/services/authRepository.dart';
import 'package:somalease/services/module.dart';
import 'package:somalease/view/module.dart';
import '../../constants/module.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget{
  VerificationScreen({Key? key,required this.email}) : super(key: key);
  String email;

  @override
  _VerificationState createState()=> _VerificationState();
}

class _VerificationState extends State<VerificationScreen>{

  bool _onEditing=false;
  String _code='';
  bool isLoading=false;
  AuthRepository authRepository = AuthRepository();

  String error_message='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(CupertinoIcons.back,color: AppConstants.thirdColorDark,),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 40.0,bottom: 20.0),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/somalease_icon.png')
                                    )

                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                              child: Text("Verification",textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,fontSize: 20
                                ),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        child: VerificationCode(
                          fullBorder: true,
                          fillColor: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16,color: AppConstants.primaryColor),
                          keyboardType: TextInputType.number,
                          underlineColor: Colors.amber, // If this is null it will use primaryColor: Colors.red from Theme
                          length: 4,
                          cursorColor: AppConstants.thirdColorDark,// If this is null it will default to the ambient
                          // clearAll is NOT required, you can delete it
                          // takes any widget, so you can implement your design
                          clearAll: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'clear all',
                              style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: AppConstants.thirdColorDark),
                            ),
                          ),
                          onCompleted: (String value) {
                            setState(() {
                              _code = value;
                            });
                          },
                          onEditing: (bool value) {
                            setState(() {
                              _onEditing = value;
                            });
                            if (!_onEditing) FocusScope.of(context).unfocus();
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                        child: Text("Please enter the verification code sent to\nyour email address",textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black54,fontSize: 16
                          ),),
                      ),

                      error_message.isNotEmpty ?
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(error_message,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.redAccent,fontSize: 12,fontWeight: FontWeight.w500
                        ),),
                      ): const SizedBox(),

                      Align(
                          alignment: Alignment.center,
                          child:  Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Container(
                              width: 130,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: ElevatedButton(
                                child: Text('Verify',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,fontWeight: FontWeight.w600
                                ),),
                                onPressed: () async{
                                  if(_code.isNotEmpty){
                                    setState(() {
                                      error_message='';
                                      isLoading=true;
                                    });

                                    var result = await verifyEmail();
                                    setState(() {
                                      isLoading=false;
                                    });

                                    if(result is Preferences){
                                      createUserProfile(result);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      => ProfileSetup(),settings: const RouteSettings(name: '/profile_setup')));
                                    }

                                  }

                                  else{
                                    setState(() {
                                      error_message="Field is required";
                                    });
                                  }

                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppConstants.thirdColorDark,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  /* side: BorderSide(color: AppConstants.thirdColor,

                            )*/
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
          ),

        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColorDark),
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }

  Future<dynamic> verifyEmail() async{
    var result = await authRepository.verifyEmail(_code, Provider.of<Preferences>(context,listen: false));
    return result;
  }

createUserProfile(Preferences preferences){
    Provider.of<Preferences>(context,listen: false).user_state=preferences.user_state;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
    Provider.of<Preferences>(context,listen: false).user=preferences.user;
    Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;
   // Provider.of<Preferences>(context,listen: false).user_type=preferences.user_type;
    Provider.of<Preferences>(context,listen: false).account_type=preferences.account_type;
    //Provider.of<Preferences>(context,listen: false).user_id=user.
  }


}