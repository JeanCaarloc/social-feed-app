import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:math';
import 'home_store.dart';
import 'widgets/post_card.dart';
import '../../models/post_model.dart';
import 'widgets/theme_toggle_button.dart';


// HomePage é a tela principal do app, responsável por exibir os posts organizados por usuário.
// Ela carrega os posts através do HomeStore, agrupa por `userId` e exibe cada grupo em um carrossel horizontal.
// Cada card de post é exibido com botões de navegação (avançar/voltar) estilizados como círculos com opacidade.
// O botão de alternar tema está presente na AppBar, e a tela utiliza MobX com Observer para reatividade.


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();
  final Map<int, PageController> _controllers = {};

  @override
  void initState() {
    super.initState();
    store.loadPosts();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<int, List<PostModel>> groupPostsByUser(List<PostModel> posts) {
    final Map<int, List<PostModel>> grouped = {};
    for (var post in posts) {
      grouped.putIfAbsent(post.userId, () => []);
      grouped[post.userId]!.add(post);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        actions: const [
          ThemeToggleButton(),
        ],
      ),  
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (store.posts.isEmpty) {
            return const Center(child: Text('Nenhum post encontrado.'));
          }

          final groupedPosts = groupPostsByUser(store.posts);

          return ListView.builder(
            itemCount: groupedPosts.length,
            itemBuilder: (context, index) {
              final userId = groupedPosts.keys.elementAt(index);
              final userPosts = groupedPosts[userId]!;

              _controllers.putIfAbsent(
                userId,
                () => PageController(viewportFraction: 0.88),
              );

              final controller = _controllers[userId]!;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Usuário #$userId',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 88, 166, 255),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 340,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: userPosts.length,
                            itemBuilder: (context, postIndex) {
                              final post = userPosts[postIndex];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: PostCard(post: post),
                              );
                            },
                          ),

                          // Botão Voltar (left)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: _ArrowButton(
                              direction: ArrowDirection.left,
                              onTap: () {
                                final prevPage = max(
                                  controller.page!.toInt() - 1,
                                  0,
                                );
                                controller.animateToPage(
                                  prevPage,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),

                          // Botão Avançar (right)
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: _ArrowButton(
                              direction: ArrowDirection.right,
                              onTap: () {
                                final nextPage = min(
                                  controller.page!.toInt() + 1,
                                  userPosts.length - 1,
                                );
                                controller.animateToPage(
                                  nextPage,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Enum para facilitar direções das setas
enum ArrowDirection { left, right }

// Botão customizado com efeito hover e estilo cinza transparente
class _ArrowButton extends StatefulWidget {
  final ArrowDirection direction;
  final VoidCallback onTap;

  const _ArrowButton({required this.direction, required this.onTap});

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.withAlpha((0.2 * 255).round());
    final hoverColor = Colors.grey.withAlpha((0.6 * 255).round());

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap,
        child: Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hovering ? hoverColor : baseColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.direction == ArrowDirection.left
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_forward_ios_rounded,
            color: _hovering ? Colors.black87 : Colors.black38,
            size: 20,
          ),
        ),
      ),
    );
  }
}
