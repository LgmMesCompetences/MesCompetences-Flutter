import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mes_competences/service/mescompetences_api.dart';

class RequestUtils {
  static Future<dynamic> getRequest(String url, {Map<String, String>? headers}) async {
    final http.Response response = await http.get(Uri.parse(url), headers: headers);

    try {
      return {'code': response.statusCode, 'data': json.decode(response.body)};
    } catch (e) {
      return {'code': response.statusCode};
    }
  }

  static Future<Map<String, dynamic>> postRequest(String url, {Map<String, String>? headers, Object? body}) async {
    final http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);

    try {
      return {'code': response.statusCode, 'data': json.decode(response.body)};
    } catch (e) {
      return {'code': response.statusCode};
    }
  }

  static Future<dynamic> authenticatedGetRequest(String url, {Map<String, String>? headers}) async {
    if ((headers != null && !headers.containsKey('Authorization')) || headers == null) {
      String? token = await _getToken();
      if (token != null) {
        headers ??= {};
        headers['Authorization'] = 'Bearer ' + token;
      }
      else {
        return false;
      }
    }

    inspect(headers);

    var response = await getRequest(url, headers: headers);

    inspect(response);

    if (response['code'] == 401) {
      bool reauth = await MesCompetencesApi().reauthUser();

      if (reauth) {
        authenticatedGetRequest(url, headers: headers);
      }
      else {
        return false;
      } 
    }
    else {
      return response;
    }
  }

  static Future<dynamic> authenticatedPostRequest(String url, {Map<String, String>? headers, Object? body}) async {
    if ((headers != null && !headers.containsKey('Authorization')) || headers == null) {
      String? token = await _getToken();
      if (token != null) {
        headers ??= {};
        headers['Authorization'] = 'Bearer ' + token;
      }
      else {
        return false;
      }
    }

    var response = await postRequest(url, headers: headers, body: body);

    if (response['code'] == 401) {
      bool reauth = await MesCompetencesApi().reauthUser();

      if (reauth) {
        authenticatedPostRequest(url, headers: headers, body: body);
      }
      else {
        return false;
      } 
    }
    else {
      return response;
    }
  }

  static Future<String?> _getToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return storage.read(key: 'app.user.token');
  }
}
