class Env {
  static String baseApi = '';
  static const String imgRoot = 'https://apitepmare.vooomapp.com';
  static const String _prodApi = 'https://apitepmare.vooomapp.com/admin';
  static const String _localApi = 'http://192.168.1.11:8000/admin';

  static void prod() {
    baseApi = _prodApi;
  }

  static void local() {
    baseApi = _localApi;
  }
}
