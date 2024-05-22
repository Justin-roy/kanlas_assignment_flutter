import 'package:shared_preferences/shared_preferences.dart';

/// [Pref] is the singleton class that is used to get the user's preferences.
class Pref {
  static final Pref _obj = Pref._internal();

  static Pref get instance => _obj;

  late SharedPreferences pref;

  factory Pref() {
    return _obj;
  }

  Pref._internal();

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await pref.clear();
  }
}
