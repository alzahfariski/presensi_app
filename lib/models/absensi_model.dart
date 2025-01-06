class AbsensiModel {
  String? id;
  String? lat;
  String? lng;
  String? photo;
  DateTime? checkInTime;
  DateTime? checkOutTime;

  AbsensiModel({
    this.id,
    this.lat,
    this.lng,
    this.photo,
  });

  AbsensiModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    lat = json['lat'];
    lng = json['lng'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "lat": lat,
      "lng": lng,
      "photo": photo,
    };
  }
}
