import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list.g.dart';

@JsonSerializable()
class PokemonList extends Equatable {
  final String name;
  final String url;

  PokemonList({this.name, this.url});

  factory PokemonList.fromJson(Map<String, dynamic> json) =>
      _$PokemonListFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListToJson(this);

  @override
  List<Object> get props => [name, url];
}
