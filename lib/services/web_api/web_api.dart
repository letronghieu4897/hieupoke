abstract class WebApi {
  Future<Map<String, dynamic>> get();

  Future<Map<String, dynamic>> post();

  Future<Map<String, dynamic>> put();

  Future<Map<String, dynamic>> delete();
}
