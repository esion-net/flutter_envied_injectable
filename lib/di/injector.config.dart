// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:flutter_envied_injectable/env/env.dart' as _i3;
import 'package:flutter_envied_injectable/env/env_dev.dart' as _i5;
import 'package:flutter_envied_injectable/env/env_prod.dart' as _i4;

const String _prod = 'prod';
const String _dev = 'dev';

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.Env>(
    () => _i4.EnvProd(),
    registerFor: {_prod},
  );
  gh.factory<_i3.Env>(
    () => _i5.EnvDev(),
    registerFor: {_dev},
  );
  return getIt;
}
