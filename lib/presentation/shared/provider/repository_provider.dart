// ignore_for_file: public_member_api_docs, sort_constructors_first
// ES UNA CAPA PUENTE

// De manera mas tecnica podemos decir que repositoryProvider es:
// - Una clase que se encarga de INSTANCEAR  todos y cada uno de mis repositorios.
// - Y LOS ENCAPSUÑA EN UNA UNICA VARAIBLE que yo puedo usar en mi controllador,
//   para acceder a los repositorios que yo necesito. Sin necesidad de tener que instanciar
//   el repositorio en el controlador.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:masterclass_rick_and_morty_app/data/api/auth_api.dart';
import 'package:masterclass_rick_and_morty_app/data/api/characters_api.dart';
import 'package:masterclass_rick_and_morty_app/data/repository/auth_repository.dart';
import 'package:masterclass_rick_and_morty_app/data/repository/characters_repository.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

// PASO 2: Encapsulas todos los repositorios en una unica variable.
// Usando Provider (Un provedor de riverpod el cual te permite envia instancias, y parametros
// en general hacia otro provider de riverpod).
final repositoryProvider = Provider<RepositoryProvider>((ref) {
  final authRepository = AuthRepository(api: AuthApi());
  final charactersRepository =
      CharactersRepository(charactersApi: CharactersApi());

  return RepositoryProvider(
      authRepository: authRepository,
      charactersRepository: charactersRepository);
});

// PASO 1: Clase que genera cada una de las instacias de cada uno de los repositorios
class RepositoryProvider {
  final AuthRepository authRepository;
  final CharactersRepository charactersRepository;

  RepositoryProvider({
    required this.authRepository,
    required this.charactersRepository,
  }) {
    logger.d("SE ESTA EJECUTANDO MI CONTRUCTOR");
  }
}
