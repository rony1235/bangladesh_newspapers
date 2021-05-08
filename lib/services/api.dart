import 'dart:async';
import 'dart:convert';

import 'package:bangladesh_newspapers/models/source.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Api {
  final String _baseUrl = "https://sportapi.e2rsoft.com/";

  Future<String> getArticles({
    @required String sources,
    @required int page,
    @required int pageSize,
  }) async {
    String url = Uri.encodeFull(_baseUrl + 'all/kolkata');
    try {
      http.Response response = await http.get(url, headers: _headers());
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception {}
    return null;
  }

  Future<List<Source>> getSources() async {
    String url = Uri.encodeFull(_baseUrl + 'sources');
    try {
      http.Response response = await http.get(url, headers: _headers());
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data != null && data["sources"] != null) {
          List<Source> sources = (data["sources"] as List<dynamic>)
              .map((source) => Source.fromJson(source))
              .toList();
          return sources;
        }
      }
    } on Exception {}
    return null;
  }

  Map<String, String> _headers() {
    return {
      "Accept": "application/json",
      "X-Api-Key": '8f3d4cf8dec24efd956c2042d2a1ec3c',
    };
  }
}
