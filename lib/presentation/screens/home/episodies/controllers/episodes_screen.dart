import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/episodies/providers/episodes_provider.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';
import 'package:masterclass_rick_and_morty_app/presentation/styles/colors.dart';

class EpisodeScreen extends ConsumerStatefulWidget {
  const EpisodeScreen({super.key});

  @override
  ConsumerState<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends ConsumerState<EpisodeScreen>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  bool _cantFetch = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    final episodeState = ref.read(episodesProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (episodeState.episodes.isEmpty) {
        episodeState.getAll();
      }
    });

    scrollController.addListener(() async {
      final position = scrollController.offset;
      final maxExtend = scrollController.position.maxScrollExtent;

      const sensibility = 0.8;

      if (position > maxExtend * sensibility && _cantFetch) {
        _cantFetch = false;
        try {
          episodeState.getAll();
        } catch (err) {
          logger.e("_EpisodeScreenState $err");
        } finally {
          _cantFetch = true;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final episodeState = ref.watch(episodesProvider);
    final episodes = episodeState.episodes;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    final episode = episodes[index];
                    return Container(
                      key: Key(episode.id.toString()),
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: Card(
                        color: lightColorScheme.primaryContainer,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: lightColorScheme.primaryContainer),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0), 
                                      child: Text(
                                        episode.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: lightColorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    Container(
                                      width: double.infinity, 
                                      color: Colors.deepPurple[900],
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "Episode: ${episode.episode}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white, 
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "Air Date: ${episode.airDate}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white, 
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.deepPurple[900]!, width: 3), 
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'lib/presentation/screens/home/episodies/assets/images/rm.png', 
                                    width: 100, 
                                    height: 100, 
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (episodeState.paginationState == UiState.loading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
          if (episodeState.pageState == UiState.loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
