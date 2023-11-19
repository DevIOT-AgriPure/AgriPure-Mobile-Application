import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  final String baseUrl = "http://nifty-jet-404014.rj.r.appspot.com/api/v1/contacts";

  Future<void> startChatContact(int id) async {
    await http.put(Uri.parse("$baseUrl/startChatForContact/$id"));
  }

  Future<List<dynamic>> getContactsForFarmer(String token, int id) async {
    final response = await http.get(Uri.parse("$baseUrl/contactByFarmerId/$id"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contacts for farmer');
    }
  }

  Future<List<dynamic>> getContactsForSpecialist(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/contactBySpecialistId/$id"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contacts for specialist');
    }
  }

  Future<Map<String, dynamic>> getContactById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/contactById/$id"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contact by id');
    }
  }

  Future<void> deleteContactById(int id) async {
    await http.delete(Uri.parse("$baseUrl/deleteContactById/$id"));
  }

  Future<void> addContact(int farmerId, int specialistId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "farmerId": farmerId,
        "specialistId": specialistId,
        "isChatStarted": false,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }
}