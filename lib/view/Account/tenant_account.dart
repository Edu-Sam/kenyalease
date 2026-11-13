import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:somalease/view/Services/property_service_dashboard.dart';
import '../../constants/module.dart';
import '../../widget/module.dart';
import '../module.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TenantAccount extends StatefulWidget{
  TenantAccount({Key? key,required this.bottom_bar_index}) : super(key: key);
  int bottom_bar_index;

  @override
  _TenantAccountState createState()=> _TenantAccountState();
}

class _TenantAccountState extends State<TenantAccount>{

  int tab_index=0;
  int property_index=0;
  int service_index=0;
  int bottom_bar_index=0;
  PageController? _pageController,_propertyController,_serviceController;
  ServiceRepository serviceRepository = ServiceRepository();
  PropertyRepository propertyRepository =PropertyRepository();
  LandLordRepository landLordRepository = LandLordRepository();
  bool isLoading=false;
  List<SomaleaseService> somalease_services=[];
  List<Property> rent_properties =[],temp_rent_properties=[];
  List<Property> buy_properties = [],temp_buy_properties=[];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  ErrorContainer errorContainer = ErrorContainer();
  NotificationContainer notificationContainer = NotificationContainer();
  String url= DomainServer.name;

  int? properties_value=0;
  List<String> properties=["ABC Apartments"];
  PageController? _agreementController;
  int agreement_index=0;
  List<PropertyMaster> property_master =[];
  TextEditingController search_controller = TextEditingController(text: '');
  bool isChecked=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserProfile();
    setControllers();
  }

  @override
  Widget build(BuildContext context) {
    checkIsHome();
    // TODO: implement build
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: widget.bottom_bar_index==0 ? SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0),
                    child:  Container(
                        width: MediaQuery.of(context).size.width,
                        height:  52 /* * AppConstants.getScaleFactor(
                        Provider.of<Preferences>(context,listen: false).device_width!
                    )*/,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _pageController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      gradient: tab_index==0 ? LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                      ):

                                      LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[Colors.white,Colors.white])
                                      ,
                                      borderRadius: tab_index==0 ? BorderRadius.circular(16.0) : BorderRadius.horizontal(right: Radius.zero,
                                          left: Radius.zero)
                                    // color: Colors.white,
                                    /*border: Border(bottom: tab_index==0 ? BorderSide(color: AppConstants.thirdColor,
                                    width: 3.0):
                                const BorderSide(color: Colors.white)
                                )*/
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                        child: Text("Property Search"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                          style: TextStyle(color: tab_index==0 ? Colors.white : Colors.grey,
                                            fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  /*setState(() {
                                    _pageController!.animateToPage(1, duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  });*/

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.40 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  height: MediaQuery.of(context).size.height * 0.05 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  decoration:  BoxDecoration(
                                      gradient: tab_index==1 ? LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                                        // <Color>[AppConstants.primaryColorAccent,AppConstants.thirdColorAccent]
                                      ):

                                      const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[Colors.white,Colors.white])
                                      ,
                                      borderRadius: tab_index==1 ? BorderRadius.circular(16.0) : const BorderRadius.horizontal(right: Radius.zero,
                                          left: Radius.zero)
                                    // color: Colors.white,
                                    /*border: Border(bottom: tab_index==0 ? BorderSide(color: AppConstants.thirdColor,
                                    width: 3.0):
                                const BorderSide(color: Colors.white)
                                )*/
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                        child: Text("Services"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                          style: TextStyle(color: tab_index==1 ? Colors.white : Colors.grey,
                                            fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                          ,),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                  detailPages()
                ],
              ),
            ) :
            widget.bottom_bar_index==2 ? PaymentTenant() :
            widget.bottom_bar_index==3  ?
            TenantAgreementDashboard(): const SizedBox()
        ),
        isLoading ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorAccent),
            ),
          ),
        )  : const SizedBox()
      ],
    );
  }

  Widget detailPages(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //  color: Colors.black,
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      //  height: MediaQuery.of(context).size.height * 0.70,
      child: ExpandablePageView(
        //pageSnapping: true,
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context,index){
          return Column(
            children: [
              propertySearch(),
              // serviceSearch()
            ],
          );
        },
        onPageChanged: (num){
          setControllers();
          setState(() {
            print("Changed to " + num.toString());
            tab_index=num;
          });

        },
        /* children: <Widget>[
          propertySearch(),
          serviceSearch()

        ],*/
      ),
    );
  }

  Widget propertySearch(){

    return  Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height:  52 /* * AppConstants.getScaleFactor(
                        Provider.of<Preferences>(context,listen: false).device_width!
                    )*/,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _propertyController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: property_index==0 ? BorderSide(color: AppConstants.thirdColor,
                              width: 3.0):
                          const BorderSide(color: Colors.white)
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                            child: Text("Rent"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                              style: TextStyle(color: property_index==0 ? AppConstants.thirdColor : Colors.black54,
                                fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _propertyController!.animateToPage(1, duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      });
                      /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                      height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:  property_index==1 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                              width: 3.0
                          )
                          ): Border(bottom: BorderSide(color: Colors.white))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                            child: Text("Buy"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                              style: TextStyle(color: property_index==1 ? AppConstants.thirdColor : Colors.black54,
                                fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                              ,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _propertyController!.animateToPage(2, duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      });
                      /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                      height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:  property_index==2 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                              width: 3.0
                          )
                          ): Border(bottom: BorderSide(color: Colors.white))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                            child: Text("Commercial"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                              style: TextStyle(color: property_index==2 ? AppConstants.thirdColor : Colors.black54,
                                fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                              ,),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
        propertyDetails()
      ],
    );
    /* return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height:  52 /* * AppConstants.getScaleFactor(
                        Provider.of<Preferences>(context,listen: false).device_width!
                    )*/,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _propertyController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: property_index==0 ? BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0):
                              const BorderSide(color: Colors.white)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Rent"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: property_index==0 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _propertyController!.animateToPage(1, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                          /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:  property_index==1 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0
                              )
                              ): Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Buy"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: property_index==1 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                  ,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _propertyController!.animateToPage(2, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                          /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:  property_index==2 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0
                              )
                              ): Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Commercial"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: property_index==2 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                  ,),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            propertyDetails()
          ],
        ),
      ),
    );*/
  }


  Widget serviceSearch(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [

            /* Container(
                width: MediaQuery.of(context).size.width,
                height:  52 /* * AppConstants.getScaleFactor(
                        Provider.of<Preferences>(context,listen: false).device_width!
                    )*/,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _serviceController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: service_index==0 ? BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0):
                              const BorderSide(color: Colors.white)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Rent"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: service_index==0 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _serviceController!.animateToPage(1, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                          /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:  service_index==1 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0
                              )
                              ): Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Buy"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: service_index==1 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                  ,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*  GestureDetector(
                        onTap: (){
                          setState(() {
                            _serviceController!.animateToPage(2, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                          /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          height: MediaQuery.of(context).size.height * 0.06 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:  property_index==2 ? Border(bottom:  BorderSide(color: AppConstants.thirdColor,
                                  width: 3.0
                              )
                              ): Border(bottom: BorderSide(color: Colors.white))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Commercial"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: property_index==2 ? AppConstants.thirdColor : Colors.black54,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                  ,),
                              ),
                            ],
                          ),
                        ),
                      )*/
                    ],
                  ),
                )
            ),*/
            //  serviceDetails()
            servicesUIDetail()
            //   Container()
          ],
        ),
      ),
    );
  }


  Widget propertyDetails(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      height: MediaQuery.of(context).size.height * 1.6,
      child: ExpandablePageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        controller: _propertyController,
        itemBuilder: (context,index){
          return Column(
            children: [
              rentDetailsContainer(),
              buyDetailsContainer(),
              Container()
            ],
          );
        },
        onPageChanged: (num){
          setState(() {
            property_index=num;
          });
        },
        /*children: <Widget>[
          rentDetailsContainer(),
          buyDetailsContainer(),
          Container()

        ],*/
      ),
    );
  }

  Widget rentDetailsContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    SearchProperty(),settings: RouteSettings(name: '/searchproperty'))).then((value){
                  setState(() {
                    // initUserProfile();
                  });
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: TextFormField(
                  controller: search_controller,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: AppConstants.textBackgroundColor,
                    filled: true,
                    suffixIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[Colors.deepPurple,AppConstants.thirdColorAccent]
                          ),
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))
                      ),
                      child: Center(
                        child: Icon(Icons.search,color: Colors.white,),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
            )
        ),
        servicesUI(),
        rentUI()
      ],
    );
  }


  Widget buyDetailsContainer(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // servicesUI(),
        buyUI()
      ],
    );

  }


  Widget serviceDetails(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      height: MediaQuery.of(context).size.height * 0.70,
      child: PageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: _serviceController,
        onPageChanged: (num){
          setState(() {
            service_index=num;
          });
        },
        children: <Widget>[
          Container(),
          Container(),

          // buyPlans(),
          // purchaseHistory()
          // infoContainer(details),
          // basketContainer(details),
        ],
      ),
    );
  }


  Future<dynamic> getServices(String token) async {
    /* setState(() {
      isLoading=true;
    });*/
    var result = await serviceRepository.getServices(token);

    if(result is List<SomaleaseService>){
      setState(() {
        somalease_services=result;
        //  isLoading=false;
      });

      return result;
    }

    else{
      return Container();
    }

  }

  Widget servicesUIDetail(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 20.0,right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Explore Services1",style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor,fontWeight: FontWeight.w700
            ),),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.35,
              // color: Colors.black,
              child: GridView.builder(itemCount:  somalease_services.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 120,
                    ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                    maxCrossAxisExtent: 110/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemBuilder: (context,index){

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PropertyServiceDashboard(service_id:
                          somalease_services.elementAt(index).id,service_type: somalease_services.elementAt(index)
                              .somalease_service_name,),
                          settings: const RouteSettings(name: '/propertyservicedashboard')
                      ));
                    },
                    child: ServiceContainer(specialization: somalease_services.elementAt(index).somalease_service_name,
                      field_icon: somalease_services.elementAt(index).image,),
                  );


                  /*else{
                    return const SizedBox();
                  }*/


                  /*else if(index ==4){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CategoryCatalogue(categories: user_categories),
                            settings: const RouteSettings(name: '/categorycatalogue')
                        ));
                      },
                      child: SpecialistWidget(specialization: '',field_icon: '',),
                    );
                  }*/


                },
              )
          ),
        ],
      ),
    );
  }

  Widget servicesUI(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 20.0,right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Explore Services",style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor,fontWeight: FontWeight.w700
            ),),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              // color: Colors.black,
              child: GridView.builder(itemCount:  somalease_services.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 120,
                    ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                    maxCrossAxisExtent: 110/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemBuilder: (context,index){
                  if(index < 6){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PropertyServiceDashboard(service_id:
                            somalease_services.elementAt(index).id,service_type: somalease_services.elementAt(index)
                                .somalease_service_name,),
                            settings: const RouteSettings(name: '/propertyservicedashboard')
                        ));
                      },
                      child: ServiceContainer(specialization: somalease_services.elementAt(index).somalease_service_name,
                        field_icon: somalease_services.elementAt(index).image,),
                    );
                  }

                  else{
                    return const SizedBox();
                  }


                  /*else if(index ==4){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CategoryCatalogue(categories: user_categories),
                            settings: const RouteSettings(name: '/categorycatalogue')
                        ));
                      },
                      child: SpecialistWidget(specialization: '',field_icon: '',),
                    );
                  }*/


                },
              )
          ),
        ],
      ),
    );
  }


  Widget rentUI(){
    if(rent_properties.isNotEmpty){
      return Padding(
        padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 0.0,right: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.only(bottom: 10.0,left: 20.0,right: 20.0),
              child: Text("Rentals near you",style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppConstants.primaryColor,fontWeight: FontWeight.w700
              ),),
            ),

            rentPropertiesContainer(),


            Padding(
              padding: EdgeInsets.only(bottom: 10.0,left: 20.0,right: 20.0),
              child: Text("Apartments for Sale",style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppConstants.primaryColor,fontWeight: FontWeight.w700
              ),),
            ),

            buyPropertiesContainer()

          ],
        ),
      ); }

    else{
      return SizedBox();
    }
  }

  Widget buyUI(){
    if(buy_properties.isNotEmpty){
      return Padding(
        padding: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 0.0,right: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            Padding(
              padding: EdgeInsets.only(bottom: 10.0,left: 20.0,right: 20.0),
              child: Text("Apartments for Sale",style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppConstants.primaryColor,fontWeight: FontWeight.w700
              ),),
            ),

            buyPropertiesContainer()

          ],
        ),
      );}

    else{
      return const SizedBox();
    }
  }

  Widget rentPropertiesContainer(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.50,
        //color: Colors.black,
        child:Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: rent_properties.asMap().map((index, element){
                  return MapEntry(index,Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              PropertyDetailContainer(property: element)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      //  color: Colors.black,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                child: Text(element.property_name/*element.bhk_type + 'for ' + 'rent in' + element.property_location.elementAt(0).city*/,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black54
                                                  ),),
                                              ),

                                              /*Padding(
                                            padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                            child: Text(element.property_name,
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: Colors.black54
                                              ),),
                                          ),*/
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Icon(CupertinoIcons.location_solid,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    _launchWhatsapp('+254702181403');
                                                  },
                                                  child: Icon(CupertinoIcons.heart,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 0.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    makeCall('+254702181403');
                                                  },
                                                  child: Icon(CupertinoIcons.phone,color: AppConstants.primaryColor,),

                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  color: Colors.black,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.50,
                                        height: MediaQuery.of(context).size.height * 0.20,

                                        decoration: BoxDecoration(
                                          //   color: Colors.black,
                                          //  borderRadius: BorderRadius.circular(24.0),
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/property_demo.png'),
                                                fit: BoxFit.cover
                                            )
                                        ),

                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: rent_properties.asMap().entries.map((entry) {
                                                return GestureDetector(
                                                  onTap: () => _controller.animateToPage(entry.key),
                                                  child: Container(
                                                    width: 12.0,
                                                    height: 12.0,
                                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:_current==entry.key ?
                                                        AppConstants.primaryColorAccent:
                                                        Colors.grey.shade100

                                                      /* color: (Theme.of(context).brightness == Brightness.dark
                                                                    ? Colors.white
                                                                    : AppConstants.primaryColorDark)
                                                                    .withOpacity(_current == entry.key ? 1 : 0.4)*/),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('KES ' + element.property_price,style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('Fully furnished',style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:  Offset(1.0,1.0),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 1.0,
                                                        color: Colors.black12

                                                    )
                                                  ],),
                                                child: Center(
                                                  child: Text('1200 Sq Built up\nArea',style: Theme.of(context).textTheme
                                                      .bodySmall!.copyWith(color: Colors.black54),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              /* Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                              offset:  Offset(1.0,1.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                              color: Colors.black12

                                          )
                                        ],),
                                      child: Center(
                                        child: Text('Fully furnished',style: Theme.of(context).textTheme
                                            .bodySmall!.copyWith(color: Colors.black54),),
                                      ),
                                    )*/
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                  ));
                }).values.toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    aspectRatio: 1.2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),

            /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rent_properties.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),*/
          ],
        )
    );


  }

  Widget buyPropertiesContainer(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.50,
        //color: Colors.black,
        child:Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: rent_properties.asMap().map((index, element){
                  return MapEntry(index,Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              PropertyDetailContainer(property: element)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                child: Text(element.property_name/*element.bhk_type + 'for ' + 'rent in' + element.property_location.elementAt(0).city*/,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black54
                                                  ),),
                                              ),

                                              /*Padding(
                                              padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                              child: Text(element.property_name,
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: Colors.black54
                                                ),),
                                            ),*/
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Icon(CupertinoIcons.location_solid,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Icon(CupertinoIcons.heart,color: AppConstants.primaryColor,),

                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 0.0),
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Icon(CupertinoIcons.phone,color: AppConstants.primaryColor,),

                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.20,

                                  decoration: BoxDecoration(
                                    //   color: Colors.black,
                                    //  borderRadius: BorderRadius.circular(24.0),
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/property_demo.png'),
                                          fit: BoxFit.cover
                                      )
                                  ),

                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: rent_properties.asMap().entries.map((entry) {
                                          return GestureDetector(
                                            onTap: () => _controller.animateToPage(entry.key),
                                            child: Container(
                                              width: 12.0,
                                              height: 12.0,
                                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:_current==entry.key ?
                                                  AppConstants.primaryColorAccent:
                                                  Colors.grey.shade100

                                                /* color: (Theme.of(context).brightness == Brightness.dark
                                                                    ? Colors.white
                                                                    : AppConstants.primaryColorDark)
                                                                    .withOpacity(_current == entry.key ? 1 : 0.4)*/),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('KES ' + element.property_price,style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:  Offset(1.0,1.0),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                      color: Colors.black12

                                                  )
                                                ],),
                                              child: Center(
                                                child: Text('Fully furnished',style: Theme.of(context).textTheme
                                                    .bodySmall!.copyWith(color: Colors.black54),),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:  Offset(1.0,1.0),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 1.0,
                                                        color: Colors.black12

                                                    )
                                                  ],),
                                                child: Center(
                                                  child: Text('1200 Sq Built up\nArea',style: Theme.of(context).textTheme
                                                      .bodySmall!.copyWith(color: Colors.black54),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              /* Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                              offset:  Offset(1.0,1.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                              color: Colors.black12

                                          )
                                        ],),
                                      child: Center(
                                        child: Text('Fully furnished',style: Theme.of(context).textTheme
                                            .bodySmall!.copyWith(color: Colors.black54),),
                                      ),
                                    )*/
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                  ));
                }).values.toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    aspectRatio: 1.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),

            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rent_properties.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),*/
          ],
        )
    );


  }

  Future<dynamic> getProperties() async{
    /*setState(() {
      isLoading=true;
    });*/
    var result = await propertyRepository.getProperties(Provider.of<Preferences>(context,listen: false).user!.remember_token);

    if(result is List<Property>){
      setState(() {
        temp_rent_properties = result;
        print("temp rent properties is " + temp_rent_properties.length.toString());
        //   isLoading=false;
      });

      return result;
    }

    else{
      /* setState(() {
        isLoading=false;
      });*/
      return errorContainer.showInfoErrorDialog('Could not fetch properties', context, (){
        Navigator.pop(context);
      });
    }

  }

  Widget agreementContainer(){
    return  SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 48,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100
                  ),
                  child: Center(
                    child: Text('Apartment/House#',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black54
                    ),),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 48,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColorDark]
                      )
                  ),
                  child: Center(
                    child: Container(
                      // color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16.0),
                          /*boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0.0,1.0),
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0,
                                        color: AppConstants.thirdColor.withOpacity(0.2)
                                      //  color: Colors.black12
                                    )]*/),
                        child: FormField(
                            builder: (FormFieldState state){
                              return InputDecorator(
                                  baseStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppConstants.primaryColorAccent
                                  ),
                                  decoration:  InputDecoration(

                                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                    //     labelStyle: textStyle,
                                    errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.zero
                                    ),
                                    // labelText:'Select Bank',
                                  ),
                                  child:DropdownButtonHideUnderline(
                                      child:DropdownButton(
                                        value: properties_value,
                                        isDense: true,
                                        hint:  Text("Select",style: TextStyle(color: AppConstants.primaryColorAccent,fontSize: 14,
                                          //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                        ),),

                                        onChanged: (int? newValue){
                                          properties_value=newValue;
                                          state.didChange(newValue);


                                        },
                                        //  icon: null,
                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                        items:property_master.map((value){
                                          return DropdownMenuItem(

                                            value: property_master.indexOf(value),
                                            child:Text(value.property_master_name,style: TextStyle(color: Colors.black54,
                                              fontSize: 12,fontWeight: FontWeight.w400,
                                              //      fontFamily: GoogleFonts.openSans().fontFamily
                                            ),),
                                          );
                                        }).toList(),
                                      )
                                  )
                              );

                            }
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0),
            child:  Container(
                width: MediaQuery.of(context).size.width,
                height:  52 /* * AppConstants.getScaleFactor(
                        Provider.of<Preferences>(context,listen: false).device_width!
                    )*/,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _agreementController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              // color: Colors.white,
                              border: Border(bottom: agreement_index==0 ? BorderSide(color: Colors.grey.shade500,
                                  width: 3.0):
                              const BorderSide(color: Colors.white)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("UnSigned"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: agreement_index==0 ? AppConstants.primaryColorAccent : Colors.grey,
                                    fontSize: 14,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _agreementController!.animateToPage(1, duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                          /*setState(() {
                                tab_index=1;
                                print('index is ' + tab_index.toString());
                              });*/
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          height: MediaQuery.of(context).size.height * 0.05 /* * AppConstants.getScaleFactor(
                                Provider.of<Preferences>(context,listen: false).device_width!)*/,
                          decoration:  BoxDecoration(
                              color: Colors.transparent,

                              // color: Colors.white,
                              border: Border(bottom: agreement_index==1 ? const BorderSide(color: Colors.grey,
                                  width: 3.0):
                              const BorderSide(color: Colors.white)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Signed"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                  style: TextStyle(color: agreement_index==1 ? AppConstants.primaryColorAccent : Colors.grey,
                                    fontSize: 12,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

                                  ,),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
          agreementPages()
        ],
      ),
    );
  }

  Widget agreementPages(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      height: MediaQuery.of(context).size.height * 0.70,
      child: PageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: _agreementController,
        onPageChanged: (num){
          setState(() {
            agreement_index=num;
          });
        },
        children: <Widget>[
          Container(),
          Container()
        ],
      ),
    );
  }

  Future<void> initUserProfile() async{
    setState(() {
      isLoading=true;
    });

    /* _pageController=PageController(initialPage: tab_index);
    _propertyController=PageController(initialPage: property_index);
    _serviceController = PageController(initialPage: service_index);
    _agreementController=PageController(initialPage: agreement_index);*/
    //var result1= await getLandlordProperties().then((value) async{
    var result2= await getProperties().then((value1){
      if(temp_rent_properties.isNotEmpty){

        temp_rent_properties.forEach((new_property) {
          bool isApproved= new_property.propertyMaster!.status=='approved';
          /*print("The property master id is " + new_property.property_master_id.toString());
            bool isPropertyMaster= property_master.any((element) => element.id==new_property.property_master_id &&
                element.status=='approved');*/
          if(isApproved){
            rent_properties.add(new_property);
          }

        });

      }
      return value1;
    });
    var result3= await getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);
    //  return value;
    //});


    setState(() {
      isLoading=false;
    });


  }

  /*Future<dynamic> getLandlordProperties() async{
    var result=await landLordRepository.getLandlordPropertyMasters(Provider.of<Preferences>(context,listen: false
    ).user!.user_id, Provider.of<Preferences>(context,listen: false).user!.remember_token);
    if(result is List<PropertyMaster>){
      setState(() {
        property_master=result;
      });
    }

    else{
      setState(() {
        property_master=[];
      });
    }
    return result;
  }*/

  _launchWhatsapp(String phone_number) async {

    var url ='whatsapp://send?text=${phone_number}';
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalNonBrowserApplication,);
    // var url = 'https://wa.me/?text=${plan.plan_title} \n ${new_plan_details}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  makeCall(String phone_number) async{
    final call = Uri.parse('tel:' + phone_number);
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

  setControllers(){
    setState(() {
      _pageController=PageController(initialPage: tab_index);
      _propertyController=PageController(initialPage: property_index);
      _serviceController = PageController(initialPage: service_index);
      _agreementController=PageController(initialPage: agreement_index);
    });
  }

  checkIsHome(){
    if(widget.bottom_bar_index==0 && isChecked==false){
      setControllers();
    }

    else if(widget.bottom_bar_index!=0){
      isChecked=false;
    }
  }
}