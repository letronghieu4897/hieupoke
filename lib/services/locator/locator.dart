import 'package:get_it/get_it.dart';
import 'package:uichallenge/business_logic/view_models/fetch_pokemon_list_viewmodel.dart';
import 'package:uichallenge/business_logic/view_models/load_pokemon_detail_viewmodel.dart';
import 'package:uichallenge/business_logic/view_models/load_pokemon_evolution_viewmodel.dart';
import 'package:uichallenge/services/pokemon/pokemon_detail_service.dart';
import 'package:uichallenge/services/pokemon/pokemon_list_service.dart';
import 'package:uichallenge/services/pokemon/pokemon_service.dart';
import 'package:uichallenge/services/web_api/web_api.dart';
import 'package:uichallenge/services/web_api/web_api_implement.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  /// Singleton
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());
  serviceLocator
      .registerLazySingleton<PokemonListService>(() => PokemonListService());
  serviceLocator.registerLazySingleton<PokemonService>(() => PokemonService());
  serviceLocator.registerLazySingleton<PokemonDetailService>(
      () => PokemonDetailService());

  /// Factory
  serviceLocator.registerFactory<LoadPokemonEvolutionViewModel>(
      () => LoadPokemonEvolutionViewModel());
  serviceLocator.registerFactory<LoadPokemonDetailViewModel>(
      () => LoadPokemonDetailViewModel());
  serviceLocator.registerFactory<FetchPokemonListViewModel>(
      () => FetchPokemonListViewModel());
}
