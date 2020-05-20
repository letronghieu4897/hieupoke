import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uichallenge/business_logic/models/pokemon_information_base.dart';

part 'pokemon_detail.g.dart';

@JsonSerializable()
class PokemonDetail extends Equatable {
  final List<AbilityList> abilities;
  @JsonKey(name: 'base_experience')
  final double baseExperience;
  final List<Form> forms;
  final double height;
  final double weight;
  final double id;
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @JsonKey(name: 'location_area_encounters')
  final String locationAreaEncounters;
  final String name;
  final int order;
  final Species species;
  final List<StatList> stats;
  final List<TypeList> types;

  PokemonDetail({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.height,
    this.weight,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.name,
    this.order,
    this.species,
    this.stats,
    this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailToJson(this);

  @override
  List<Object> get props => [
        abilities,
        baseExperience,
        forms,
        height,
        weight,
        id,
        isDefault,
        locationAreaEncounters,
        name,
        order,
        species,
        stats,
        types,
      ];
}

@JsonSerializable()
class Ability extends PokemonInformationBase {
  Ability({name, url}) : super(name: name, url: url);

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class AbilityList extends Equatable {
  final Ability ability;
  @JsonKey(name: 'is_hidden')
  final bool isHidden;
  final int slot;

  AbilityList({this.ability, this.isHidden, this.slot});

  factory AbilityList.fromJson(Map<String, dynamic> json) =>
      _$AbilityListFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityListToJson(this);

  @override
  List<Object> get props => [ability, isHidden, slot];
}

@JsonSerializable()
class Form extends PokemonInformationBase {
  Form({name, url}) : super(name: name, url: url);

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);

  Map<String, dynamic> toJson() => _$FormToJson(this);
}

@JsonSerializable()
class Version extends PokemonInformationBase {
  Version({name, url}) : super(name: name, url: url);

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);

  Map<String, dynamic> toJson() => _$VersionToJson(this);
}

@JsonSerializable()
class Species extends PokemonInformationBase {
  Species({name, url}) : super(name: name, url: url);

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesToJson(this);
}

@JsonSerializable()
class Stat extends PokemonInformationBase {
  Stat({name, url}) : super(name: name, url: url);

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}

@JsonSerializable()
class StatList extends Equatable {
  @JsonKey(name: 'base_stat')
  final int baseStat;
  final int effort;
  final Stat stat;

  StatList({this.baseStat, this.effort, this.stat});

  factory StatList.fromJson(Map<String, dynamic> json) =>
      _$StatListFromJson(json);

  Map<String, dynamic> toJson() => _$StatListToJson(this);

  @override
  List<Object> get props => [baseStat, effort, stat];
}

@JsonSerializable()
class Type extends PokemonInformationBase {
  Type({name, url}) : super(name: name, url: url);

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class TypeList extends Equatable {
  final int slot;
  final Type type;

  factory TypeList.fromJson(Map<String, dynamic> json) =>
      _$TypeListFromJson(json);

  Map<String, dynamic> toJson() => _$TypeListToJson(this);

  TypeList({this.slot, this.type});

  @override
  List<Object> get props => [slot, type];
}
