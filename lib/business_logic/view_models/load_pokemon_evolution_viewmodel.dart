import 'package:flutter/foundation.dart';
import 'package:uichallenge/business_logic/models/pokemon_evolution.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_detail_service.dart';

class LoadPokemonEvolutionViewModel extends ChangeNotifier {
  PokemonEvolution pokemonEvolution;

  PokemonDetailService _pokemonDetailService =
      serviceLocator<PokemonDetailService>();

  void loadData(int id) async {
    String path = '/api/v2/evolution-chain/$id';

    final data = await _pokemonDetailService.loadPokemonEvolution(path);
    PokemonEvolution pokemonRes = PokemonEvolution.fromJson(data);
    pokemonEvolution = pokemonRes;
    notifyListeners();
  }
}
