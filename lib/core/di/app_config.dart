
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);