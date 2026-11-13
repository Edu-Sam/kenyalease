import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../../widget/module.dart';
import '../module.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';


class DeveloperDashboard extends StatefulWidget{
  DeveloperDashboard({Key? key}):super(key:key);

  @override
  _DeveloperDashboardState createState()=> _DeveloperDashboardState();
}

class _DeveloperDashboardState extends State<DeveloperDashboard>{

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserProfile();
    /*_pageController=PageController(initialPage: tab_index);
    _propertyController=PageController(initialPage: property_index);
    _serviceController = PageController(initialPage: service_index);
    _agreementController=PageController(initialPage: agreement_index);
    getProperties();
    getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);*/
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _propertyController!.dispose();
    _serviceController!.dispose();
    _agreementController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getLandlordProperties();
    // getProperties();

    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Somalease',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
                _launchWhatsapp(Provider.of<Preferences>(context,listen: false).user!.phone);
              }, icon: Icon(CupertinoIcons.chat_bubble,color: Colors.grey.shade300,)),
              IconButton(
                onPressed: (){
                  makeCall(Provider.of<Preferences>(context,listen: false).user!.phone);
                },
                icon: Icon(CupertinoIcons.person_fill,color: Colors.grey.shade300,),
              )
            ],
          ),

          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: bottom_bar_index==0 ? SingleChildScrollView(
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
                                    setState(() {
                                      _pageController!.animateToPage(1, duration: const Duration(milliseconds: 300),
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
              bottom_bar_index==1 ? Container() : bottom_bar_index==2 ? Container() :
              agreementContainer()
          ),
          floatingActionButton:bottom_bar_index!=3 ? FloatingActionButton(
            child: const Icon(CupertinoIcons.home,color: Colors.white,size: 35,),
            onPressed: () async{

              Navigator.push(context,MaterialPageRoute(builder: (context) => CreateProperty(),
                  settings: const RouteSettings(name: '/createproperty'))).then((value){
                if(value is int && value==1){
                  setState(() {
                    initUserProfile();
                  });
                }
              });
            },
            backgroundColor: AppConstants.primaryColor,
          ) :
          FloatingActionButton(
            child: const Icon(Icons.assignment,color: Colors.white,size: 35,),
            onPressed: () async{
              print("the side of property masters is " + property_master.length.toString());
              Navigator.push(context,MaterialPageRoute(builder: (context) => RentalAgreement(
                property_masters: property_master,
              ),
                  settings: const RouteSettings(name: '/rentalagreement')));
            },
            backgroundColor: AppConstants.primaryColor,
          ),
          bottomNavigationBar: CustomBottomBar(
            custom_bottom_bar_items: customBarItems(),
            showTuneIn: bottom_bar_index==0,
            is_active: bottom_bar_index,
            navigationColor: Colors.transparent,
          ),
        ),
        isLoading ?
        Container(
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
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      height: MediaQuery.of(context).size.height * 0.70,
      child: PageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (num){
          setState(() {
            tab_index=num;
          });
        },
        children: <Widget>[
          propertySearch(),
          serviceSearch()
          // buyPlans(),
          // purchaseHistory()
          // infoContainer(details),
          // basketContainer(details),
        ],
      ),
    );
  }

  Widget propertySearch(){
    return Container(
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
    );
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
      child: PageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: _propertyController,
        onPageChanged: (num){
          setState(() {
            property_index=num;
          });
        },
        children: <Widget>[
          rentDetailsContainer(),
          buyDetailsContainer(),
          Container()
          // buyPlans(),
          // purchaseHistory()
          // infoContainer(details),
          // basketContainer(details),
        ],
      ),
    );
  }

  Widget rentDetailsContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        servicesUI(),
        rentUI()
      ],
    );
  }


  Widget buyDetailsContainer(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        servicesUI(),
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

  List<CustomBottomBarItem> customBarItems(){
    return <CustomBottomBarItem>[
      CustomBottomBarItem(
        icon: Icon(Icons.home,color: Colors.white,
            size: 22 /* * AppConstants.getScaleFactor(
            Provider.of<Preferences>(context,listen: false).device_width
        ),*/),
        icon_description: 'Home',
        onTap: (){
          setState(() {
            bottom_bar_index=0;
          });
          //refreshUI(2);
        },

        isActive: bottom_bar_index == 0 ? 1 : 0,
        //   activeNavigationColor: Colors.black,
        activeNavigationColor: AppConstants.primaryColor,
        navigationColor: Colors.transparent,
        notification: 0,
      ),

      CustomBottomBarItem(
          icon: bottom_bar_index==1 ? Icon(Icons.help,color: Colors.white,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ):

          Icon(Icons.help,color: Colors.white,
              size: 22 //* AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
          ),
          icon_description: 'Support',
          onTap: (){
            setState(() {
              bottom_bar_index=1;
            });
            //refreshUI(1);

          },

          isActive: bottom_bar_index==1 ? 1: 0,
          // activeNavigationColor: Colors.black,
          activeNavigationColor: AppConstants.primaryColor,
          navigationColor: Colors.transparent,
          notification: 0
      ),

      CustomBottomBarItem(
        icon: Icon(CupertinoIcons.money_dollar_circle,color: Colors.white,
            size: 22//, * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),
        ),
        icon_description: 'Payment',
        onTap: (){
          setState(() {
            bottom_bar_index=2;
          });
          //refreshUI(0);

        },

        isActive:  bottom_bar_index == 2 ? 1 : 0,
        //  activeNavigationColor: Colors.black,
        activeNavigationColor: AppConstants.primaryColor,
        navigationColor: Colors.transparent,
        notification: 0,
      ),



      CustomBottomBarItem(

        icon: Icon(CupertinoIcons.doc_fill,color: Colors.white,
            size: 22 /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width),*/),
        icon_description: 'Agreement',
        onTap: (){
          setState(() {
            bottom_bar_index=3;
          });
          /*refreshUI(3);*/
        },

        isActive: bottom_bar_index==3 ? 1: 0,
        //activeNavigationColor: Colors.black,
        activeNavigationColor: AppConstants.primaryColor,
        navigationColor: Colors.transparent,
        notification: 0,
      ),
    ];
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
            child: Text("Explore Services",style: Theme.of(context).textTheme.headline6!.copyWith(
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
                      field_icon: '',),
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
                        field_icon: '',),
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
                              PropertyDetailsContainer(property: element)));
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
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                child: Text(element.bhk_type + 'for ' + 'rent in' + element.property_location.elementAt(0).city,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black54
                                                  ),),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                                child: Text(element.property_name,
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                      color: Colors.black54
                                                  ),),
                                              ),
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
                                                  child: Icon(CupertinoIcons.chat_bubble,color: AppConstants.primaryColor,),

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

                                  decoration: BoxDecoration(
                                    //   color: Colors.black,
                                    //  borderRadius: BorderRadius.circular(24.0),
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/property_demo.png'),
                                          fit: BoxFit.cover
                                      )
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
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),

            Row(
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
            ),
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
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                              child: Text(element.bhk_type + 'for ' + 'rent in' + element.property_location.elementAt(0).city,
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: Colors.black54
                                                ),),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
                                              child: Text(element.property_name,
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: Colors.black54
                                                ),),
                                            ),
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
                      )
                  ));
                }).values.toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    aspectRatio: 1.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),

            Row(
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
            ),
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
                                child: Text("Property Search"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
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
                              border: Border(bottom: agreement_index==1 ? BorderSide(color: Colors.grey,
                                  width: 3.0):
                              const BorderSide(color: Colors.white)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                child: Text("Services"/*, textScaleFactor:
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
    _pageController=PageController(initialPage: tab_index);
    _propertyController=PageController(initialPage: property_index);
    _serviceController = PageController(initialPage: service_index);
    _agreementController=PageController(initialPage: agreement_index);
    var result1= await getLandlordProperties().then((value) async{
      var result2= await getProperties().then((value1){
        if(temp_rent_properties.isNotEmpty){

          temp_rent_properties.forEach((new_property) {
            print("The property master id is " + new_property.property_master_id.toString());
            bool isPropertyMaster= property_master.any((element) => element.id==new_property.property_master_id &&
                element.status=='approved');
            if(isPropertyMaster){
              rent_properties.add(new_property);
            }

          });

        }
        return value1;
      });
      var result3= await getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);
      return value;
    });


    setState(() {
      isLoading=false;
    });
  }

  Future<dynamic> getLandlordProperties() async{
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
  }

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

}