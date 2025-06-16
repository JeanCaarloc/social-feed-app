import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';
import 'home_store.dart';
import 'widgets/post_detail_page.dart';
import '../../models/post_model.dart';

// HomeModule é o módulo responsável por agrupar a lógica da tela inicial (Home).
// Ele registra a injeção do HomeStore e define as rotas relacionadas à HomePage e
// à PostDetailPage, utilizando o Flutter Modular para navegação e gerenciamento de dependências.

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeStore>(() => HomeStore());
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => HomePage());
    r.child('/detail', child: (_) => PostDetailPage(
      post: Modular.args.data['post'] as PostModel,
      initialLikes: Modular.args.data['likes'] as int,
      initialViews: Modular.args.data['views'] as int,
      initialComments: Modular.args.data['comments'] as int,
    ));
  }
}