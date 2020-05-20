class PokemonService {
  String getImageFromUrl(String url) {
    String id = Uri.parse(url).pathSegments[3];
    return 'https://pokeres.bastionbot.org/images/pokemon/$id.png';
  }

  String getPath(String url) {
    String path = Uri.parse(url).path;
    return path;
  }

  String getPathWithQuery(String url) {
    String path = '${Uri.parse(url).path}?${Uri.parse(url).query}';
    return path;
  }
}
