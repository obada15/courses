import 'dart:convert';
import 'package:Courses/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {

  late UserModel ?_user;
  UserModel ?get user => _user;

  Future<bool> setUser(UserModel? value) async {
     //setIsFirstTime(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = value;
    return prefs.setString('User', value == null? "": json.encode(value.toJson()));
  }
  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? val = prefs.getString('User');
    _user = ((val ==null||val == "") ? null : UserModel.fromJson(json.decode(val)));
   /* print("_user.data.apiToken");
    print(_user.data.apiToken);*/
    return _user;
  }

}

final dataStore = DataStore();
