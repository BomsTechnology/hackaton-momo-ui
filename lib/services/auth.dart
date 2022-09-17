import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hackaton_momo/services/dio.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get authenticated => _isLoggedIn;
  final String _url = 'api-hackaton.gomapguide.com';

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization' : 'Bearer $token'
      };

  void login(Map creds) async {
    try {
      print(creds);
      // Dio.Response response = await dio().post('/auth/login', data: creds);
      var url = Uri.https(_url, '/api/auth/login');
      var response =
          await http.post(url, body: jsonEncode(creds), headers: _setHeaders());
      print(response.body.toString());
      // _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    notifyListeners();
  }

  void register() {
    notifyListeners();
  }
}
