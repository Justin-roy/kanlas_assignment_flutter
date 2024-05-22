class UserModel {
  final bool? success;
  final String? message;
  final UserData? data;

  UserModel({
    this.success,
    this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  final String? id;
  final String? email;
  final int? phone;
  final int? coin;
  final String? password;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UserData({
    this.id,
    this.email,
    this.phone,
    this.coin,
    this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        email: json["email"],
        phone: json["phone"],
        coin: json["coin"],
        password: json["password"],
        role: json["role"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone": phone,
        "coin": coin,
        "password": password,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
