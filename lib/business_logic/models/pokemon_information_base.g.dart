// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_information_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonInformationBase _$PokemonInformationBaseFromJson(
    Map<String, dynamic> json) {
  return PokemonInformationBase(
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$PokemonInformationBaseToJson(
        PokemonInformationBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
