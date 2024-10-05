import 'dart:convert';

class RickAndMortyEpisode {
  final int id;
  final String name;
  final String airDate;
  final String episode;

  RickAndMortyEpisode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  RickAndMortyEpisode copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episode,
  }) {
    return RickAndMortyEpisode(
      id: id ?? this.id,
      name: name ?? this.name,
      airDate: airDate ?? this.airDate,
      episode: episode ?? this.episode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode': episode,
    };
  }

  factory RickAndMortyEpisode.fromMap(Map<String, dynamic> map) {
    return RickAndMortyEpisode(
      id: map['id'] as int,
      name: map['name'] as String,
      airDate: map['air_date'] as String,
      episode: map['episode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RickAndMortyEpisode.fromJson(String source) =>
      RickAndMortyEpisode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RickAndMortyEpisode(id: $id, name: $name, airDate: $airDate, episode: $episode)';
  }
}
