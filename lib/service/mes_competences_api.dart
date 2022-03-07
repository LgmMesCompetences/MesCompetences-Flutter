import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:flutter_api/modele/book.dart';
import 'package:flutter_api/modele/authenticate.dart';

class MesCompetencesApi {
  final _baseUrl =
      'https://s3-4380.nuage-peda.fr/mescompetences.dev/public/api/';
  String _user(int id) => _baseUrl + 'users/' + id.toString();
  String _authenticate() => _baseUrl + 'authenticate';

  Future<Map<String, dynamic>> request(String url) async {
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body;
  }

  Future<Authenticate> authenticate(String email, String password) async {
    final response = await http.post(Uri.parse(_authenticate()),
        body: json.encode({"username": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    final body = json.decode(response.body);

    return Authenticate.fromJSON(body);
  }
}
