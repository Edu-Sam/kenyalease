import 'package:flutter/material.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import '../../widget/module.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddStaffRole extends StatefulWidget{
  AddStaffRole({Key? key}) : super(key: key);

  @override
  _AddStaffRoleState createState()=> _AddStaffRoleState();
}

class _AddStaffRoleState extends State<AddStaffRole>{

  LandLordRepository landLordRepository = LandLordRepository();
  PropertyRepository propertyRepository = PropertyRepository();
  StaffRoleRepository staffRoleRepository = StaffRoleRepository();
  TextEditingController name_controller = TextEditingController(text: '');
  NotificationContainer notificationContainer = NotificationContainer();
  ErrorContainer errorContainer = ErrorContainer();
  List<Property> main_property=[];
  bool isLoading=false;
  bool isAddingRole=false;
  String message='';
  int? properties_value=0;
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  Validation validation = Validation();
  String error_message='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPropertiesByLandlordID();
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
            title: Text("Add Staff Role",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w500
            ),),
            actions: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(CupertinoIcons.bell_fill,color: Colors.grey.shade400,))
            ],),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
                    child: Form(
                      key: form_key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0,right: 20.0,bottom: 20.0
                            ),
                            child: Text("Select Property",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700,fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                                              child:Theme(
                                                data: Theme.of(context).copyWith(
                                                  canvasColor: AppConstants.primaryColorAccent,
                                                ),
                                                child: DropdownButtonHideUnderline(
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
                                                      items:main_property.map((value){
                                                        return DropdownMenuItem(

                                                          value: main_property.indexOf(value),
                                                          child:Text(value.propertyMaster!.property_master_name,style: const TextStyle(color: Colors.white,
                                                            fontSize: 12,fontWeight: FontWeight.w400,
                                                            //      fontFamily: GoogleFonts.openSans().fontFamily
                                                          ),),
                                                        );
                                                      }).toList(),
                                                    )
                                                ),
                                              )
                                          );

                                        }
                                    )
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.0,right: 20.0,bottom: 5.0,top:40.0
                            ),
                            child: Text("Staff Role Name",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700,fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: name_controller,
                                validator: (text){
                                  return validation.name1Validator(text!);
                                },
                                decoration: InputDecoration(
                                  hintText: 'e.g CareTaker,Manager',
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
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
                        ],
                      ),
                    )
                  )
                ),
                isAddingRole ?
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: CircularProgressContainer(
                       message: message,
                    ),
                  ),
                )  : const SizedBox()
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () async{
              if(form_key.currentState!.validate()){
                setState(() {
                 error_message='';
                 message='Creating staff role.Please wait...';
                 isAddingRole=true;
                });
                
                var result = await addStaffRole();
                setState(() {
                  isAddingRole=false;
                  message='';
                });
                
                if(result is int && result ==201){
                     notificationContainer.showNotificationDialog('Role created successfully', context, (){
                       Navigator.pop(context);
                       Navigator.pop(context,1);
                     });
                }

                else{
                  errorContainer.showInfoErrorDialog('Error creating role', context, (){
                    Navigator.pop(context);
                  });
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child:  Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[AppConstants.primaryColor,AppConstants.primaryColorAccent]
                    )
                ),

                child: Center(
                  child: Text("Create Staff Role",style: Theme.of(context).textTheme!.headline6!.copyWith(
                    color: Colors.white
                  ),),
                ),
              ),
            )
          ),
        ),
        isLoading ?
       Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         color: Colors.transparent,
         child: Center(
           child: CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColor),
           ),
         ),
       )   : const SizedBox()
      ],
    );
  }

  Future<dynamic> getPropertiesByLandlordID() async{
    setState(() {
      isLoading=true;
    });
    var result = await propertyRepository.getPropertiesByLandlordID(Provider.of<Preferences>(context,listen: false)
        .user!.remember_token,Provider.of<Preferences>(context,listen: false).user!.user_id);
    if(result is List<Property>){
      setState(() {
        isLoading=false;
        main_property=result;
      });
      return result;
    }

    else{
      setState(() {
        isLoading=false;
        main_property=[];
      });
      return result;
    }


  }

  Future<dynamic> addStaffRole() async{
    print("The token is " +  Provider.of<Preferences>(context,listen: false).user!.remember_token.toString());
    int property_id= main_property.elementAt(properties_value!).id;
    var result = await staffRoleRepository.addStaffRole(property_id, name_controller.text,
        Provider.of<Preferences>(context,listen: false).user!.user_id,
    Provider.of<Preferences>(context,listen: false).user!.remember_token);

    return result;
  }

}