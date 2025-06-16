import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dart:math';

// PostCard é um widget que representa visualmente um post individual.
// Ele recebe um `PostModel`, exibe suas informações básicas (ID, título e corpo),
// e mostra métricas aleatórias simuladas de likes, visualizações e comentários.
// Ao tocar no card ou no ícone de comentário, o usuário é levado para a tela de detalhes.
// Utiliza `Modular.to.pushNamed` para passar os dados do post via argumentos.
// O estilo é clean, com bordas arredondadas, fundo branco e layout bem organizado.

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({required this.post, super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  late int views;
  late int comments;

  @override
  void initState() {
    super.initState();
    final random = Random();
    likes = 500 + random.nextInt(500);
    views = 1000 + random.nextInt(3000);
    comments = 10 + random.nextInt(90);
  }

  void _goToDetail() {
    Modular.to.pushNamed(
      '/detail',
      arguments: {
        'post': widget.post,
        'likes': likes,
        'views': views,
        'comments': comments,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _goToDetail,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white, // Fundo branco sempre
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Postagem #${post.id}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Sempre preto
                ),
              ),
              const SizedBox(height: 10),
              Text(
                post.body,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.favorite_border, size: 18, color: Colors.black54),
                      SizedBox(width: 4),
                    ],
                  ),
                  Text(
                    '$likes',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.visibility, size: 18, color: Colors.black54),
                      SizedBox(width: 4),
                    ],
                  ),
                  Text(
                    '$views',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  InkWell(
                    onTap: _goToDetail,
                    child: Row(
                      children: const [
                        Icon(Icons.comment, size: 18, color: Colors.black54),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
                  Text(
                    '$comments',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
