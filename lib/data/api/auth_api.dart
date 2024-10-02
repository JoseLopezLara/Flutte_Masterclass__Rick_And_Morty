// [NO DEPENDE DE NADIE]  Data sources:
// Es la subcapa que tiene nuestro endpoint consumido desde nuestro clinte http.
// (Esta subcapa importa la libreria de nuestro cliente http).

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class AuthApi {
  Future<Map<String, dynamic>> login(String body) async {
    const url = 'https://dummyjson.com/auth/login';
    final uri = Uri.parse(url);

    try {
      final response = await http
          .post(uri, body: body, headers: {'Content-Type': 'application/json'});
      final statusCode = response.statusCode;

      if (statusCode == HttpStatus.ok) {
        logger.i("Auth API: ${jsonDecode(response.body)}");
        return jsonDecode(response.body);
      }

      throw Exception('$statusCode: ${response.reasonPhrase}');
    } catch (err) {
      logger.e("Auth API: $err");
      throw Exception(err);
    }
  }
}
