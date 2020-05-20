import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_information_base.g.dart';

@JsonSerializable()
class PokemonInformationBase extends Equatable {
  final String name;
  final String url;

  PokemonInformationBase({this.name, this.url});

  factory PokemonInformationBase.fromJson(Map<String, dynamic> json) =>
      _$PokemonInformationBaseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonInformationBaseToJson(this);

  @override
  List<Object> get props => [name, url];
}
