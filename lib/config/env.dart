class Env {
  static String baseApi = '';
  static const String imgRoot = 'https://apitepmare.vooomapp.com';
  static const String _prodApi = 'https://apitepmare.vooomapp.com/admin';
  static const String _localApi = 'http://localhost:8000/admin';

  static void prod() {
    baseApi = _prodApi;
  }

  static void local() {
    baseApi = _localApi;
  }
}
