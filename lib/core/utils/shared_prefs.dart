import 'package:shared_preferences/shared_preferences.dart';

class MyShPrefs {
  //Own class Singleton Model
  static final MyShPrefs _instance = new MyShPrefs._internal();

  factory MyShPrefs() => _instance;

  MyShPrefs._internal();

  SharedPreferences _prefs;

  initPrefs() async => this._prefs = await SharedPreferences.getInstance();

  //Fuunctios...
  Future<bool> clearPrefs() async => await _prefs.clear();

  //Examples
  final _name = '_name';
  final _id = '_id';

  set id(String value) => _prefs.setString(_id, value);

  String get id => _prefs.getString(_id) ?? '';

  set name(String value) => _prefs.setString(_name, value);

  String get name => _prefs.getString(_name) ?? '';
}
