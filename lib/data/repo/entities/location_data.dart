class LocationData {
  List<Data>? data;

  LocationData({required this.data});

  LocationData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? placeName;
  String? placeId;

  Data({this.placeName, this.placeId});

  Data.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeId = json['placeId'];
  }
}
