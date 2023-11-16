import 'dart:convert';
import 'package:agripure_mobile/models/specialist_model.dart';
import 'package:agripure_mobile/models/specialist_model2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SpecilistService {
  static Future<List<Specialist>> getSpecilist() async {
    var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/api/v1/specialists');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };

    List<Specialist> specialistList = [];

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final specialists = jsonDecode(response.body);

      for (var specialist in specialists) {
        specialistList.add(Specialist.fromJson(specialist));
      }

      return specialistList;
    }
    return specialistList;
  }
}