import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:flutter_api/modele/book.dart';

class OpenLibrary {
  final _baseUrl = 'https://openlibrary.org/';
  String _isbn(String isbn) => _baseUrl + 'isbn/' + isbn + '.json';
  String _language(String language) =>
      _baseUrl + 'languages/' + language + '.json';

  Future<Map<String, dynamic>> request(String url) async {
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body;
  }

  Future<Book?> fetchBook(String isbn) async {
    Map<String, dynamic> json = await request(_isbn(isbn));

    if (json.containsKey('error')) return null;

    if (json.containsKey('languages')) {
      String lang2 =
          json['languages'][0]['key'].toString().replaceAll('/languages/', '');

      String? lang = await fetchLanguage(lang2);

      json['language'] = lang;
    } else {
      json['language'] = null;
    }

    return Book.fromJSON(json);
  }

  Future<String?> fetchLanguage(String language) async {
    Map<String, dynamic> json = await request(_language(language));

    if (json.containsKey('error')) return null;

    return json['name'];
  }
}
