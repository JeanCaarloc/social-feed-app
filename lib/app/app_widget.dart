import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


// AppWidget é o widget principal da aplicação. Ele configura o MaterialApp
// com suporte ao sistema de rotas do Flutter Modular, incluindo o tema,
// título e as delegações de roteamento para navegação entre as páginas.

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Social Feed',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}