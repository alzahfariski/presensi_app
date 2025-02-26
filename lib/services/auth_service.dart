import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presensi_app/models/user_model.dart';

class AuthService {
  String baseUrl = "http://127.0.0.1:8000/";

  Future<UserModel> login({
    String? username,
    String? password,
  }) async {
    var url = '$baseUrl/account/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['token']}';

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> getUserData(String token) async {
    var url = '$baseUrl/user';
    var headers = {'Authorization': token};

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['user'];
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('Gagal Mengambil Data Pengguna');
    }
  }

  Future<UserModel> fetchData(String token) async {
    try {
      var url = '$baseUrl/user';
      var headers = {'Authorization': token};

      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        if (data != null && data['user'] != null) {
          UserModel user = UserModel.fromJson(data['user']);
          user.token = 'Bearer ${data['token']}';
          return user;
        } else {
          throw Exception('User data is empty or null');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
