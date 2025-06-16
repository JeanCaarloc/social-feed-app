import 'package:mobx/mobx.dart';
import '../../models/post_model.dart';
import '../../services/post_service.dart';

// HomeStore é a store responsável por gerenciar o estado da HomePage,
// utilizando MobX para reatividade. Ela lida com o carregamento dos posts,
// controla o estado de carregamento (`isLoading`) e mantém a lista de posts (`posts`).
// Os dados são buscados por meio do PostService e atualizados de forma observável.

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final PostService service = PostService();

  @observable
  ObservableList<PostModel> posts = ObservableList<PostModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> loadPosts() async {
    isLoading = true;
    posts.clear();
    final result = await service.fetchPosts();
    posts.addAll(result);
    isLoading = false;
  }
}