// - PASO 4: Crear provedor
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/login/controllers/login_controller.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/provider/repository_provider.dart';

final loginProvider = ChangeNotifierProvider(
    (ref) => LoginController(repositoryProvider: ref.read(repositoryProvider)));
