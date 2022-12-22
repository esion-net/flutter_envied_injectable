import 'package:injectable/injectable.dart';
import 'package:envied/envied.dart';
import 'env.dart';

part 'env_dev.g.dart';

// Change Me for envied_generator to pick up changes to .env.dev

@Environment('dev')
@Injectable(as: Env)
@Envied(name: 'Env', path: '.env.dev')
class EnvDev extends Env {
  @override
  String get notFromEnv => "String not from file. (dev)";

  @EnviedField(varName: 'TITLE', obfuscate: false)
  static const String _title = _Env._title;
  @override
  String get title => _title;

  @EnviedField(varName: 'SECRET', obfuscate: true)
  static final String _secret = _Env._secret;
  @override
  String get secret => _secret;
}
