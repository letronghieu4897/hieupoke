import 'dart:convert';
import 'package:http/http.dart' as http;
import 'web_api.dart';

// 1
class WebApiImpl implements WebApi {
  final _host = 'https://pokeapi.co';
  final _path = '/api/v2/pokemon';

  final Map<String, String> _headers = {'Accept': 'application/json'};

  String getUrl({
    String host,
    String path,
  }) {
    return (host ?? _host) + (path ?? _path);
  }

  @override
  Future<Map<String, dynamic>> get({
    String host,
    String path,
  }) async {
    final uri = getUrl(host: host, path: path);
    print(uri);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  @override
  Future<Map<String, dynamic>> delete({
    String host,
    String path,
  }) async {
    final uri = getUrl(host: host, path: path);
    final results = await http.delete(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  @override
  Future<Map<String, dynamic>> post({
    String host,
    String path,
    Map data,
  }) async {
    final uri = getUrl(host: host, path: path);
    final results = await http.post(uri, headers: _headers, body: data);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  @override
  Future<Map<String, dynamic>> put({
    String host,
    String path,
    Map data,
  }) async {
    final uri = getUrl(host: host, path: path);
    final results = await http.put(uri, headers: _headers, body: data);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }
}
