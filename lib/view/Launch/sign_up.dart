import 'package:flutter/material.dart';
import 'package:somalease/services/authRepository.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget{
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState()=> _SignUpState();
}

class _SignUpState extends State<SignUp>{

  TextEditingController first_name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  bool isPasswordObscured=true;
  bool isConfirmPasswordObscured=true;
  bool is_privacy_policy=true;
  bool isLoading = false;
  Validation validation = Validation();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  String error_message='';

  AuthRepository authRepository = AuthRepository();

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
                              child: Text("Sign Up",textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,fontSize: 20
                                ),),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                                  child: Text("Name",textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.black54,fontSize: 16
                                    ),),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        border: Border.all(color: Colors.transparent)
                                    ),
                                    child: TextFormField(
                                      controller: first_name_controller,
                                      validator: (text){
                                        return validation.name1Validator(text!);
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          hintText: 'First',
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
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                                  child: Text("",textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Colors.black54,fontSize: 16
                                    ),),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.42,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        border: Border.all(color: Colors.transparent)
                                    ),
                                    child: TextFormField(
                                      controller: last_name_controller,
                                      validator: (text){
                                        return validation.name1Validator(text!);
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.grey.shade400
                                          ),
                                          hintText: 'Last',
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
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                        child: Text("Phone",textAlign: TextAlign.left,
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
                            controller: phone_controller,
                            validator: (text){
                              return validation.phoneValidator(text!);
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
                              return validation.pwdValidator(text!);
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

                      Padding(
                        padding: EdgeInsets.only(top: 0.0,bottom: 10.0,left: 10.0),
                        child: Text("Confirm Password",textAlign: TextAlign.left,
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
                            controller: confirm_password_controller,
                            obscureText: isConfirmPasswordObscured,

                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isConfirmPasswordObscured = !isConfirmPasswordObscured;
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

                      Padding(
                        padding: EdgeInsets.only(top: 20.0,left: 0.0,right: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: is_privacy_policy,
                              checkColor: Colors.white,
                              activeColor: AppConstants.thirdColor,
                              onChanged: (value){
                                setState(() {
                                  is_privacy_policy=value!;
                                });
                              },
                            ),


                            RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                  text: 'I agree to the privacy policy',
                                  style: TextStyle(color: Colors.black,fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[

                                  ]
                              ),
                            )

                          ],
                        ),
                      ),

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
                                child: Text('Sign Up',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,fontWeight: FontWeight.w600
                                ),),
                                onPressed: () async{
                                 if(form_key.currentState!.validate() && is_privacy_policy){

                                   setState(() {
                                     error_message='';
                                     isLoading=true;
                                   });

                                   var result = await signUp();
                                   setState(() {
                                     isLoading=false;
                                   });
                                   if(result is int && result == 200){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)
                                     => VerificationScreen(email: email_controller.text,),settings: const RouteSettings(name: '/verification')));
                                   }

                                 }

                                 else if(is_privacy_policy==false){
                                   setState(() {
                                     error_message='You must be 18 years and above to use this platform';
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
        )  : const SizedBox()
      ],
    );
  }

  Future<dynamic> signUp() async{
    User user= User.init();
    user.firstname= first_name_controller.text;
    user.lastname = last_name_controller.text;
    user.phone=phone_controller.text;
    user.email= email_controller.text;
    user.password = password_controller.text;

    var result = await authRepository.signUp(user);
    return result;
  }


}