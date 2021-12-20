class PanchangRequest {
  int? day;
  int? month;
  int? year;
  String? placeId;

  PanchangRequest({this.day, this.month, this.year, this.placeId});

  PanchangRequest.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['placeId'] = placeId;
    return data;
  }
}
