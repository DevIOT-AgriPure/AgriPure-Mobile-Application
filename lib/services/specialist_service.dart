import 'dart:convert';
import 'package:agripure_mobile/models/specialist_model.dart';
import 'package:agripure_mobile/models/specialist_model2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SpecilistService {
  static Future<List<Specialist>> getSpecilists() async {
    var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/api/v1/specialists');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerId = prefs.getInt('accountId');
    var userUrl = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/api/v1/crops/$farmerId');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
     // "Authorization": 'Bearer $token'
    };
    final responseUser = await http.get(userUrl, headers: headers); // Obtener el plantId de un Farmer
    final userSpecialist = jsonDecode(responseUser.body); //json de los plantId

    List<Specialist2> specialistList = [];

    final response = await http.get(url, headers: headers); //retorna las plantas

    if (response.statusCode == 200) {
      final specialists = jsonDecode(response.body); // retorna los json de los specialistas
      for (var specialist in specialists) {
        if (!userSpecialist.any((userSpecialist) => userSpecialist['specialistId'] == specialist['id'])) {
          specialistList.add(Specialist2.fromJson(specialist));
        }
      }
    }
    return specialistList;
  }


}