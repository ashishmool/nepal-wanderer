// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String ? fname;
  String ? lname;
  String ? image;

  UserModel({
    required this.email,
    this.fname,
    this.lname,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    fname: json["fname"],
    lname: json["lname"],
    image: json["image"],

  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "fname": fname,
    "lname": lname,
    "image" : image,
  };
}
