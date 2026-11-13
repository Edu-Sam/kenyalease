import 'package:flutter/material.dart';
import '../../widget/module.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../module.dart';

class LaunchInfo extends StatefulWidget{
  LaunchInfo({Key? key}) : super(key:key);

  @override
  _LaunchInfoState createState()=> _LaunchInfoState();
}

class _LaunchInfoState extends State<LaunchInfo>{
  
  List<Map<String,dynamic>> infos=[{'For tenants and \nbuyers':'Request support, pay bills and manage \nyour tenancy.Explore rentals,services\n'
      'and properties for sale in your area.'},
    {'For owners and\nlandlords':'List & manage your property listings,\nmanage your rentals and tenants.'},
    {'For property\ndevelopers':'List & manage enquiries for your\ndevelopment projects.'},
    {'For service\nproviders':'List your services & manage\nenquiries'},
    {'For the community':'Tune in and discuss.'}
  ];
  
  int info_value=0;
  List<Widget> info_containers=List.filled(5, const SizedBox());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: ColoredAppBar(
        app_title: Text(''),
        leading: const SizedBox(),
        height: 56,
        onExit: (){

        },
      ),
      body: infoContainer(),
    );
  }

  Widget infoContainer(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[AppConstants.primaryColorAccent,
            AppConstants.thirdColorAccent]
        )
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0,top: 30.0),
                    child: Text(infos.elementAt(info_value).keys.elementAt(0).toString(),textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white,
                          fontWeight: FontWeight.w700,fontSize: 32),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(infos.elementAt(info_value).values.elementAt(0),style: Theme.of(context).textTheme.bodyMedium
                    !.copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300,),),
                  )
                ],
              )
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: info_containers.asMap().map((index, element){
                  return MapEntry(index, Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index<=info_value ? Colors.white : Colors.transparent,
                        border: Border.all(color: index<=info_value ? Colors.transparent : Colors.white)
                      ),
                    ),
                  ));
                }).values.toList()
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: IconButton(
                  onPressed: (){
                    if(info_value!=4){
                      setState(() {
                        info_value++;
                      });
                    }

                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      LaunchOptionScreen(),settings: const RouteSettings(name: '/launchoption')));
                    }

                  },
                  icon: const Icon(CupertinoIcons.forward,color: Colors.white,
                    size: 60,),
                ),
              ),
            )

          ],
        )
        

      )
    );
  }
}