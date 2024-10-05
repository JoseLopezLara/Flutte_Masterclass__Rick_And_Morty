// ignore_for_file: public_member_api_docs, sort_constructors_first
// ES UNA CAPA PUENTE

// De manera más técnica, podemos decir que repositoryProvider es:
// - Una clase que se encarga de INSTANCEAR todos y cada uno de mis repositorios.
// - Y LOS ENCAPSUÑA EN UNA ÚNICA VARIABLE que yo puedo usar en mi controlador,
//   para acceder a los repositorios que yo necesito, sin necesidad de tener que instanciar
//   el repositorio en el controlador.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:masterclass_rick_and_morty_app/data/api/auth_api.dart';
import 'package:masterclass_rick_and_morty_app/data/api/characters_api.dart';
import 'package:masterclass_rick_and_morty_app/data/api/episodes_api.dart'; // Asegúrate de tener esta importación
import 'package:masterclass_rick_and_morty_app/data/repository/auth_repository.dart';
import 'package:masterclass_rick_and_morty_app/data/repository/characters_repository.dart';
import 'package:masterclass_rick_and_morty_app/data/repository/episodes_repository.dart'; // Asegúrate de tener esta importación
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

// PASO 2: Encapsulas todos los repositorios en una única variable.
// Usando Provider (Un proveedor de riverpod que te permite enviar instancias y parámetros
// en general hacia otro provider de riverpod).
final repositoryProvider = Provider<RepositoryProvider>((ref) {
  final authRepository = AuthRepository(api: AuthApi());
  final charactersRepository = CharactersRepository(charactersApi: CharactersApi());
  final episodesRepository = EpisodesRepository(episodesApi: EpisodesApi()); 

  return RepositoryProvider(
    authRepository: authRepository,
    charactersRepository: charactersRepository,
    episodesRepository: episodesRepository, 
  );
});

// PASO 1: Clase que genera cada una de las instancias de cada uno de los repositorios
class RepositoryProvider {
  final AuthRepository authRepository;
  final CharactersRepository charactersRepository;
  final EpisodesRepository episodesRepository; 

  RepositoryProvider({
    required this.authRepository,
    required this.charactersRepository,
    required this.episodesRepository,
  }) {
    logger.d("SE ESTÁ EJECUTANDO MI CONSTRUCTOR");
  }
}
