// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:masterclass_rick_and_morty_app/data/models/pagination.dart';
import 'package:masterclass_rick_and_morty_app/data/models/rick_and_morty_character.dart';

class CharacterList {
  final Pagination info;
  final List<RickAndMortyCharacter> results;
  CharacterList({
    required this.info,
    required this.results,
  });

  CharacterList copyWith({
    Pagination? info,
    List<RickAndMortyCharacter>? results,
  }) {
    return CharacterList(
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

  factory CharacterList.fromMap(Map<String, dynamic> map) {
    return CharacterList(
      info: Pagination.fromMap(map['info'] as Map<String, dynamic>),
      results: List<RickAndMortyCharacter>.from(
        (map['results']).map<RickAndMortyCharacter>(
          (x) => RickAndMortyCharacter.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterList.fromJson(String source) =>
      CharacterList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CharacterList(info: $info, results: $results)';

  @override
  bool operator ==(covariant CharacterList other) {
    if (identical(this, other)) return true;

    return other.info == info && listEquals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}
