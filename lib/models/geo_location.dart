
class AppGeoLocation{
  double? lat;
  double? long;


  AppGeoLocation({this.lat,this.long});

  Map<String,dynamic> toJson()=>{
    'lat':lat.toString(),
    'lng':long.toString()
  };

  factory AppGeoLocation.fromJson(Map<String,dynamic> parsedJson){
    return AppGeoLocation(
        lat: parsedJson['lat'],
        long: parsedJson['lng']
    );
  }
}