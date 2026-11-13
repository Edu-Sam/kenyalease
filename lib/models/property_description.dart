
class PropertyDescription{
  int id=0;
  String description='';
  String carpet_area='';
  String preferred_tenant='';
  String service_charge='';
  int service_charge_fee=0;
  String availability_date='';
  int non_veg_allowed=0;
  int gym=0;
  String water_supply='';
  String electricity='';
  String other_amenities='';
  int property_id=0;

  PropertyDescription({required this.id,required this.description,required this.property_id,
  required this.carpet_area,required this.preferred_tenant,required this.service_charge,
  required this.service_charge_fee,required this.availability_date,required this.non_veg_allowed,
  required this.gym,required this.water_supply,required this.electricity,required this.other_amenities});

  Map<String,dynamic> toJson()=>{
    'description':description.toString(),
    'property_id':property_id.toString()
  };
  factory PropertyDescription.fromJson(Map<String,dynamic> parsedJson){
    return PropertyDescription(
        id: parsedJson['id'] ?? 0,
        description: parsedJson['description'] ?? '',
        property_id: parsedJson['property_id'] ?? 0,
       carpet_area: parsedJson['carpet_rea'] ?? '',
      preferred_tenant: parsedJson['preferred_tenant'] ?? '',
      service_charge: parsedJson['service_charge'] ?? '',
      service_charge_fee: parsedJson['service_charge_fee'] ?? 0.0,
      availability_date: parsedJson['availability_date'] ?? '',
      non_veg_allowed: parsedJson['non_veg_allowed'] ?? 0,
      gym: parsedJson['gym'] ?? 0,
      water_supply: parsedJson['water_supply'] ??'',
      electricity: parsedJson['electricity'] ?? '',
      other_amenities: parsedJson['other_amenities'] ?? ''

    );
  }

  factory PropertyDescription.fetch(Map<String,dynamic> parsedJson){
    return PropertyDescription(
        id: parsedJson['id'] ?? 0,
        description: parsedJson['description'] ?? '',
      //  property_id: int.parse(parsedJson['property_id']) ?? 0,
      //  property_id: int.parse(parsedJson['property_id']) ?? 0,
        property_id: parsedJson['property_id'] ?? 0,
        carpet_area: parsedJson['carpet_rea'] ?? '',
        preferred_tenant: parsedJson['preferred_tenant'] ?? '',
        service_charge: parsedJson['service_charge'] ?? '',
        service_charge_fee: int.parse(parsedJson['service_charge_fee']) ?? 0,
        availability_date: parsedJson['availability_date'] ?? '',
        non_veg_allowed: int.parse(parsedJson['non_veg_allowed']) ?? 0,
        gym: int.parse(parsedJson['gym']) ?? 0,
        water_supply: parsedJson['water_supply'] ??'',
        electricity: parsedJson['electricity'] ?? '',
        other_amenities: parsedJson['other_amenities'] ?? ''

    );
  }
}