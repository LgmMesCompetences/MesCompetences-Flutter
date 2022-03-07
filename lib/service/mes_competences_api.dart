import 'package:flutter_api/modele/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:flutter_api/modele/book.dart';
import 'package:flutter_api/modele/authenticate.dart';

class MesCompetencesApi {
  final _baseUrl =
      'https://s3-4380.nuage-peda.fr/mescompetences.dev/public/api/';
  String _user(int id) => _baseUrl + 'users/' + id.toString();
  String _posseder(int id) => _baseUrl + 'posseders?user.id=' + id.toString();
  String _authenticate() => _baseUrl + 'authenticate';
  String _create() => _baseUrl + 'users';

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

  Future<User> createUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(_create()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Problème dans la création de l\'utilisateur');
    }
  }

/*
  Future<List<Posseder>>
*/

}
