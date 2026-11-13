

class Search {
  String city='';
  String town='';
  List<String> search_property_types=[];
  List<String> search_bhk_types=[];
  List<String> search_availability_types=[];
  double startVal=0.0;
  double endVal=0.0;

  Search({required this.city,required this.town,required this.search_property_types,
    required this.search_availability_types,required this.startVal,required this.endVal});


}