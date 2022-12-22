import 'injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

//Define the Environments here
const dev = Environment('dev');
const prod = Environment('prod');

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies({Environment environment = dev}) {
  //we init the dependencies using a speciffic env
  $initGetIt(getIt, environment: environment.name);
}
