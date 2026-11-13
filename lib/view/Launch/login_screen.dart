import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/services/authRepository.dart';
import 'package:somalease/view/module.dart';
import 'package:somalease/widget/error_container.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
   LoginScreen({Key? key}) : super(key: key);

   @override
  _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool isPasswordObscured=true;
  bool isLoading=false;
  AuthRepository authRepository = AuthRepository();
  Validation validation = Validation();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  ErrorContainer errorContainer = ErrorContainer();


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
                  child: Form(
                    key: form_key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Text("Login",textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.black54,fontSize: 20
                                  ),),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                          child: Text("Email",textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black54,fontSize: 16
                            ),),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.transparent)
                            ),
                            child: TextFormField(
                              controller: email_controller,
                              validator: (text){
                                return validation.emailValidator(text!);
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade100
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                          child: Text("Password",textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.black54,fontSize: 16
                            ),),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.transparent)
                            ),
                            child: TextFormField(
                              controller: password_controller,
                              validator: (text){
                                return validation.name1Validator(text!);
                              },
                              obscureText: isPasswordObscured,

                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isPasswordObscured = !isPasswordObscured;
                                        });
                                      },
                                      child: Icon(Icons.visibility_rounded,color: AppConstants.thirdColor,)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade100
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              onTap: (){

                              },

                              child: Text("Forgot Password",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.black87
                              ),),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Container(
                              width: 130,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: ElevatedButton(
                                child: Text('Login',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,fontWeight: FontWeight.w600
                                ),),
                                onPressed: () async{
                                  if(form_key.currentState!.validate()){
                                    setState(() {
                                      isLoading=true;
                                    });

                                    var result = await signIn(email_controller.text, password_controller.text);
                                    setState(() {
                                      isLoading=false;
                                    });

                                    if(result is Preferences){
                                      print("It is preferences");
                                      print("User ID is " + Provider.of<Preferences>(context,listen: false).user!.user_id.toString());
                                      print("Status is " + Provider.of<Preferences>(context,listen: false).user!.status.toString());
                                      print("Role id is " + Provider.of<Preferences>(context,listen: false).user!.role_id.toString());
                                      createUserProfile(Provider.of<Preferences>(context,listen: false));


                                      if(Provider.of<Preferences>(context,listen: false).user!.status==0){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            VerificationScreen(email: result.user!.email)
                                        ));
                                      }
                                      
                                      else if(Provider.of<Preferences>(context,listen: false).user!.status==1){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            ProfileSetup()
                                        ));
                                      }

                                      else if(Provider.of<Preferences>(context,listen: false).user!.status==2){

                                        createUserProfile(result);
                                        Navigator.pushNamedAndRemoveUntil(context,'/dashboard', (Route<dynamic> route) => false);
                                        /*if(Provider.of<Preferences>(context,listen: false).user!.role_id==14){
                                          Navigator.pushNamedAndRemoveUntil(context,'/tenantdashboard', (Route<dynamic> route) => false);
                                        }

                                        else if(Provider.of<Preferences>(context,listen: false).user!.role_id==24){
                                          Navigator.pushNamedAndRemoveUntil(context,'/ownerdashboard', (Route<dynamic> route) => false);
                                        }

                                        else if(Provider.of<Preferences>(context,listen: false).user!.role_id==34){
                                          Navigator.pushNamedAndRemoveUntil(context,'/providerdashboard', (Route<dynamic> route) => false);
                                        }

                                        else if(Provider.of<Preferences>(context,listen: false).user!.role_id==44){
                                          Navigator.pushNamedAndRemoveUntil(context,'/launch', (Route<dynamic> route) => false);
                                        }*/
                                      }


                                    }

                                    else{
                                         errorContainer.showInfoErrorDialog("Incorrect Username or password",
                                             context, (){
                                           Navigator.pop(context);
                                             });
                                    }
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
                          ),
                        )

                      ],
                    ),
                  )
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
        )   :
        const SizedBox()
      ],
    );
  }

  Future<dynamic> signIn(String email,String password) async{
    var result = await authRepository.login(email, password, Provider.of<Preferences>(context,listen: false));
    return result;
  }


  createUserProfile(Preferences preferences){
    Provider.of<Preferences>(context,listen: false).user_state=preferences.user_state;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
    Provider.of<Preferences>(context,listen: false).user=preferences.user;
    Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;
    // Provider.of<Preferences>(context,listen: false).user_type=preferences.user_type;
    Provider.of<Preferences>(context,listen: false).account_type=preferences.account_type;
    Provider.of<Preferences>(context,listen: false).account_role_types=preferences.account_role_types;
   Provider.of<Preferences>(context,listen: false).account_role_types.forEach((element) {
     print("AFTER fetching: " + element.firstname.toString());
   });
  }
}