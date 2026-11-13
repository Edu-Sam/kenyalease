import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../../widget/module.dart';
import '../module.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import '../module.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProviderAccount extends StatefulWidget{
  ProviderAccount({Key? key,required this.bottom_bar_index}) : super(key: key);
  int bottom_bar_index;

  @override
  _ProviderAccountState createState()=> _ProviderAccountState();
}

class _ProviderAccountState extends State<ProviderAccount>{

  int tab_index=0;
  int property_index=0;
  int service_index=0;
  int bottom_bar_index=0;
  PageController? _pageController,_propertyController,_serviceController;
  ServiceRepository serviceRepository = ServiceRepository();
  PropertyRepository propertyRepository =PropertyRepository();
  bool isLoading=false;
  List<SomaleaseService> somalease_services=[];
  List<Property> rent_properties =[];
  List<Property> buy_properties = [];
  List<PropertyService> my_services=[];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  ErrorContainer errorContainer = ErrorContainer();
  NotificationContainer notificationContainer = NotificationContainer();
  String url= DomainServer.name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserProfile();
    /* _pageController=PageController(initialPage: tab_index);
    _propertyController=PageController(initialPage: property_index);
    _serviceController = PageController(initialPage: service_index);
    getProperties();
    getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);*/
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _propertyController!.dispose();
    _serviceController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: widget.bottom_bar_index==0 ?
            SingleChildScrollView(
              child: Column(
                children: [
                  servicesUI()
                  /*Padding(
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
                  detailPages()*/
                ],
              ),
            ):
            widget.bottom_bar_index==1 ?
            myListings():
            widget.bottom_bar_index==2 ?
            Container() :
            widget.bottom_bar_index==3 ?
            Container() : SizedBox()
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
            ),
            serviceDetails()
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


  Future<dynamic> getServices(String token) async {

    var result = await serviceRepository.getServices(token);

    if(result is List<SomaleaseService>){
      setState(() {
        somalease_services=result;
        isLoading=false;
      });

      return result;
    }

    else{
      return Container();
    }

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
              //   height: MediaQuery.of(context).size.height,
              // height: MediaQuery.of(context).size.height * 0.35,
              // color: Colors.black,
              child: GridView.builder(itemCount:  somalease_services.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 0.0,right: 0.0,left: 0.0,top: 10.0),
                // physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 120,
                    ///  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.30,
                    maxCrossAxisExtent: 110/*MediaQuery.of(context).size.width * 0.25*/  /* * AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width)*/,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemBuilder: (context,index){
                  // if(index < 6){
                  return GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PropertyServiceDashboard(service_id:
                          somalease_services.elementAt(index).id,service_type: somalease_services
                              .elementAt(index).somalease_service_name,),
                          settings: const RouteSettings(name: '/propertyservicedashboard')
                      ));
                      /* Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SpecialistCatalogue(category:
                            user_categories.elementAt(index)),
                            settings: const RouteSettings(name: '/specialistcatalogue')
                        ));*/
                    },
                    child: ServiceContainer(specialization: somalease_services.elementAt(index).somalease_service_name,
                      field_icon: somalease_services.elementAt(index).image,),
                  );
                  //  }


                  /*else{
                    return const SizedBox();
                  }*/
                },
              )
          ),
        ],
      ),
    );
  }

  Widget rentUI(){
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
    );
  }

  Widget buyUI(){
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
    );
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
        rent_properties = result;
        //  isLoading=false;
      });

      return result;
    }

    /*else{
      setState(() {
        isLoading=false;
      });*/
    return errorContainer.showInfoErrorDialog('Could not fetch properties', context, (){
      Navigator.pop(context);
    });
  }

  Widget myListings(){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Column(
            children: my_services.asMap().map((index, element){
              return MapEntry(index,Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          PropertyServiceDetails(propertyService: element,service_type: '',)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(16.0)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 2.0
                                      ),
                                      child: Text(element.name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.black87,fontWeight: FontWeight.w600
                                      ),),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 2.0
                                      ),
                                      child: Text(element.location_name,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54,fontWeight: FontWeight.w500
                                      ),),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 2.0
                                      ),
                                      child: Text(element.email,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: Colors.black54,fontWeight: FontWeight.w500
                                      ),),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.height * 0.06,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/somalease_icon.png')
                                      )
                                  ),
                                  // color: Colors.black,
                                  /*  child: Center(
                              child: Icon(CupertinoIcons.briefcase,color: Colors.blueGrey,),
                            )*/
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ));
            }).values.toList()
        ),
      ),
    );
  }

  Future<dynamic> getMyServices() async{
    var result = await serviceRepository.getPropertyServices(Provider.of<Preferences>(context,listen: false)
        .user!.remember_token);

    if(result is List<PropertyService>){
      setState(() {
        my_services=result;
      });
    }

    else{
      setState(() {
        my_services=[];
      });
    }
    return result;
  }

  Future<void> initUserProfile() async{
    print("In here");
    setState(() {
      isLoading=true;
    });
    _pageController=PageController(initialPage: tab_index);
    _propertyController=PageController(initialPage: property_index);
    _serviceController = PageController(initialPage: service_index);
    var result1=await getProperties();
    var result2=await getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);
    var result3= await getMyServices();
    setState(() {
      isLoading=false;
    });
  }
}