import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:compartilhado/src/api/api.dart';

abstract class Cliente {
  final String _uriBase = 'http://localhost:5023/api/';
  final Map<String, String> headers;
  final String pathBase;

  static const Map<String, String> _headersPadrao = <String, String>{
    'content-type': 'application/json',
    'accept-encoding': 'gzip, deflate, br',
  };

  Cliente({
    this.pathBase = '',
    this.headers = _headersPadrao,
  });

  Future<dynamic> get({String? urn}) async {
    final http.Response response = await http.get(
      _uri(urn),
    );

    if (requestSucesso(response)) {
      return jsonDecode(response.body);
    } else {
      erro(response);
    }
  }

  Future<dynamic> post({
    String? urn,
    Map<String, dynamic>? body,
  }) async {
    final http.Response response = await http.post(
      _uri(urn),
      body: jsonEncode(body),
      headers: headers,
    );

    if (requestSucesso(response)) {
      final Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } else {
      erro(response);
    }
  }

  Future<void> delete({String? urn}) async {
    final http.Response response = await http.delete(
      _uri(urn),
    );

    if (requestSucesso(response)) {
      return;
    } else {
      erro(response);
    }
  }

  bool requestSucesso(http.Response response) {
    final int code = response.statusCode;

    if (code == 200 || code == 201) {
      return true;
    } else {
      return false;
    }
  }

  void erro(http.Response response) {
    final String msg = jsonDecode(response.body).toString();
    throw Exception(msg.toHttpErro());
  }

  Uri _uri(String? urn) => Uri.parse('$_uriBase$pathBase${urn ?? ''}');
}
