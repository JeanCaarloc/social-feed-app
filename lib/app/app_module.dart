import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/home_module.dart';

// AppModule é o módulo principal da aplicação, responsável por registrar
// os módulos de funcionalidade (neste caso, o HomeModule) e definir
// as rotas iniciais usando o Flutter Modular para navegação e injeção de dependências.

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: HomeModule());
  }
}