import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:saxovat/models/charity_model.dart';
import '../models/user_model.dart';

/// as - bu kutubxonani bitta nom bilan o'zgaruvchi kabi ishlatish uchun foydalanadi
/// hide - bu kutubxona yoki file ichidagi biz belgilagan elementni kutubxona chaqirilgan joyda ko'rsatmaydi, yashiradi.
/// show - bu kutubxona yoki file ichidagi biz belgilagan elementnigina chaqirilgan joyda ishlatishga ruxsat beradi

sealed class Network {
  static const String baseUrl = "659e70fe47ae28b0bd35d81c.mockapi.io";

  static const apiUsers = "/api/v1/user";
  static const apiCharity = "/api/v1/charity";
  static const apiMainCharity = "/api/v1/maincharity";

  static const Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<String?> methodGet(
      {required String api,
      Object? id,
      Map<String, String> headers = headers,
      String baseUrl = baseUrl}) async {
    try {
      Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // return response.body;
        return utf8.decoder.convert(response.bodyBytes);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<bool> methodDelete(
      {required String api,
      required Object id,
      Map<String, String> headers = headers,
      String baseUrl = baseUrl}) async {
    try {
      Uri url = Uri.https(baseUrl, "/$api/$id");
      final response = await http.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return true;
      }else{
        debugPrint("Loyiha o'chirilmadi : ${response.statusCode}");
      }
      return false;

    } catch (e) {
      debugPrint(e.toString());
      return false;

    }
  }

  static Future<bool> methodPost(
      {required String api,
      Map<String, String> headers = headers,
      String baseUrl = baseUrl,
      required Map<String, Object?> data}) async {
    try {
      Uri url = Uri.https(baseUrl, api);

      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<void> methodPut(
      {required String api,
      required Object id,
      Map<String, String> headers = headers,
      String baseUrl = baseUrl,
      required Map<String, Object?> data}) async {
    try {
      Uri url = Uri.https(baseUrl, "/$api/$id");
      final response = await http.put(
        url,
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static List<Charity> parseCharityList(String data) {
    final json = jsonDecode(data) as List;

    /// String => json(Map, List, ...)
    return json.map((item) => Charity.fromJson(item)).toList();

    /// json => object
  }

  static List<MainCharity> parseMainCharityList(String data) {
    final json = jsonDecode(data) as List;

    /// String => json(Map, List, ...)
    return json.map((item) => MainCharity.fromJson(item)).toList();

    /// json => object
  }

  static Charity parseCharity(String data) {
    final json = jsonDecode(data);
    final movie = Charity.fromJson(json);
    return movie;
  }

  static List<User> parseUserList(String data) {
    final json = jsonDecode(data) as List;

    /// String => json(Map, List, ...)
    return json.map((item) => User.fromJson(item)).toList();

    /// json => object (list)
  }

  static User parseUser(String data) {
    final json = jsonDecode(data);

    /// String => json(Map, List, ...)
    final user = User.fromJson(json);
    return user;

    /// json => object
  }
}
