// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetail _$PokemonDetailFromJson(Map<String, dynamic> json) {
  return PokemonDetail(
    abilities: (json['abilities'] as List)
        ?.map((e) =>
            e == null ? null : AbilityList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    baseExperience: (json['base_experience'] as num)?.toDouble(),
    forms: (json['forms'] as List)
        ?.map(
            (e) => e == null ? null : Form.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    height: (json['height'] as num)?.toDouble(),
    weight: (json['weight'] as num)?.toDouble(),
    id: (json['id'] as num)?.toDouble(),
    isDefault: json['is_default'] as bool,
    locationAreaEncounters: json['location_area_encounters'] as String,
    name: json['name'] as String,
    order: json['order'] as int,
    species: json['species'] == null
        ? null
        : Species.fromJson(json['species'] as Map<String, dynamic>),
    sprites: json['sprites'] == null
        ? null
        : Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
    stats: (json['stats'] as List)
        ?.map((e) =>
            e == null ? null : StatList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    types: (json['types'] as List)
        ?.map((e) =>
            e == null ? null : TypeList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PokemonDetailToJson(PokemonDetail instance) =>
    <String, dynamic>{
      'abilities': instance.abilities,
      'base_experience': instance.baseExperience,
      'forms': instance.forms,
      'height': instance.height,
      'weight': instance.weight,
      'id': instance.id,
      'is_default': instance.isDefault,
      'location_area_encounters': instance.locationAreaEncounters,
      'name': instance.name,
      'order': instance.order,
      'species': instance.species,
      'sprites': instance.sprites,
      'stats': instance.stats,
      'types': instance.types,
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) {
  return Ability(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

AbilityList _$AbilityListFromJson(Map<String, dynamic> json) {
  return AbilityList(
    ability: json['ability'] == null
        ? null
        : Ability.fromJson(json['ability'] as Map<String, dynamic>),
    isHidden: json['is_hidden'] as bool,
    slot: json['slot'] as int,
  );
}

Map<String, dynamic> _$AbilityListToJson(AbilityList instance) =>
    <String, dynamic>{
      'ability': instance.ability,
      'is_hidden': instance.isHidden,
      'slot': instance.slot,
    };

Form _$FormFromJson(Map<String, dynamic> json) {
  return Form(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Version _$VersionFromJson(Map<String, dynamic> json) {
  return Version(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Species _$SpeciesFromJson(Map<String, dynamic> json) {
  return Species(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$SpeciesToJson(Species instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Stat _$StatFromJson(Map<String, dynamic> json) {
  return Stat(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

StatList _$StatListFromJson(Map<String, dynamic> json) {
  return StatList(
    baseStat: json['base_stat'] as int,
    effort: json['effort'] as int,
    stat: json['stat'] == null
        ? null
        : Stat.fromJson(json['stat'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatListToJson(StatList instance) => <String, dynamic>{
      'base_stat': instance.baseStat,
      'effort': instance.effort,
      'stat': instance.stat,
    };

Type _$TypeFromJson(Map<String, dynamic> json) {
  return Type(
    name: json['name'],
    url: json['url'],
  );
}

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

TypeList _$TypeListFromJson(Map<String, dynamic> json) {
  return TypeList(
    slot: json['slot'] as int,
    type: json['type'] == null
        ? null
        : Type.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TypeListToJson(TypeList instance) => <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

Sprites _$SpritesFromJson(Map<String, dynamic> json) {
  return Sprites(
    backDefault: json['back_default'] as String,
    backFemale: json['back_female'] as String,
    backShiny: json['back_shiny'] as String,
    backShinyFemale: json['back_shiny_female'] as String,
    frontDefault: json['front_default'] as String,
    frontFemale: json['front_female'] as String,
    frontShiny: json['front_shiny'] as String,
    frontShinyFemale: json['front_shiny_female'] as String,
  );
}

Map<String, dynamic> _$SpritesToJson(Sprites instance) => <String, dynamic>{
      'back_default': instance.backDefault,
      'back_female': instance.backFemale,
      'back_shiny': instance.backShiny,
      'back_shiny_female': instance.backShinyFemale,
      'front_default': instance.frontDefault,
      'front_female': instance.frontFemale,
      'front_shiny': instance.frontShiny,
      'front_shiny_female': instance.frontShinyFemale,
    };
