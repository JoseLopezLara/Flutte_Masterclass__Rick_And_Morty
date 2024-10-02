// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:masterclass_rick_and_morty_app/data/models/user.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/provider/repository_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class LoginController extends ChangeNotifier {
// - PASO 1: Mi sección de propiedades (Variables, objetos, repositios, etc)
  RepositoryProvider repositoryProvider;
  late UiState _uiState;
  late User _user;

  LoginController({
    required this.repositoryProvider,
  }) {
    _uiState = UiState.data;
  }

// - PASO 2: Tu seccion de getters
  User get user => _user;
  UiState get uiState => _uiState;

// - PASO 3: Tu sección de funciones que efectuan la logica de tu frontend
  Future<void> login(String username, String password) async {
    // - PASO 3.1 Logica de la función:
    _uiState = UiState.loading;
    // - PASO 3.2: Notificar cambio realizado
    notifyListeners();

    // - PASO 3.1 Logica de la función:
    try {
      logger.d('ENTRO A TRY: $username $password');
      _user = await repositoryProvider.authRepository.login(username, password);

      logger.d("IF SUCESSFUL: $_user");
    } catch (error) {
      logger.e("Login Controller: $error");
      _uiState = UiState.error;
      notifyListeners();
      rethrow;
    } finally {
      _uiState = UiState.data;
      notifyListeners();
    }
  }
}
