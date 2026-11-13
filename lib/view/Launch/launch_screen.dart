import 'package:flutter/material.dart';
import '../../constants/module.dart';
import '../module.dart';
import 'package:flutter/cupertino.dart';

class LaunchScreen extends StatefulWidget{
  LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState()=> _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>{

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

            IconButton(
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  LaunchInfo(),settings: const RouteSettings(name: '/launchinfo')));
              },
              icon: Icon(CupertinoIcons.forward,color: AppConstants.thirdColorDark,
              size: 60,),
            )
          ],
        ),
      ),
    );
  }
}