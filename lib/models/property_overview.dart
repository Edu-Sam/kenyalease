
class PropertyOverview{
  int id=0;
  String age_of_building='';
  String total_floor='';
  String plot_area='';
  String facing='';
  String parking='';
  String ownership_type='';
  String builtup_area='';
  String furnishing_status='';
  String floor='';
  String gated_security='';
  int property_id=0;
  String created_at='';
  String updated_at='';
  String expected_availability='';
  double expected_rent=0.0;
  double expected_deposit=0.0;
  int rent_negotiable=0;

  PropertyOverview({required this.id,required this.age_of_building,required this.total_floor,
  required this.plot_area,required this.parking,required this.floor,required this.facing,required this.ownership_type,
  required this.builtup_area,required this.furnishing_status,required this.gated_security,
  required this.property_id,required this.expected_availability,required this.expected_rent,
  required this.expected_deposit,required this.rent_negotiable,
  required this.created_at,required this.updated_at});

  Map<String,dynamic> toJson()=>{
    'age_of_building':age_of_building.toString(),
    'total_floor':total_floor.toString(),
    'plot_area':plot_area.toString(),
    'facing':facing.toString(),
    'ownership_type':ownership_type.toString(),
    'builtup_area':builtup_area.toString(),
    'floor':floor.toString(),
    'gated_security':gated_security.toString(),
    'property_id':property_id.toString(),
    'furnishing_status':furnishing_status.toString(),
    'parking':parking.toString(),
    'rent_or_lease':expected_availability.toString(),
    'rent_amount':expected_rent.toString(),
    'expected_deposit':expected_deposit.toString(),
    'rent_negotiable':rent_negotiable.toString()
  };


  factory PropertyOverview.fromJson(Map<String,dynamic> parsedJson){
    return PropertyOverview(
        id: parsedJson['id'] ?? 0,
        age_of_building: parsedJson['age_of_building'] ?? '',
        total_floor: parsedJson['total_floor'] ?? '',
        plot_area: parsedJson['plot_area'] ?? '',
        floor: parsedJson['floor'] ?? '',
        facing: parsedJson['facing'] ?? '',
        parking: parsedJson['parking'] ?? '',
        ownership_type: parsedJson['ownership_type'] ?? '',
        builtup_area: parsedJson['builtup_area'] ?? '',
        furnishing_status: parsedJson['furnishing_status'] ?? '',
        gated_security: parsedJson['gated_security'] ?? '',
        property_id: parsedJson['property_id'] ?? 0,
        created_at: parsedJson['created_at'] ?? '',
        updated_at: parsedJson['updated_at'] ?? '',
        expected_availability: parsedJson['rent_or_lease'] ?? '',
        expected_rent: double.parse(parsedJson['rent_amount']) ?? 0,
        expected_deposit: double.parse(parsedJson['expected_deposit']) ?? 0,
        rent_negotiable: parsedJson['rent_negotiable'] ?? 0

    );
  }

  factory PropertyOverview.fetch(Map<String,dynamic> parsedJson){
    return PropertyOverview(
        id: parsedJson['id'] ?? 0,
        age_of_building: parsedJson['age_of_building'] ?? '',
        total_floor: parsedJson['total_floor'] ?? '',
        plot_area: parsedJson['plot_area'] ?? '',
        floor: parsedJson['floor'] ?? '',
        facing: parsedJson['facing'] ?? '',
        parking: parsedJson['parking'] ?? '',
        ownership_type: parsedJson['ownership_type'] ?? '',
        builtup_area: parsedJson['builtup_area'] ?? '',
        furnishing_status: parsedJson['furnishing_status'] ?? '',
        gated_security: parsedJson['gated_security'] ?? '',
        property_id: parsedJson['property_id'] ?? 0,
        //property_id: int.parse(parsedJson['property_id']) ?? 0,
        created_at: parsedJson['created_at'] ?? '',
        updated_at: parsedJson['updated_at'] ?? '',
        expected_availability: parsedJson['rent_or_lease'] ?? '',
        expected_rent: double.parse(parsedJson['rent_amount']) ?? 0,
        expected_deposit: double.parse(parsedJson['expected_deposit']) ?? 0,
        rent_negotiable: int.parse(parsedJson['rent_negotiable']) ?? 0

    );
  }
}