import 'dart:convert';
import 'package:agripure_mobile/models/plant_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlantService {
  static Future<List<Plant>> getPlants() async {
    var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/plants');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userName = prefs.getString('userName');

    var userUrl = Uri.parse('https://agripure-mobile-service.onrender.com/api/plants/username/$userName');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };

    final responseUser = await http.get(userUrl, headers: headers);
    final userPlants = jsonDecode(responseUser.body);

    List<Plant> plantsList = [];

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final plants = jsonDecode(response.body);

      for (var plant in plants) {
        if (!userPlants.any((userPlant) => userPlant['id'] == plant['id'])) {
          plantsList.add(Plant.fromJson(plant));
        }
      }

    }
    return plantsList;
  }

  static Future<List<Plant>> getPlantsByUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userName = prefs.getString('userName');

    var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/plants/username/$userName');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };

    List<Plant> plantsList = [];

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final plants = jsonDecode(response.body);

      for (var plant in plants) {
        plantsList.add(Plant.fromJson(plant));
      }

    }
    return plantsList;
  }

  static Future<void> savePlant(int plantId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      var urlUser = Uri.parse('https://agripure-mobile-service.onrender.com/api/users/username/$userName');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      };

      final responseUser = await http.get(urlUser, headers: headers);

      final user = jsonDecode(responseUser.body);
      final userId = user['id'];

      var urlPlant = Uri.parse('https://agripure-mobile-service.onrender.com/api/users/$userId/assign/$plantId');

      var response = await http.post(urlPlant, headers: headers);

      if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> deletePlant(int plantId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      var urlUser = Uri.parse('https://agripure-mobile-service.onrender.com/api/users/username/$userName');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      };

      final responseUser = await http.get(urlUser, headers: headers);

      final user = jsonDecode(responseUser.body);
      final userId = user['id'];

      var urlPlant = Uri.parse('https://agripure-mobile-service.onrender.com/api/users/$userId/delete/$plantId');

      var response = await http.delete(
        urlPlant,
        headers: headers,
      );

        if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: ${error}');
    }
  }
}