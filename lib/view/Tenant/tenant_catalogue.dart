import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/module.dart';
import '../../services/module.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TenantCatalogue extends StatefulWidget{
  @override
  TenantCatalogue({Key? key}) : super(key: key);

  _TenantCatalogueState createState()=> _TenantCatalogueState();
}

class _TenantCatalogueState extends State<TenantCatalogue>{

  List<User> main_tenants=[];
  TenantRepository tenantRepository = TenantRepository();
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTenants();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back,color: Colors.black54,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: Text("Tenants",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
            ),),
            ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1.0,1.0),
                                    spreadRadius: 1.0,
                                    blurRadius: 1.0,
                                    color: Colors.black26
                                )
                              ]
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("My Tenants",style: Theme.of(context).textTheme.headline5!.copyWith(
                                            color: AppConstants.primaryColorAccent,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        GestureDetector(
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Filter",style: Theme.of(context).textTheme.headline6!.copyWith(
                                                  color: AppConstants.thirdColor,
                                                  fontSize: 20
                                              ),),
                                              Icon(Icons.filter_alt_rounded,color: AppConstants.thirdColor,)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                                    child: Divider(indent: 20.0,endIndent: 20.0,color: Colors.grey.shade400,),
                                  ),
                                  Column(
                                      children: main_tenants.asMap().map((index, element){
                                        return MapEntry(index,Padding(
                                          padding: EdgeInsets.only(bottom: 0.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height * 0.08,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(bottom: BorderSide(color: Colors.grey.shade300))
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.55,
                                                        //    color: Colors.black,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(element.firstname + ' ' + element.lastname,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                color: Colors.grey.shade700
                                                            ),),
                                                            /*Padding(
                                                              padding: EdgeInsets.only(top: 10.0),
                                                              child: Text(element,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                  color: Colors.grey.shade700
                                                              ),),
                                                            )*/
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                         /* Padding(
                                                            padding: EdgeInsets.only(bottom: 20.0),
                                                            child: Text(element.staffRole!.name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                color: Colors.grey.shade700
                                                            ),),
                                                          ),*/
                                                          Text("View Details >",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                              color: Colors.grey.shade700
                                                          ),),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        ));
                                      }).values.toList()
                                  ),
                                ],
                              )
                          ),
                        ),
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
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColorDark),
            ),
          ),
        )    :
        const SizedBox()

      ],
    );
  }

  Future<dynamic> getTenants() async{
    setState(() {
      isLoading=true;
    });
    /*var result = await tenantRepository.getTenants(Provider.of<Preferences>(context,listen: false)
    .user!.remember_token);*/
    var result = await tenantRepository.getTenantsByLandlordID(Provider.of<Preferences>(context,listen: false)
        .user!.remember_token,Provider.of<Preferences>(context,listen: false).user!.user_id);

    if(result is List<User>){
      setState(() {
        main_tenants=result;
        isLoading=false;
      });
    }

    else{
      setState(() {
        main_tenants=[];
        isLoading=false;
      });
    }
    return result;
  }


}