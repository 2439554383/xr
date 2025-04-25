import 'package:shared_preferences/shared_preferences.dart';
var login_information_list = {};
class savainfomation {
  set_login(bool islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('islogin', islogin);
  }
  set_user_information(String user_information) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_information', user_information);
  }
  get_login() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('islogin');
  }
  get_user_information() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_information');
  }
}
