class UserModel {
  String? id;
  String? email;
  String? token;

  UserModel({
    this.id,
    this.email,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "token": token,
    };
  }
}
