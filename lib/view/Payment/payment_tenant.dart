import 'package:flutter/material.dart';
import '../../constants/module.dart';

class PaymentTenant extends StatefulWidget{
  PaymentTenant({Key? key}) : super(key: key);

  @override
  _PaymentTenantState createState()=> _PaymentTenantState();
}

class _PaymentTenantState extends State<PaymentTenant>{

  PageController? paymentController;
  int payment_index=0;
  List<String> properties=["ABC Apartments"];
  int? properties_value=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController = PageController(initialPage: payment_index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
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
                                          items:properties.map((value){
                                            return DropdownMenuItem(

                                              value: properties.indexOf(value),
                                              child:Text(value,style: TextStyle(color: Colors.black54,
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
                              paymentController!.animateToPage(0, duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                // color: Colors.white,
                                border: Border(bottom: payment_index==0 ? BorderSide(color: Colors.grey.shade300,
                                    width: 3.0):
                                const BorderSide(color: Colors.white)
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                  child: Text("Pending"/*,textScaleFactor:AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                    style: TextStyle(color: payment_index==0 ? AppConstants.primaryColorAccent : Colors.grey,
                                      fontSize: 15,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              paymentController!.animateToPage(1, duration: const Duration(milliseconds: 300),
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
                                border: Border(bottom: payment_index==1 ?  BorderSide(color: Colors.grey.shade300,
                                    width: 3.0):
                                const BorderSide(color: Colors.white)
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                  child: Text("Paid"/*, textScaleFactor:
                                  AppConstants.getScaleFactor(Provider.of<Preferences>(context,listen: false).device_width!)*/,
                                    style: TextStyle(color: payment_index==1 ? AppConstants.primaryColorAccent : Colors.grey,
                                      fontSize: 15,fontWeight: FontWeight.w500,/*fontFamily: GoogleFonts.roboto().fontFamily*/)

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
            paymentPages()
          ],
        ),
      ),
    );
  }

  Widget paymentPages(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height -(tab_bar_height + 55),
      height: MediaQuery.of(context).size.height * 0.70,
      child: PageView(
        //pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: paymentController,
        onPageChanged: (num){
          setState(() {
            payment_index=num;
          });
        },
        children: <Widget>[
          Container(),
          Container()
        ],
      ),
    );
  }
}