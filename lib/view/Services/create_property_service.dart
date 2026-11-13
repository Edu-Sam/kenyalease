import 'package:flutter/material.dart';
import 'package:somalease/services/module.dart';
import '../../widget/module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePropertyService extends StatefulWidget{
  CreatePropertyService({Key? key}) : super(key: key);

  @override
  _CreatePropertyServiceState createState()=> _CreatePropertyServiceState();
}

class _CreatePropertyServiceState extends State<CreatePropertyService>{

  TextEditingController name_controller= TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  TextEditingController location_controller = TextEditingController();
  bool isLoading = false;
  String message='';
  ErrorContainer errorContainer = ErrorContainer();
  NotificationContainer notificationContainer = NotificationContainer();
  Validation validation = Validation();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  ServiceRepository serviceRepository = ServiceRepository();
  List<SomaleaseService> somalease_Services=[];
  int? somalease_service_value=0;


  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    getServices();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Create Your Service',style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppConstants.primaryColor
            ),),
            centerTitle: true,
            leading: IconButton(
              icon:  Icon(CupertinoIcons.back,color: AppConstants.primaryColorDark,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: form_key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
              * 'name':name.toString(),
    'phone':phone.toString(),
    'email':email.toString(),
    'description':description.toString(),
    'location_name':location_name.toString(),
              * */

                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              // border: Border.all(color: Colo)
                            ),
                            child: TextFormField(
                              controller: name_controller,
                              validator: (text){
                                return validation.name1Validator(text!);
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Name of your Service',
                                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400,fontWeight: FontWeight.w500
                                ) ,


                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            // color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
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

                                        decoration:  InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                          //     labelStyle: textStyle,
                                          errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 14.0),
                                          hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          // labelText:'Select Bank',
                                        ),
                                        child:DropdownButtonHideUnderline(
                                            child:DropdownButton(
                                              value: somalease_service_value,
                                              isDense: true,
                                              hint:  Text("Select",style: TextStyle(color: Colors.grey.shade600,fontSize: 14,
                                                //   fontFamily: GoogleFonts.openSans().fontFamily,fontWeight: FontWeight.w400
                                              ),),

                                              onChanged: (int? newValue){
                                                somalease_service_value=newValue;
                                                state.didChange(newValue);


                                              },
                                              //  icon: null,
                                              icon: const Icon(Icons.keyboard_arrow_down),
                                              items:somalease_Services.map((value){
                                                return DropdownMenuItem(
                                                  value: somalease_Services.indexOf(value),
                                                  child:Text(value.somalease_service_name,style: TextStyle(color: Colors.grey.shade600,
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              // border: Border.all(color: Colo)
                            ),
                            child: TextFormField(
                              controller: email_controller,
                              validator: (text){
                                return validation.emailValidator(text!);
                              },
                              decoration: InputDecoration(
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
                                hintText: 'email',
                                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400,fontWeight: FontWeight.w500
                                ) ,


                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              // border: Border.all(color: Colo)
                            ),
                            child: TextFormField(
                              controller: phone_controller,
                              validator: (text){
                                return validation.phoneValidator(text!);
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Phone No e.g +2547xxxxxxx',
                                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400,fontWeight: FontWeight.w500
                                ) ,


                              ),
                            ),
                          ),
                        ),



                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              // border: Border.all(color: Colo)
                            ),
                            child: TextFormField(
                              controller: location_controller,
                              validator: (text){
                                return validation.name1Validator(text!);
                              },
                              decoration: InputDecoration(
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
                                hintText: 'Location e.g Nairobi West,Kenya',
                                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400,fontWeight: FontWeight.w500
                                ) ,


                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0,top: 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              // border: Border.all(color: Colo)
                            ),
                            child: TextFormField(
                              controller: description_controller,
                              validator: (text){
                                return validation.name1Validator(text!);
                              },
                              maxLines: 4,
                              minLines: 4,
                              decoration: InputDecoration(
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
                                hintText: 'Brief description of your service',
                                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade400,fontWeight: FontWeight.w500
                                ) ,


                              ),
                            ),
                          ),
                        ),


                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              selectPhoto(ImageSource.gallery);
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(1.0,1.0),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        color: Colors.black12
                                    )
                                  ]
                              ),

                              child: _image==null ? Center(
                                child: Text('Upload Image ',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.black54,
                                ),
                                  textAlign: TextAlign.center,),
                              ) : ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.file(_image!,width: 150,height: 150,fit: BoxFit.cover,),),
                            ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: GestureDetector(
                              onTap: () async{
                                if(form_key.currentState!.validate()){
                                  setState(() {
                                    message='Creating your service.Please wait...';
                                    isLoading=true;
                                  });

                                  var result = await addService();
                                  setState(() {
                                    isLoading=false;
                                    message='';
                                  });
                                  if(result is int && result == 200){
                                    notificationContainer.showNotificationDialog('Your Service has been Created successfully', context, (){
                                      Navigator.pop(context);
                                      Navigator.pop(context,1);
                                    });
                                  }

                                  else{
                                    errorContainer.showInfoErrorDialog('Could not create service.please try again', context, (){
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),

                                ),
                                child: Center(
                                  child: Text("Post Service",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  )
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
            child: CircularProgressContainer(
              message: message,
            ),
          ),
        )  : const SizedBox()
      ],
    );
  }

  Future selectPhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //  Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future<dynamic> getServices() async{
    setState(() {
      message='Fetching Services.Please wait...';
      isLoading=true;
    });
    var result = await serviceRepository.getServices(Provider.of<Preferences>(context,listen: false).user!.remember_token);
    if(result is List<SomaleaseService>){
      setState(() {
        somalease_Services=result;
        isLoading=false;
        message='';
      });

      return result;
    }

    else{
      setState(() {
       isLoading=false;
       message='';
      });
       return errorContainer.showInfoErrorDialog('Could not fetch services.Please try again', context, (){
         Navigator.pop(context);
       });
    }

  }

  Future<dynamic> addService() async{
    PropertyService propertyService = PropertyService(
        id: 0, name: name_controller.text, phone: phone_controller.text,
        email: email_controller.text,
        description: description_controller.text,
        location_name: location_controller.text,
        service_provider_id: Provider.of<Preferences>(context,listen: false).user!.user_id,
        longitude: 0, latitude: 0, images: '',somalease_service_id: somalease_Services.elementAt(somalease_service_value!)
        .id);

    if(_image!=null){
      propertyService.image=_image;
    }

    var result = await serviceRepository.addPropertyService(propertyService, somalease_Services.elementAt(somalease_service_value!)
        .id, Provider.of<Preferences>(context,listen: false).user!.remember_token);

    return result;
  }
}