import 'package:mes_competences/service/request_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:mes_competences/entity/authenticate.dart';
import 'package:mes_competences/entity/user.dart';

class MesCompetencesApi {
  final _baseUrl ='https://s3-4380.nuage-peda.fr/mescompetences.dev/public/api/';
  String _authenticate() => _baseUrl + 'authenticate';
  String _getUser(int id) => _baseUrl + 'users/' + id.toString();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<Authenticate> doAuthenticate({required String email, required String password}) async {
    Map<String, dynamic> response = await RequestUtils.postRequest(
      _authenticate(),
      body: json.encode({"username": email, "password": password}),
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
    );

    Authenticate auth = Authenticate.fromJSON(response['data']);

    if (auth.token != null && auth.id != null) {
      storage.write(key: 'app.user.username', value: email);
      storage.write(key: 'app.user.password',value: password);
      storage.write(key: 'app.user.token', value: auth.token);
      storage.write(key: 'app.user.id', value: auth.id.toString());
    }

    return auth;
  }

  Future<User> getUser({required int id}) async {
    dynamic response = await RequestUtils.authenticatedGetRequest(
      _getUser(id),
    );

    return User.fromJSON(response['data']);
  }

  Future<bool> reauthUser() async {
    String? username = await storage.read(key: 'app.user.email');
    String? password = await storage.read(key: 'app.user.password');

    if (username != null && password != null) {
      Authenticate auth = await doAuthenticate(email: username, password: password);

      if (auth.token != null) {
        return true;
      }
    }

    return false;
  }
}