import 'dart:convert';
import 'package:agripure_mobile/models/event_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EventService {
  static Future<Map<String, List<Event>>> getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userName = prefs.getString('userName');

    var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/events/${userName}');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };

    Map<String, List<Event>> eventsList = {};

    final response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      final events = jsonDecode(response.body);

      for(var event in events){
        if (eventsList[event["date"]] != null) {
          eventsList[event["date"]]?.add(Event(event["title"],event["id"],event["date"]));
        } else {
          eventsList[event["date"]] = [
            Event(event["title"],event["id"],event["date"])
          ];
        }
      }
    } else {
      return Future.error("Request error: ${response.statusCode}");
    }
    return eventsList;
  }

  static Future<void> saveEvent(Event event) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/events/$userName');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      };

      var response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(event.toJson())
      );

      if(response.statusCode != 201){
        return Future.error("Request error: ${response.statusCode}");
      }

    }catch(error){
      return Future.error("Error on connectivity: $error");
    }
  }

  static Future<void> deleteEvent(int eventId) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/events/user/$userName/$eventId');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      };

      var response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }

    } catch (error){
      return Future.error("Error on connectivity: $error");
    }
  }
}