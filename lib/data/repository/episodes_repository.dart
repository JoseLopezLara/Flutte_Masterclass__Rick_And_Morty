import 'package:masterclass_rick_and_morty_app/data/api/episodes_api.dart'; 
import 'package:masterclass_rick_and_morty_app/data/models/episodes_list.dart'; 
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class EpisodesRepository {
  final EpisodesApi episodesApi;

  EpisodesRepository({
    required this.episodesApi,
  });

  Future<EpisodeList> getAll(String token, [String? url]) async {
    final jsonMap = await episodesApi.getAll(token, url);

    logger.d("EpisodesRepository (Debugging): $jsonMap");

    logger.i("EpisodesRepository: ${EpisodeList.fromMap(jsonMap)}");

    return EpisodeList.fromMap(jsonMap);
  }
}
