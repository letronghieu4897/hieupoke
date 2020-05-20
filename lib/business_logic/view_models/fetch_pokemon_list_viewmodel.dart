import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uichallenge/business_logic/models/pokemon_list.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_list_service.dart';

class FetchPokemonListViewModel extends ChangeNotifier {
  List<PokemonList> pokemons = [];
  int count;
  String next;
  String previous;

  PokemonListService _pokemonListService = serviceLocator<PokemonListService>();

  void loadData({bool isRefresh = false, Completer completer}) async {
    var data;
    if (!isRefresh) {
      if (next != null) {
        String path = '${Uri.parse(next).path}?${Uri.parse(next).query}';
        data = await _pokemonListService.fetchPokemonList(path: path);
      } else {
        data = await _pokemonListService.fetchPokemonList();
      }
    } else {
      pokemons = [];
      data = await _pokemonListService.fetchPokemonList();
    }
    count = data['count'];
    next = data['next'];
    previous = data['previous'];
    final jsonMapData = data['results'] as List;
    List<PokemonList> pokemonsRes =
        jsonMapData.map((item) => PokemonList.fromJson(item)).toList() ?? [];
    pokemons += pokemonsRes;

    completer?.complete();
    notifyListeners();
  }
}
