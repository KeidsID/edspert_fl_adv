import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract final class Env {
  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _Env.apiKey;
}
