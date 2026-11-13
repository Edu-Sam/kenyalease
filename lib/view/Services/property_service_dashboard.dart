import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/view/module.dart';
import '../../constants/module.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';

class PropertyServiceDashboard extends StatefulWidget{
  PropertyServiceDashboard({Key? key,required this.service_id,required this.service_type}): super(key:key);
  int service_id;
  String service_type;

  @override
  _PropertyServiceDashboardState createState()=> _PropertyServiceDashboardState();
}

class _PropertyServiceDashboardState extends State<PropertyServiceDashboard>{

  ServiceRepository serviceRepository = ServiceRepository();
  List<PropertyService> property_services=[];
  bool isLoading=false;
  String url = DomainServer.name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPropertyServicesByID(widget.service_id);
  }

  @override
  Widget build(BuildContext context) {
    print("The role id is " +  Provider.of<Preferences>(context,listen: false).user!.role_id.toString());
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Service Category',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,color: AppConstants.primaryColor,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(onPressed: (){

              }, icon: Icon(CupertinoIcons.heart_fill,color: Colors.grey.shade300,)),
              IconButton(
                onPressed: (){

                },
                icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
              )
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                     //   height: MediaQuery.of(context).size.height * 0.35,
                        // color: Colors.black,
                        child: GridView.builder(itemCount:  property_services.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 180,
                              ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                              maxCrossAxisExtent: 180/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10),
                          itemBuilder: (context,index){

                              return GestureDetector(
                                onTap: (){


                                  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PropertyServiceDetails(propertyService: property_services.elementAt(index),
                            service_type: widget.service_type,),
                            settings: const RouteSettings(name: '/propertyservicedetail')
                        ));
                                },
                                child: Container(
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   border: Border.all(color: Colors.grey.shade300),
                                   borderRadius: BorderRadius.circular(16.0)
                                 ),

                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.grey.shade300),
                                                top: BorderSide.none),
                                            /* image: DecorationImage(
                                            image: NetworkImage()
                                          ),*/
                                            /*borderRadius: BorderRadius.only(topRight: Radius.circular(16.0),
                                                topLeft: Radius.circular(16.0))*/
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                     /* Padding(
                                                        padding: EdgeInsets.only(right: 5.0),
                                                        child: InkWell(
                                                          onTap: (){

                                                          },
                                                          child: Icon(CupertinoIcons.location_solid,color: AppConstants.primaryColor,),

                                                        ),
                                                      ),*/

                                                      Provider.of<Preferences>(context,listen: false).user!.role_id!=34 ?
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 20.0),
                                                        child: InkWell(
                                                          onTap: (){

                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                               /* ChatScreen(
                                                                  currentUser:Provider.of<Preferences>(context,listen: false)
                                                                      .user!.user_id.toString(),
                                                                  recepientID: property_services.elementAt(index).somalease_service_id.toString(),
                                                                  message_title: property_services.elementAt(index).name,
                                                                  property_name: property_services.elementAt(index).name,
                                                                  sender_name: Provider.of<Preferences>(context,listen: false)
                                                                      .user!.firstname + ' ' + Provider.of<Preferences>(context,listen: false)
                                                                      .user!.lastname.toString(),
                                                                )*/

                                                            ChatScreen(
                                                              currentUser:Provider.of<Preferences>(context,listen: false)
                                                                  .user!.user_id.toString(),
                                                              recepientID: property_services.elementAt(index).service_provider_id.toString(),
                                                              message_title: property_services.elementAt(index).name,
                                                              property_name: property_services.elementAt(index).name,
                                                              sender_name: Provider.of<Preferences>(context,listen: false)
                                                                  .user!.firstname + ' ' + Provider.of<Preferences>(context,listen: false)
                                                                  .user!.lastname.toString(),
                                                            )


                                                            ));
                                                          },
                                                          child: Icon(CupertinoIcons.chat_bubble,color: AppConstants.primaryColorAccent,),

                                                        ),
                                                      ) : SizedBox(),

                                                      Provider.of<Preferences>(context,listen: false).user!.role_id!=34 ?
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 5.0),
                                                        child: InkWell(
                                                          onTap: (){

                                                          },
                                                          child: Icon(CupertinoIcons.phone_fill,color: AppConstants.primaryColorAccent,),

                                                        ),
                                                      ) : SizedBox()
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),

                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 80,
                                        child: Center(
                                          child: Icon(CupertinoIcons.briefcase,color: Colors.grey,size: 80,),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5.0,top: 5.0),
                                        child: Text(property_services.elementAt(index).name,style:
                                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: AppConstants.thirdColorDark,
                                          fontWeight: FontWeight.w600
                                        ),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5.0,top: 5.0),
                                        child: Text(property_services.elementAt(index).location_name,style:
                                        Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w400
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),
                              );


                          },
                        )
                    ),
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
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColorAccent),
            ),
          ),
        ) : SizedBox()
      ],
    );
  }

  Future<dynamic> getPropertyServicesByID(int service_id) async{
    setState(() {
      isLoading=true;
    });
    var result = await serviceRepository.getPropertyServiceByServiceID(
        Provider.of<Preferences>(context,listen: false).user!.remember_token,
        service_id);



    if(result is List<PropertyService>){
      setState(() {
        property_services=result;
        isLoading=false;
      });
    }

    else{
      setState(() {
        property_services=[];
        isLoading=false;
      });
    }

   return result;
  }
}