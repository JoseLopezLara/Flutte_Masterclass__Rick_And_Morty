import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masterclass_rick_and_morty_app/data/models/rick_and_morty_character.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/characters/providers/character_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';
import 'package:masterclass_rick_and_morty_app/presentation/styles/colors.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  const CharacterScreen({super.key});

  @override
  ConsumerState<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends ConsumerState<CharacterScreen>
    with AutomaticKeepAliveClientMixin {
  //LOGICA DEL WIDGET
  //-------------------------------------------
  late ScrollController scrollController;
  bool _cantFetch = true;

  //Init state se manda a llamar en el primer renderiza de mi screen
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    final charactersState = ref.read(charactersProvider);
    //WidgetsBinding se manda a llamr cuando termina de
    //renderizarse el ultimo frame de mi screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (charactersState.characters.isEmpty) {
        charactersState.getAll();
      }
    });

    scrollController.addListener(() async {
      final position = scrollController.offset;
      final maxExtend = scrollController.position.maxScrollExtent;

      const sensibility = 0.8;

      if (position > maxExtend * sensibility && _cantFetch) {
        _cantFetch = false;
        try {
          charactersState.getAll();
        } catch (err) {
          logger.e("_CharacterScreenState $err");
        } finally {
          _cantFetch = true;
        }
      }
    });
  }

  Color getLifeStatusColor(RickAndMortyCharacter character) {
    final status = character.status;
    if (status == 'Alive') {
      return Colors.greenAccent;
    } else if (status == "Dead") {
      return Colors.redAccent;
    }
    return Colors.yellowAccent;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //END LOGICA DEL WIDGET
  //-------------------------------------------

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final characterState = ref.watch(charactersProvider);
    final characters = characterState.characters;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        final character = characters[index];
                        // SIMEPRE QUE NOSOTROS TRABAJEMOS CON CARDS O ELEMENTOS DENTRO DE UNA
                        // LISTVIEW, ES IMPORTANTE USAR UN IDENTIFADOR EN CADA CARD, ESTO ES PARA UN
                        // MEJOR MANEJO INTERNO DE LA LISTA Y EVITAR ERRORES.
                        return Container(
                          key: Key(character.id.toString()),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 6),
                          child: Card(
                            color: lightColorScheme.primaryContainer,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                  color: lightColorScheme.primaryContainer),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.0),
                                      child: Image.network(character.image),
                                    )),
                                const SizedBox(width: 10),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          character.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: lightColorScheme
                                                  .onPrimaryContainer),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,
                                                color: getLifeStatusColor(
                                                    character)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              character.status,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: lightColorScheme
                                                      .onPrimaryContainer),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Last Known Location: ${character.location.name}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: lightColorScheme
                                                  .onPrimaryContainer),
                                        ),
                                        Text(
                                          "Firs Appearance: ${character.origin.name}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: lightColorScheme
                                                  .onPrimaryContainer),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      })),
              if (characterState.paginationState == UiState.loading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
          if (characterState.pageState == UiState.loading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
