import 'package:flutter/material.dart';
import 'package:somalease/view/Dashboard/dashboard.dart';
import 'package:somalease/view/Services/property_service_dashboard.dart';
import 'view/module.dart';
import 'route_aware.dart';
import 'package:provider/provider.dart';
import 'models/module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> Preferences(account_type: 0,user_id: 0,user_state: '',isLoggedIn: false,
        account_role_types: [],current_location: AppGeoLocation(long: 0,lat: 0),
        temp_location: AppGeoLocation(long: 0,lat: 0),
        markers: Set<Marker>(),position: null,location_permission: false,
        notification_permission: false,camera_permission: false,
        tempLocation: PropertyLocation(id: 0,property_id: 0,city: '',locality: '',landmark_street: '',
        postal_code: '',address: '',address_line_2: '',street_address: '',)
      ))
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Somalease',
      navigatorObservers: [routeObserver],
      //  theme: AppConstants.appTheme,
      routes: <String,WidgetBuilder>{
        '/launch':(context) => RouteAwareWidget('/launch',child: LaunchScreen(),),
        '/launchinfo':(context) => RouteAwareWidget('/launchinfo',child: LaunchInfo(),),
        '/launchoption':(context) => RouteAwareWidget('/launchoption',child: LaunchOptionScreen(),),
        '/login':(context) => RouteAwareWidget('/login',child: LoginScreen(),),
        '/signup':(context) => RouteAwareWidget('/signup', child: SignUp()),
        '/verification':(context) => RouteAwareWidget('/verification', child: VerificationScreen(email: '',)),
        '/profile_setup':(context) => RouteAwareWidget('/profile_setup', child: ProfileSetup()),
        '/tenantdashboard':(context) => RouteAwareWidget('/tenantdashboard', child: TenantDashboard()),
        '/ownerdashboard':(context) => RouteAwareWidget('/ownerdashboard', child: OwnerDashboard()),
        '/providerdashboard':(context) => RouteAwareWidget('/providerdashboard', child: ProviderDashboard()),
        '/developerdashboard':(context) => RouteAwareWidget('/developerdashboard', child: DeveloperDashboard()),
        '/createproperty':(context) => RouteAwareWidget('/createproperty', child: CreateProperty()),
        '/propertydetails':(context) => RouteAwareWidget('/propertydetails',child: PropertyDetailsContainer(
          property: null,
        ),),
        '/propertyservice':(context) => RouteAwareWidget('/propertyservice', child: CreatePropertyService()),
        '/rentalagreement':(context) => RouteAwareWidget('/rentalagreement', child: RentalAgreement(property_masters: [],)),
        '/propertyservicedashboard':(context) => RouteAwareWidget('/propertyservicedashboard', child: PropertyServiceDashboard(
          service_id: 0,service_type: '',
        )),
        '/propertyservicedetail':(context) => RouteAwareWidget('/propertyservicedetail',child: PropertyServiceDetails(
          propertyService: null,service_type: '',
        ),),
        '/updateproperty':(context) => RouteAwareWidget('/updateproperty', child: UpdateProperty(property: null,)),
        '/createproperty1':(context) => RouteAwareWidget('/createproperty1', child: CreateProperty1()),
        'listingcatalogue':(context) => RouteAwareWidget('/listingcatalogue', child: ListingsCatalogue()),
        '/propertydetail':(context)=> RouteAwareWidget('/propertydetail', child: PropertyDetailContainer(
          property: null,
        )),
        '/searchproperty':(context) => RouteAwareWidget('/searchproperty', child: SearchProperty()),
        '/searchpropertyresult':(context) => RouteAwareWidget('/searchpropertyresult', child: SearchPropertyResult(
         city: '',town: '',search_property_types: [],search_bhk_types: [],
          search_availability_types: [],startVal: 0,endVal: 0,
        )),
        '/manage':(context) => RouteAwareWidget('/manage', child: ManageCatalogue()),
        '/filter':(context) => RouteAwareWidget('/filter',child: FilterProperty(filter: null,),),
        '/agreementcatalogue':(context) => RouteAwareWidget('/agreementcatalogue', child: AgreementCatalogue()),
        '/paymenttenant':(context) => RouteAwareWidget('/paymenttenant', child: PaymentTenant()),
        '/tenantagreementcatalogue':(context) => RouteAwareWidget('/tenantagreementcatalogue',
            child: TenantAgreementDashboard()),
        '/staffrolecatalogue':(context) => RouteAwareWidget('/staffrolecatalogue', child: StaffRoleCatalogue()),
        '/addstaffrole':(context) => RouteAwareWidget('/addstaff',child: AddStaffRole(),),
        '/staffcatalogue':(context) => RouteAwareWidget('/staffcatalogue',child: StaffCatalogue(),),
        '/tenantrentalagreement':(context) => RouteAwareWidget('/tenantrentalagreement', child: TenantRentalAgreement(
          agreement: null,
        )),
        '/chatcatalogue':(context) => RouteAwareWidget('/chatcatalogue', child: ChatCatalogue()),
        '/tenantcatalogue':(context) => RouteAwareWidget('/tenantcatalogue', child: TenantCatalogue()),
        '/dashboard':(context) => RouteAwareWidget('/dashboard', child: Dashboard()),
        '/updateproperty1':(context)=> RouteAwareWidget('/updateproperty1', child: UpdateProperty1(
          property: null,
        )),
        '/landlordrentalagreement':(context) => RouteAwareWidget('/landlordrentalagreement', child:
        LandlordRentalAgreement(agreement: null,))
      },
      home: RouteAwareWidget('/launch',child: LaunchScreen(),),
    ),);
  }
}
