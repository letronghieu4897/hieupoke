// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_evolution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonEvolution _$PokemonEvolutionFromJson(Map<String, dynamic> json) {
  return PokemonEvolution(
    id: json['id'] as int,
    chain: json['chain'] == null
        ? null
        : Chain.fromJson(json['chain'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonEvolutionToJson(PokemonEvolution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chain': instance.chain,
    };

EvolvesTo _$EvolvesToFromJson(Map<String, dynamic> json) {
  return EvolvesTo(
    evolutionDetails: (json['evolution_details'] as List)
        ?.map((e) => e == null
            ? null
            : EvolutionDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    evolvesTo: (json['evolves_to'] as List)
        ?.map((e) =>
            e == null ? null : EvolvesTo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isBaby: json['is_baby'] as bool,
    species: json['species'] == null
        ? null
        : Species.fromJson(json['species'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EvolvesToToJson(EvolvesTo instance) => <String, dynamic>{
      'evolution_details': instance.evolutionDetails,
      'evolves_to': instance.evolvesTo,
      'is_baby': instance.isBaby,
      'species': instance.species,
    };

EvolutionDetails _$EvolutionDetailsFromJson(Map<String, dynamic> json) {
  return EvolutionDetails(
    minLevel: json['min_level'] as int,
  );
}

Map<String, dynamic> _$EvolutionDetailsToJson(EvolutionDetails instance) =>
    <String, dynamic>{
      'min_level': instance.minLevel,
    };

Chain _$ChainFromJson(Map<String, dynamic> json) {
  return Chain(
    evolutionDetails: (json['evolution_details'] as List)
        ?.map((e) => e == null
            ? null
            : EvolutionDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    evolvesTo: (json['evolves_to'] as List)
        ?.map((e) =>
            e == null ? null : EvolvesTo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isBaby: json['is_baby'] as bool,
    species: json['species'] == null
        ? null
        : Species.fromJson(json['species'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChainToJson(Chain instance) => <String, dynamic>{
      'evolution_details': instance.evolutionDetails,
      'evolves_to': instance.evolvesTo,
      'is_baby': instance.isBaby,
      'species': instance.species,
    };
