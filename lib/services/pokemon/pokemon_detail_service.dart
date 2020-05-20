import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/web_api/web_api.dart';
import 'package:uichallenge/services/web_api/web_api_implement.dart';

class PokemonDetailService {
  WebApiImpl _api = serviceLocator<WebApi>();
  Future<Map<String, dynamic>> loadPokemonDetail(String path) async {
    var res = await _api.get(path: path);
    return res;
  }

  Future<Map<String, dynamic>> loadPokemonEvolution(String path) async {
    var res = await _api.get(path: path);
    return res;
  }
}
