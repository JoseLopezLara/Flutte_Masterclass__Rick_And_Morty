// [Depende de Subcapa “Data Source”] Repositories:
// Tine funciones que reciben parametros para ser enviados a nuestro endpoint o
// punto de acceso a nuestra base datos de nuestro de cliente http de nuestra subcapa DataSource.

// El cliente http de la capa datasource retorna un Map<String, Dynamic> y la capa
// repository es encargada de PARSEARLO A UN OBJETO DE UN TIPO DE NUESTRO MODELO

import 'dart:convert';

import 'package:masterclass_rick_and_morty_app/data/api/auth_api.dart';
import 'package:masterclass_rick_and_morty_app/data/models/user.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

class AuthRepository {
  final AuthApi api;

  // SI USO LLAVES ME NO ME IMPORTA LA POSICIÓN DE COMO ME ENVIAN LOS PARAMETROS
  // DESDE LA CLASE DONDE SE CREA LA INSTANCIA
  AuthRepository({
    required this.api,
  });

  // SI NO USO LLAVES SI ME IMPORTA LA POSICIÓN DE COMO ME ENVIAL LOS PARAMETROS
  // DESDE LA CLASE DONDE SE CREA LA INSTANCIA. ADEMAS, SI NO USO LLAVES ES PORQUE
  // ESTOY DICIENDO QUE LOS CAMPOS EN EL CONTRICTOR SON OBLIGATORIOS (ES DECIR REQUERIDOS)
  // AuthRepository(
  //   this.api,
  // );

  Future<User> login(String username, String password) async {
    //esta zona
    final body = jsonEncode({'username': username, 'password': password});
    logger.i("Auth Repositiry (Parametros recibidos): $username - $password");

    final user = await api.login(body);
    logger.i(
        "Auth Repositiry (get Auth API request): ${User.fromMap(user).toString()} ");

    return User.fromMap(user);
  }
}
