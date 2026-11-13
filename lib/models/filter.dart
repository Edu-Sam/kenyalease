

class Filter{
  String city='';
  String town='';
  List<String> filter_property_types=[];
  List<String> filter_bhk_types=[];
  List<String> filter_tenant_types=[];
  List<String> filter_furnishing_types=[];
  double startVal=0.0;
  double endVal=0.0;

  Filter({required this.city,required this.town,required this.filter_property_types,
    required this.filter_tenant_types,required this.startVal,required this.endVal,
  required this.filter_furnishing_types,required this.filter_bhk_types});
}