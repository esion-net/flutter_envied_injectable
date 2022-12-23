# flutter_envied_injectable 8-)

Better and automated .env integration in multiple environments example with ENVied, GetIt and injectable.

---

## Usage

**Running the example:**

Get packages:

```
flutter pub get
```

Build files:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

Run the example:

```
flutter run
```

**After changing .env files:**

ENVied **generator doesn't pick up the changes** to .env files on its own. You have to **change something** in the corresponding `env_dev.dart/env_prod.dart` for `envied_generator` to pick up changes for this file. Changing anything in a comment (a simple letter) seems sufficient. I haven't opened an issue (yet).

Then you rebuild the files again:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

---

**Details:**

```dart
import 'package:flutter/foundation.dart' show kDebugMode;
```

I am using `bool const kDebugMode` the determine which version of the app (`debug/profile/release`) gets built. `kDebugMode` is only `false` for `release` and `true` for the other two. It's the recommended method for stuff like that and part of `flutter/foundation`.

```dart
configureDependencies(environment: kDebugMode ? dev : prod);
```

The `environment` for [injectable](https://pub.dev/packages/injectable) is set according to `kDebugMode`, so `dev` for `debug/profile` and `prod` for `release`. This telles injectable to only load one of the `Env` classes (`EnvDev/EnvProd`) and inject it as `Env` via [GetIt](https://pub.dev/packages/get_it).

```dart
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
```

I've tried to include all possible usecases (you might wanna implement `notFromEnv` somewhere else) and how to retrieve them in the `EnvDev/EnvProd` classes. Use the `obfuscate: true` example for your secrets and keys.

```dart
print(getIt<Env>().title);
```

Put together makes `title` either `DEV_Title from .env.dev` or `Production_Title from .env.prod` depending on the environment you've build for. Available in your Classes/Widgets.

**Magic!**

---

**Good to know:**

- You don't have to use `kDebugMode`. Feel free to implement your own logic.
- You can configure as many environments as you like with injectable.
- `EnvDev/EnvProd` (with `abstract Env`) reflects the variables used in the `.env` files. Missing variables in any of the `.env` files will cause `build_runner` to fail.
- Also, the contents of `EnvDev/EnvProd` should be pretty much the same. You can duplicate the code if you introduce a new `.env` variable.

---

### Background / Motivation:

I am about to start coding my actual app after building a prototype in early 2022. I decided to do it from scratch and read a lot about latest architecture and new packages and was looking for the perfect boilerplate to start off with (hint: I didn't find it). During my search, I stumbled upon Dan Patacean's article (not only) about [injection based on environments](https://medium.com/@dan.patacean/flutter-stories-dependency-injection-with-injectable-and-getit-fb95ee7758df) and Code with Andrea's article about [how to store API keys more secure](https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/) with the [ENVied package](https://pub.dev/packages/envied). Better security with storing keys sounded awesome for multi enviroment (dev/prod) and there is a conditional example provided by ENVied but I didn't get it to work with Flutter. So I combined ENVied with [injectable](https://pub.dev/packages/injectable) and created this example.

**Read on:**

- **[How to Store API Keys in Flutter: --dart-define vs .env files](https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/)** by Code with Andrea’.
- **[Advanced dependency Injection with injectable and getIt](https://medium.com/@dan.patacean/flutter-stories-advanced-dependency-injection-with-injectable-and-getit-1d71d21dea01)** by Dan Patacean.

---
