import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'pokemon_detail.dart';

part 'pokemon_evolution.g.dart';

@JsonSerializable()
class PokemonEvolution extends Equatable {
  final int id;
  final Chain chain;

  PokemonEvolution({this.id, this.chain});

  factory PokemonEvolution.fromJson(Map<String, dynamic> json) =>
      _$PokemonEvolutionFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonEvolutionToJson(this);

  @override
  List<Object> get props => [id, chain];
}

@JsonSerializable()
class EvolvesTo extends Equatable {
  @JsonKey(name: 'evolution_details')
  final List<EvolutionDetails> evolutionDetails;
  @JsonKey(name: 'evolves_to')
  final List<EvolvesTo> evolvesTo;
  @JsonKey(name: 'is_baby')
  final bool isBaby;
  final Species species;

  EvolvesTo({this.evolutionDetails, this.evolvesTo, this.isBaby, this.species});

  factory EvolvesTo.fromJson(Map<String, dynamic> json) =>
      _$EvolvesToFromJson(json);

  Map<String, dynamic> toJson() => _$EvolvesToToJson(this);

  @override
  List<Object> get props => [evolutionDetails, evolvesTo, isBaby, species];
}

@JsonSerializable()
class EvolutionDetails extends Equatable {
  @JsonKey(name: 'min_level')
  final int minLevel;

  EvolutionDetails({this.minLevel});

  factory EvolutionDetails.fromJson(Map<String, dynamic> json) =>
      _$EvolutionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$EvolutionDetailsToJson(this);

  @override
  List<Object> get props => [minLevel];
}

@JsonSerializable()
class Chain extends Equatable {
  @JsonKey(name: 'evolution_details')
  final List<EvolutionDetails> evolutionDetails;
  @JsonKey(name: 'evolves_to')
  final List<EvolvesTo> evolvesTo;
  @JsonKey(name: 'is_baby')
  final bool isBaby;
  final Species species;

  Chain({this.evolutionDetails, this.evolvesTo, this.isBaby, this.species});

  factory Chain.fromJson(Map<String, dynamic> json) => _$ChainFromJson(json);

  Map<String, dynamic> toJson() => _$ChainToJson(this);

  @override
  List<Object> get props => [evolutionDetails, evolvesTo, isBaby, species];
}
