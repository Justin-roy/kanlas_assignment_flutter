import 'package:kanlas_assignment/api/api.dart';

class Repo {
  /// Create map and return only those fields that are not null
  // ignore: unused_element
  Map<String, dynamic> _removeNull(dynamic object) {
    Map<String, dynamic> map = {};
    map.addAll(object.toJson());
    map.removeWhere((key, value) => value == null);
    return map;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    var body = {'email': email, 'password': password};
    return await ApiHelper.post("/api/user/login", body);
  }

  Future<dynamic> signUp({
    required String phone,
    required String email,
    required String password,
  }) async {
    var body = {
      'phone': phone,
      'email': email,
      'password': password,
      "role": "user", //default
    };
    return await ApiHelper.post("/api/user/create-user", body);
  }

  Future<dynamic> getUser({
    required String userId,
  }) async {
    return await ApiHelper.get("/api/user/$userId");
  }

  Future<dynamic> sentOTP({
    required String email,
  }) async {
    return await ApiHelper.get("/api/user/otp?email=$email");
  }

  Future<dynamic> veriftyOTP({
    required String email,
    required String password,
    required String otp,
  }) async {
    return await ApiHelper.post(
        "/api/user/verify-otp?email=$email&password=$password&otp=$otp", null);
  }

  Future<dynamic> scanQrCode({
    required String qrCode,
    required String userId,
  }) async {
    return await ApiHelper.get("/api/user/check-code/$userId?qrCode=$qrCode");
  }
}
