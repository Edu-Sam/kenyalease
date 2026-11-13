

class PropertyDay{
  int id;
  String viewing_day;
  String from_time;
  String to_time;
  String contact_person;
  String phone;
  int property_id;


  PropertyDay({required this.id,required this.viewing_day,required this.from_time,required this.to_time,
  required this.contact_person,required this.phone,required this.property_id});

  factory PropertyDay.fromJson(Map<String,dynamic> parsedJson){
    return PropertyDay(
        id: parsedJson['id'],
        viewing_day: parsedJson['viewing_day'],
        from_time: parsedJson['from_time'],
        to_time: parsedJson['to_time'],
        contact_person: parsedJson['contact_person'],
        phone: parsedJson['phone'],
        property_id: parsedJson['property_id']);
  }
}