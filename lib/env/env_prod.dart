import 'package:injectable/injectable.dart';
import 'package:envied/envied.dart';
import 'env.dart';
import 'env_dev.dart';

part 'env_prod.g.dart';

// Change Me for envied_generator to pick up changes to .env.prod

@Environment('prod')
@Injectable(as: Env)
@Envied(name: 'Env', path: '.env.prod')
class EnvProd extends EnvDev {
  @override
  String get notFromEnv => "String not from file. (prod)";

  @EnviedField(varName: 'TITLE', obfuscate: false)
  static const String _title = _Env._title;
  @override
  String get title => _title;

  @EnviedField(varName: 'SECRET', obfuscate: true)
  static final String _secret = _Env._secret;
  @override
  String get secret => _secret;
}
