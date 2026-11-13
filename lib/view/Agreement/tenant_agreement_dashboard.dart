import 'package:flutter/material.dart';
import 'package:somalease/services/agreementRepository.dart';
import 'package:somalease/view/Agreement/rental_agreement.dart';
import 'package:somalease/view/Agreement/tenant_rental_agreement.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import '../../services/module.dart';
import 'package:flutter/cupertino.dart';

class TenantAgreementDashboard extends StatefulWidget{
  TenantAgreementDashboard({Key? key}) : super(key: key);

  @override
  _TenantAgreementDashboardState createState()=> _TenantAgreementDashboardState();
}

class _TenantAgreementDashboardState extends State<TenantAgreementDashboard>{

  List<PropertyMaster> property_master =[];
  List<Agreement> unsigned_agreements=[],signed_agreements=[];
  int? properties_value=0;
  PageController? _agreementController;
  int agreement_index=0;
  LandLordRepository landLordRepository = LandLordRepository();
  AgreementRepository agreementRepository = AgreementRepository();
  bool isLoading=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _agreementController=PageController(initialPage: agreement_index);
    getLandlordProperties();
    //getRentalAgreementsForLandLords();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _agreementController=null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child:
      isLoading ?
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
        ),
      ) :
      SingleChildScrollView(
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
                                    decoration:  const InputDecoration(

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
          unsignedContainer(),
          signedContainer()
        ],
      ),
    );
  }

  Widget unsignedContainer(){
    return Column(
      children: unsigned_agreements.asMap().map((index, element){
        return MapEntry(index,Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
              TenantRentalAgreement(agreement: element)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Rental Agreement",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(element.start_date + ' to ' + element.end_date,style: Theme.of(context).textTheme
                              .bodyMedium!.copyWith(color: Colors.grey.shade700),),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Text("Review >",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700
                            ),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ));
      }).values.toList(),
    );
  }

  Widget signedContainer(){
    return Column(
      children: signed_agreements.asMap().map((index, element){
        return MapEntry(index,Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  TenantRentalAgreement(agreement: element)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Rental Agreement",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade700,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(element.start_date + ' to ' + element.end_date,style: Theme.of(context).textTheme
                              .bodyMedium!.copyWith(color: Colors.grey.shade700),),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Text("Review >",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700
                            ),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ));
      }).values.toList(),
    );
  }

  Future<dynamic> getLandlordProperties() async{
    setState(() {
      isLoading=true;
    });
    var result=await landLordRepository.getLandlordPropertyMasters(Provider.of<Preferences>(context,listen: false
    ).user!.user_id, Provider.of<Preferences>(context,listen: false).user!.remember_token);
    var result1=await getRentalAgreementsForTenants();
    if(result is List<PropertyMaster>){
      setState(() {
        property_master=result;
        isLoading=false;
      });
    }

    else{
      setState(() {
        property_master=[];
        isLoading=false;
      });
    }
    return result;
  }

  Future<dynamic> getRentalAgreementsForTenants() async{
    print("Tenant token is " +  Provider.of<Preferences>(context,listen: false).user!.remember_token.toString());
    var result = await agreementRepository.getRentalAgreementsForTenants(Provider.of<Preferences>(context,listen: false)
        .user!.user_id, Provider.of<Preferences>(context,listen: false).user!.remember_token);
    if(result is List<Agreement>){
      result.forEach((element) {
        if(element.accepted==0){
          unsigned_agreements.add(element);
        }

        else{
          signed_agreements.add(element);
        }
      });
    }

    return result;
  }
}