import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import 'theme_toggle_button.dart';

// Página de detalhes do post que exibe título, corpo, autor e contadores de curtidas,
// visualizações e comentários. Permite curtir, abrir campo para comentar e enviar comentários,
// atualizando a interface localmente. Usa StatefulWidget para gerenciar estado.

class PostDetailPage extends StatefulWidget {
  final PostModel post;
  final int initialLikes;
  final int initialViews;
  final int initialComments;

  const PostDetailPage({
    super.key,
    required this.post,
    required this.initialLikes,
    required this.initialViews,
    required this.initialComments,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late int likes;
  late int views;
  late int comments;
  bool showCommentField = false;
  final TextEditingController _commentController = TextEditingController();
  bool commentSent = false;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes;
    views = widget.initialViews + 1; // simula nova visualização
    comments = widget.initialComments;
  }

  void _incrementLike() {
    setState(() {
      likes++;
    });
  }

  void _toggleCommentField() {
    setState(() {
      showCommentField = !showCommentField;
      commentSent = false;
    });
  }

  void _sendComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        commentSent = true;
        comments++;
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Post'),
        actions: const [ThemeToggleButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Usuário #${post.userId}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 88, 166, 255),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Postagem #${post.id}",
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            SizedBox(height: 12),
            Text(
              post.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(post.body, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            // Contadores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: _incrementLike,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '$likes curtidas',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '$views visualizações',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: _toggleCommentField,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.comment),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '$comments comentários',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Campo de comentário
            if (showCommentField) ...[
              Divider(height: 32),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Digite seu comentário...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _sendComment,
                icon: Icon(Icons.send),
                label: Text("Enviar"),
              ),
              if (commentSent)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Comentário enviado com sucesso!",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
