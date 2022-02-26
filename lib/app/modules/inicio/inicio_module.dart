import 'package:contador_presenca/app/modules/inicio/inicio_Page.dart';
import 'package:contador_presenca/app/modules/inicio/inicio_store.dart';
import 'package:contador_presenca/app/repositories/local_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InicioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => InicioStore(LocalRepositoryImpl())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const InicioPage()),
  ];
}
