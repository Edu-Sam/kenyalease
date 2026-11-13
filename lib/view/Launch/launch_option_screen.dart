import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/view/Launch/login_screen.dart';
import '../../constants/module.dart';
import '../module.dart';

class LaunchOptionScreen extends StatefulWidget{
  LaunchOptionScreen({Key? key}): super(key: key);

  @override
  _LaunchOptionScreenState createState()=> _LaunchOptionScreenState();
}

class _LaunchOptionScreenState extends State<LaunchOptionScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.only(top: 80.0,bottom: 20.0),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/somalease_icon.png')
                      )

                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text("Welcome to Somalease\n Super App",textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,fontSize: 18
                  ),),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20.0,top: 40.0),
                child: Text("List.Rent.Manage.Tune in.",style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppConstants.thirdColorDark,fontWeight: FontWeight.w600
                ),),
              ),

              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(16.0)
                      ),
                      child: OutlinedButton(
                        child: Text('Login',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black54,fontWeight: FontWeight.w600
                        ),),
                        onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)
                         => LoginScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            side: BorderSide(color: AppConstants.thirdColor,
                            
                            )
                        ),
                      ),
                    ),
                    Container(
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
                        onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)
                           => SignUp(),settings: const RouteSettings(name: '/signup')));
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: AppConstants.thirdColorDark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                           /* side: BorderSide(color: AppConstants.thirdColor,

                            )*/
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}