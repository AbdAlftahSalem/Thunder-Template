/// API base URL and endpoints. `thunder feature` and `thunder c_api` add
/// endpoints here.
///
/// Change the base URL per build with `--dart-define=BASE_URL=https://...`.
class ApiConstants {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com/',
  );
  static const home = 'todos';
  // thunder:endpoints
}
