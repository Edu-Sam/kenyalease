import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:somalease/services/authRepository.dart';
import '../module.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import '../../services/module.dart';

class ProfileSetup extends StatefulWidget{
    ProfileSetup({Key? key}):super(key: key);


    @override
  _ProfileSetupState createState()=> _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup>{

  //List<String> roles= ['Tenant/Buyer','Landlord / Property Owner','Service Provider','Property Developer'];
  List<bool> role_status=[];
  AuthRepository authRepository = AuthRepository();
  RoleRepository roleRepository = RoleRepository();
  bool isLoading=false;
  List<Role> roles=[];
  List<Role> selected_roles=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoles();
    //role_status= List.filled(roles.length, false);
    //getRoles();
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
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(CupertinoIcons.back,color: AppConstants.thirdColorDark,),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 40.0,bottom: 20.0),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/somalease_icon.png')
                                    )

                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0,top: 20.0),
                              child: Text("Profile Setup",textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black54,fontSize: 20
                                ),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                          child: Column(
                            children: roles.asMap().map((index, element){
                              return MapEntry(index,Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: GestureDetector(
                                    onTap: (){
                                //      setRoleStatus(index);
                                      setState(() {
                                        role_status[index]=!role_status[index];
                                      });
                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 40,
                                        decoration: role_status[index] ?
                                        BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[AppConstants.primaryColorAccent,AppConstants.primaryColor]
                                          )
                                        ) :
                                        BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(16.0)
                                        ),

                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.60,
                                                //  color: Colors.black,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(element.firstname,style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                        color: Colors.black87
                                                    ),),
                                                    Icon(
                                                      role_status[index] ? CupertinoIcons.star_fill : CupertinoIcons.star,
                                                      color:role_status[index] ? Colors.white/*AppConstants.thirdColorDark*/ :  Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                        )
                                    ),
                                  )
                              ));
                            }).values.toList(),
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Select the ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.black87
                                  ),),
                                  Icon(CupertinoIcons.star_fill,color: AppConstants.thirdColorDark,size: 20,),
                                  Text(" to set your default profile.You may ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.black87
                                  ),),
                                ],
                              ),
                              Text("change this later.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.black87
                              ),),
                            ],
                          )
                      ),

                      Align(
                          alignment: Alignment.center,
                          child:  Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Container(
                              width: 130,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              child: ElevatedButton(
                                child: Text('Submit',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,fontWeight: FontWeight.w600
                                ),),
                                onPressed: () async{
                                  if(role_status.any((element) => element==true)){
                                     print("Is true");
                                    /*Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        OwnerDashboard(),settings: const RouteSettings(name: '/ownerdashboard')));*/
                                   /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        TenantDashboard(),settings: const RouteSettings(name: '/tenantdashboard')));*/
                                  //  int role_index = role_status.indexWhere((element) => element==true);
                                    setState(() {
                                      isLoading=true;
                                    });
                                     var result = await insertRoles();
                                   // var result = await updateUserRole(roles.elementAt(role_index).id);
                                    setState(() {
                                      isLoading=false;
                                    });

                                    if(result is Preferences){
                                          createUserProfile(result);
                                          print("Role is " + Provider.of<Preferences>(context,listen: false).user!.role_id.toString());
                                          Navigator.pushNamedAndRemoveUntil(context,'/dashboard', (Route<dynamic> route) => false);
                                         /* if(Provider.of<Preferences>(context,listen: false).user!.role_id==14){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                TenantDashboard(),settings: const RouteSettings(name: '/tenantdashboard')));
                                          }

                                          else if(Provider.of<Preferences>(context,listen: false).user!.role_id==24){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                OwnerDashboard(),settings: const RouteSettings(name: '/ownerdashboard')));
                                          }

                                          else if(Provider.of<Preferences>(context,listen: false).user!.role_id==34){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                ProviderDashboard(),settings: const RouteSettings(name: '/providerdashboard')));
                                          }

                                          else if(Provider.of<Preferences>(context,listen: false).user!.role_id==44){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                OwnerDashboard(),settings: const RouteSettings(name: '/developerdashboard')));
                                          }*/

                                    }
                                  }

                                  else{
                                    print("is false");
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppConstants.thirdColorDark,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  /* side: BorderSide(color: AppConstants.thirdColor,

                            )*/
                                ),
                              ),
                            ),
                          )
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
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColorDark),
            ),
          ),
        )  : const SizedBox()
      ],
    );
  }


  setRoleStatus(int index){
    for(int i=0;i<roles.length;i++){
      if(i==index){
        setState(() {
          role_status[i]=true;
        });
      }

      else{
        setState(() {
          role_status[i]=false;
        });
      }
    }
  }

  createUserProfile(Preferences preferences){
    Provider.of<Preferences>(context,listen: false).user_state=preferences.user_state;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
    Provider.of<Preferences>(context,listen: false).user=preferences.user;
    Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;
    // Provider.of<Preferences>(context,listen: false).user_type=preferences.user_type;
    Provider.of<Preferences>(context,listen: false).account_type=preferences.account_type;
    Provider.of<Preferences>(context,listen: false).account_role_types=preferences.account_role_types;
    //Provider.of<Preferences>(context,listen: false).user_id=user.
  }

  Future<dynamic> getRoles() async{
    setState(() {
      isLoading=true;
    });
    var result = await roleRepository.getRoles(Provider.of<Preferences>(context,listen: false).user!.remember_token);
    if(result is List<Role>){
      setState(() {
        roles=result;
        role_status= List.filled(roles.length, false);
        isLoading= false;
      });
    }
    return result;
  }

  /*Future<dynamic> updateUserRole(int role_id) async{
    var result = await authRepository.updateRole( role_id,Provider.of<Preferences>(context,listen: false));
    return result;
  }*/

Future<dynamic> updateUserRoles(List<String> roles) async{
    var result = await authRepository.updateRoles(roles,Provider.of<Preferences>(context,listen: false));
    return result;
}

  /*Future<dynamic> updateUserRole(Role role) async{
    var result = await authRepository.updateRole( role.id,Provider.of<Preferences>(context,listen: false));
    return result;
  }*/
  Future<dynamic> insertRoles() async{
    List<String> role_ids=[];
    print("IS IN INSERT ROLES");
   roles.asMap().forEach((index, element) {
     if(role_status[index]){
       role_ids.add(element.id.toString());
     }
   });

   var result = await updateUserRoles(role_ids);
   return result;
    /*var result = await Future.wait(selected_roles.map(updateUserRole));
    return result;*/
  }

}