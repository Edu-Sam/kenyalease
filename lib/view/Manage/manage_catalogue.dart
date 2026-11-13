import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/view/Agreement/agreement_catalogue.dart';
import 'package:somalease/view/Agreement/rental_agreement.dart';
import 'package:somalease/view/module.dart';
import '../../constants/module.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageCatalogue extends StatefulWidget{
  ManageCatalogue({Key? key}) :super(key: key);

  @override
  _ManageCatalogueState createState()=> _ManageCatalogueState();
}

class _ManageCatalogueState extends State<ManageCatalogue>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
     width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 20.0),
                            crossAxisCount: 4,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 8/12,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  TenantCatalogue(),
                                  settings: const RouteSettings(name: '/tenantcatalogue')));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(Icons.key_outlined,color: Colors.red,
                                            size: 24,),*/


                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/my_tenants.png')
                                              )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('My Tenants',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                         /* Icon(CupertinoIcons.chat_bubble_2_fill,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/support_request.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Support Requests',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(

                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  StaffCatalogue(),settings: const RouteSettings(name: '/staffcatalogue')));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(CupertinoIcons.person_crop_square,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/my_staff.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('My Staff',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(CupertinoIcons.paperplane,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/announcements.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Anouncements',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(

                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => AgreementCatalogue(),
                                  settings: const RouteSettings(name: '/agreementcatalogue')));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(CupertinoIcons.doc,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/agreements.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Agreements',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(Icons.money_outlined,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/invoices.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Invoices',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),

                              GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          /*Icon(CupertinoIcons.creditcard_fill,color: Colors.red,
                                            size: 24,),*/
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage('assets/images/payments.png')
                                                )
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Payments',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  StaffRoleCatalogue(),settings: const RouteSettings(
                                    name: '/staffrolecatalogue'
                                  )));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[Colors.white,Colors.white,AppConstants.listingBanner]
                                          )
                                        // color: Colors.grey.shade100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.person_2_fill,color: AppConstants.manage_icon_color,
                                            size: 24,),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text('Roles',style: Theme.of(context).textTheme
                                          .bodySmall!.copyWith(color: AppConstants.thirdColorDark,
                                          fontSize: 11),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
              //    height: MediaQuery.of(context).size.height * 0.30,
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
                    padding: EdgeInsets.only(left: 0.0,right: 0.0,top: 20.0,bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 0.0,left: 20.0,right: 20.0),
                        child: Text("Upcoming Payments",style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppConstants.primaryColorAccent,fontWeight: FontWeight.w600
                        ),),
                      ),

                        Divider(color: Colors.grey.shade400,indent: 20.0,endIndent: 20.0,),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.50,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("ABC Apartment A1",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("John Doe",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("50,000/=",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.30,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("10 days",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("Overdue",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("View details >",style: Theme.of(context).textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 12
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color:Colors.grey.shade400),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.50,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("ABC Apartment A1",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("John Doe",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("50,000/=",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("10 days",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Overdue",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("View details >",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color:Colors.grey.shade400),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.50,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("ABC Apartment A1",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("John Doe",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("50,000/=",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("10 days",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Overdue",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("View details >",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color:Colors.grey.shade400),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //    height: MediaQuery.of(context).size.height * 0.30,
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
                    padding: EdgeInsets.only(left: 0.0,right: 0.0,top: 20.0,bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0,left: 20.0,right: 20.0),
                          child: Text("Latest support requests",style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppConstants.primaryColorAccent,fontWeight: FontWeight.w600
                          ),),
                        ),

                        Divider(color: Colors.grey.shade400,indent: 20.0,endIndent: 20.0,),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Plumbing issue at ABC Apartments",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("John Doe",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("01-01-2022",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Answered",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                          /*Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Overdue",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),*/

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("View details >",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color:Colors.grey.shade400),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Plumbing issue at ABC Apartments",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("John Doe",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("01-01-2022",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Answered",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                          /*Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Overdue",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),*/

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("View details >",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color:Colors.grey.shade400),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Plumbing issue at ABC Apartments",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("John Doe",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("01-01-2022",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Answered",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                          /*Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("Overdue",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),*/

                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text("View details >",style: Theme.of(context).textTheme
                                                .bodyMedium!.copyWith(
                                                color: Colors.grey.shade700,
                                                fontSize: 12
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color:Colors.grey.shade400),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}