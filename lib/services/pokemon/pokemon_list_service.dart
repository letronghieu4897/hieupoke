import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/web_api/web_api.dart';
import 'package:uichallenge/services/web_api/web_api_implement.dart';

class PokemonListService {
  WebApiImpl _api = serviceLocator<WebApi>();
  Future<Map<String, dynamic>> fetchPokemonList({String path}) async {
    String pathDefault = '/api/v2/pokemon';
    var res = await _api.get(path: path ?? pathDefault);
    return res;
  }
}
