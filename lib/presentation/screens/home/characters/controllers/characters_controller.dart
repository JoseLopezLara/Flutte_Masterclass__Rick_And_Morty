// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:masterclass_rick_and_morty_app/data/models/pagination.dart';
import 'package:masterclass_rick_and_morty_app/data/models/rick_and_morty_character.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/provider/repository_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class CharactersController extends ChangeNotifier {
  // - PASO 1: Mi sección de propiedades (Variables, objetos, repositios, etc)
  final RepositoryProvider repositoryProvider;
  final String token;

  late UiState _pageState;
  late UiState _paginationState;
  Pagination? _pagination;
  late List<RickAndMortyCharacter> _characters;

  CharactersController(
      {required this.repositoryProvider, required this.token}) {
    _pageState = UiState.data;
    _paginationState = UiState.data;
    _characters = [];
  }

  // - PASO 2: Tu seccion de getters
  UiState get pageState => _pageState;
  UiState get paginationState => _paginationState;
  List<RickAndMortyCharacter> get characters => _characters;
  Pagination? get pagination => _pagination;

  // - PASO 3: Tu sección de funciones que efectuan la logica de tu frontend
  Future<void> getAll() async {
    final url = _pagination?.next;

    if (url == null) {
      _pageState = UiState.loading;
    } else {
      _paginationState = UiState.loading;
    }

    notifyListeners();

    try {
      final charactersList =
          await repositoryProvider.charactersRepository.getAll(token, url);

      if (url == null) {
        _characters = charactersList.results;
      } else {
        _characters.addAll(charactersList.results);
      }

      _pagination = charactersList.info;
      logger.i("CharactersController: $charactersList");
    } catch (err) {
      logger.e("CharactersController: $err");
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
