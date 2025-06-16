import 'package:dio/dio.dart';
import '../models/post_model.dart';

class PostService {
  final Dio dio = Dio(
    BaseOptions(
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'application/json',
      },
    ),
  );

  Future<List<PostModel>> fetchPosts() async {
    print('Iniciando busca de posts...');
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      print('Status: ${response.statusCode}');
      print('Dados recebidos: ${response.data}');
      return (response.data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('Erro ao buscar posts: ${e.message}');
      return [];
    }
  }
}