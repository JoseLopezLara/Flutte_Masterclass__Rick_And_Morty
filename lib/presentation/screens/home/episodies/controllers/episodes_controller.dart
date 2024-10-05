import 'package:flutter/material.dart';
import 'package:masterclass_rick_and_morty_app/data/models/pagination.dart';
import 'package:masterclass_rick_and_morty_app/data/models/rick_and_morty_episodes.dart'; 
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/provider/repository_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class EpisodesController extends ChangeNotifier {
  final RepositoryProvider repositoryProvider;
  final String token;

  late UiState _pageState;
  late UiState _paginationState;
  Pagination? _pagination;
  late List<RickAndMortyEpisode> _episodes;

  EpisodesController({
    required this.repositoryProvider,
    required this.token,
  }) {
    _pageState = UiState.data;
    _paginationState = UiState.data;
    _episodes = [];
  }

  UiState get pageState => _pageState;
  UiState get paginationState => _paginationState;
  List<RickAndMortyEpisode> get episodes => _episodes; 
  Pagination? get pagination => _pagination;

  Future<void> getAll() async {
    final url = _pagination?.next;

    if (url == null) {
      _pageState = UiState.loading;
    } else {
      _paginationState = UiState.loading;
    }

    notifyListeners();

    try {
      final episodesList =
          await repositoryProvider.episodesRepository.getAll(token, url);

      if (url == null) {
        _episodes = episodesList.results; 
      } else {
        _episodes.addAll(episodesList.results); 
      }

      _pagination = episodesList.info;
      logger.i("EpisodesController: $episodesList");
    } catch (err) {
      logger.e("EpisodesController: $err");
    } finally {
      if (url == null) {
        _pageState = UiState.data;
      } else {
        _paginationState = UiState.data;
      }
      notifyListeners();
    }
  }
}
