import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static Future<void> registerFarmer(String email, String password, String name, String description, String imageUrl, String location, String type,int plantId) async {

    try{
      var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/auth/registerFarmer');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(
          url,
          headers: headers,
          body: jsonEncode({
            'email': email,
            'name': name,
            'password': password,
            'description': description,
            'imageUrl': imageUrl,
            'location':location,
            'type': type,
            'planId': plantId
          })
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        return Future.value();
      } else if(response.statusCode == 400){
        var responseBody = json.decode(response.body);
        var message = responseBody['message'];
        return Future.error('${message}');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch(error){
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> registerSpecialist(String email, String password, String name, String description, String imageUrl, String location, String type,int plantId, String expertise, String contactEmail, String areasOfFocus) async {

    try{
      var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/auth/registerSpecialist');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(
          url,
          headers: headers,
          body: jsonEncode({
            'email': email,
            'name': name,
            'password': password,
            'description': description,
            'imageUrl': imageUrl,
            'location':location,
            'type': type,
            'planId': plantId,
            'expertise': expertise,
            'contactEmail': contactEmail,
            'areasOfFocus': areasOfFocus,
          })
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        return Future.value();
      } else if(response.statusCode == 400){
        var responseBody = json.decode(response.body);
        var message = responseBody['message'];
        return Future.error('${message}');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch(error){
      return Future.error('Error on connectivity: $error');
    }
  }

  
  static Future<void> logIn(String email, String password) async {
    try {
      var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/auth/login');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'password': password, 'email': email},),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        var token = responseBody['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      } else if (response.statusCode == 401) {
        return Future.error('Invalid Credentials');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: ${error}');
    }
  }

  static Future<void> logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}