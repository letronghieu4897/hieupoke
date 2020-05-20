import 'package:flutter/cupertino.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_detail_service.dart';
import '../models/pokemon_detail.dart';

class LoadPokemonDetailViewModel extends ChangeNotifier {
  PokemonDetail pokemon;

  PokemonDetailService _pokemonDetailService =
      serviceLocator<PokemonDetailService>();

  void loadData(String path) async {
    final data = await _pokemonDetailService.loadPokemonDetail(path);
    PokemonDetail pokemonRes = PokemonDetail.fromJson(data);
    pokemon = pokemonRes;
    notifyListeners();
  }
}
