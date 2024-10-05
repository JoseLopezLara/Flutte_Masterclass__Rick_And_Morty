import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class EpisodesApi {
  Future<Map<String, dynamic>> getAll(String token, [String? url]) async {
    final uri = Uri.parse(url ?? 'https://rickandmortyapi.com/api/episode');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);
    final statusCode = response.statusCode;
    
    if (statusCode == 200) {
      logger.i('EpisodesApi: ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    }
    
    logger.e("EpisodesApi: Failed ${response.statusCode}");
    throw Exception("Bad Request");
  }
}
