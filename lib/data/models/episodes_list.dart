import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:masterclass_rick_and_morty_app/data/models/pagination.dart';
import 'package:masterclass_rick_and_morty_app/data/models/rick_and_morty_episodes.dart'; 

class EpisodeList {
  final Pagination info;
  final List<RickAndMortyEpisode> results;

  EpisodeList({
    required this.info,
    required this.results,
  });

  EpisodeList copyWith({
    Pagination? info,
    List<RickAndMortyEpisode>? results,
  }) {
    return EpisodeList(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory EpisodeList.fromMap(Map<String, dynamic> map) {
    return EpisodeList(
      info: Pagination.fromMap(map['info'] as Map<String, dynamic>),
      results: List<RickAndMortyEpisode>.from(
        (map['results']).map<RickAndMortyEpisode>(
          (x) => RickAndMortyEpisode.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeList.fromJson(String source) =>
      EpisodeList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EpisodeList(info: $info, results: $results)';

  @override
  bool operator ==(covariant EpisodeList other) {
    if (identical(this, other)) return true;

    return other.info == info && listEquals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}
