import 'dart:convert';
import 'package:hackaton_momo/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  late User _user;
  late String token;

  bool get authenticated => _isLoggedIn;
  User get user => _user;
  final String _url = 'api-hackaton.gomapguide.com';
  late SharedPreferences prefs;

  _getToken() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  login(Map creds) async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/login');
    var response =
        await http.post(url, body: jsonEncode(creds), headers: _setHeaders());
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      _user = User.fromJson(jsonResponse['data']['user']);
      token = jsonResponse['data']['token'];
      await prefs.setString('user', jsonEncode(_user));
      await prefs.setString('token', token);
      _isLoggedIn = true;
      notifyListeners();
    }
    return response;
  }

  logout() async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/logout');
    var response = await http.post(url, headers: _setHeaders());
    if (response.statusCode == 201) {
      await prefs.remove('token');
      await prefs.remove('user');
      _isLoggedIn = false;
      notifyListeners();
    }
    return response;
  }

  void register() {
    notifyListeners();
  }
}
