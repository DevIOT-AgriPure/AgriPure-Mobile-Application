import 'dart:convert';

import 'package:agripure_mobile/models/devices_model.dart';
import 'package:http/http.dart' as http;

class DeviceService {

  static Future<List<DevicesCatalog>> getAllDevices() async {
    var url = Uri.parse('https://my-json-server.typicode.com/DevIOT-AgriPure/agripure-jsonTres/DevicesCatalog/');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      // Mapea la lista de JSON utilizando el constructor fromJson de DevicesCatalog
      List<DevicesCatalog> devicesList = jsonData.map((deviceJson) {
        return DevicesCatalog.fromJson(deviceJson);
      }).toList();
      
      return devicesList;
    } else {
      throw Exception('Error al obtener la lista de dispositivos');
    }
  }
}
