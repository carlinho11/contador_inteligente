import 'package:contador_presenca/app/modules/inicio/inicio_module.dart';
import 'package:contador_presenca/app/repositories/local_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocalRepositoryImpl()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: InicioModule()),
    ModuleRoute('/home/', module: HomeModule()),
  ];
}
