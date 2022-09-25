import 'dart:convert';
import 'package:hackaton_momo/models/user.dart';
import 'package:hackaton_momo/pages/loading_page.dart';
import 'package:hackaton_momo/pages/no_internet_page.dart';
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

  login({required Map<String, dynamic> creds}) async {
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

  verifyPass({required Map<String, dynamic> creds, bool save = true}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/verify-pass');
    var response =
        await http.post(url, body: jsonEncode(creds), headers: _setHeaders());
    if (response.statusCode == 201 && save) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      _user = User.fromJson(jsonResponse['data']['user']);
      await prefs.setString('user', jsonEncode(_user));
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

  setWithBiometric({required value}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/set-with-biometric/${user.phone}');
    var response = await http.post(url,
        body: jsonEncode({"value": value}), headers: _setHeaders());
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      _user = User.fromJson(jsonResponse['data']['user']);
      notifyListeners();
    }
    return response;
  }

  setNoPin({required Map<String, dynamic> data}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/set-no-pin/${user.phone}');
    var response =
        await http.post(url, body: jsonEncode(data), headers: _setHeaders());
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      _user = User.fromJson(jsonResponse['data']['user']);
      notifyListeners();
    }
    return response;
  }

  listingTransaction() async {
    await _getToken();
    var url = Uri.https(_url, '/api/transactions/${user.id}');
    var response = await http.get(url, headers: _setHeaders());
    return response;
  }

  collect({required Map<String, dynamic> data}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/transactions/collect');
    var response =
        await http.post(url, body: jsonEncode(data), headers: _setHeaders());
    return response;
  }

  deposit({required Map<String, dynamic> data}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/transactions/deposit');
    return await http.post(url, body: jsonEncode(data), headers: _setHeaders());
  }

  register({required Map<String, dynamic> creds}) async {
    await _getToken();
    var url = Uri.https(_url, '/api/auth/register');
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

  sendSms({required String phone, required bool resetPassword}) async {
    await _getToken();
    var url = Uri.https(_url, "/api/auth/send-verification-sms/$phone");
    return await http.post(url,
        body: jsonEncode({"reset_password": resetPassword}),
        headers: _setHeaders());
  }

  localLogin() async {
    await _getToken();
    token = prefs.getString('token')!;
    _user = User.fromJson(jsonDecode(prefs.getString('user')!));
    _isLoggedIn = true;
    notifyListeners();
  }

  verification({required String phone, required String code}) async {
    await _getToken();
    var url = Uri.https(_url, "/api/auth/verify-code/$phone");
    var response = await http.post(url,
        body: jsonEncode({"code": code}), headers: _setHeaders());

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
}
