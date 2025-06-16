// PostModel representa a estrutura de um post no feed da aplicação.
// Ele possui os campos essenciais como ID do usuário, ID do post, título e corpo do texto,
// além de um método de fábrica para converter dados JSON em uma instância do modelo.

class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.userId, 
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] as int, 
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}