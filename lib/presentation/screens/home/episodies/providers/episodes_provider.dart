import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/episodies/controllers/episodes_controller.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/login/providers/login_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/provider/repository_provider.dart';

final episodesProvider = ChangeNotifierProvider((ref) => EpisodesController(
    repositoryProvider: ref.read(repositoryProvider),
    token: ref.read(loginProvider).user.accessToken));
