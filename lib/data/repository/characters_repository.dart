// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:masterclass_rick_and_morty_app/data/api/characters_api.dart';
import 'package:masterclass_rick_and_morty_app/data/models/character_list.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class CharactersRepository {
  final CharactersApi charactersApi;
  CharactersRepository({
    required this.charactersApi,
  });

  Future<CharacterList> getAll(String token, [String? url]) async {
    final jsonMap = await charactersApi.getAll(token, url);

    logger.d("CharactersRepository (Debugging): $jsonMap");

    logger.i("CharactersRepository: ${CharacterList.fromMap(jsonMap)}");

    return CharacterList.fromMap(jsonMap);
  }
}
