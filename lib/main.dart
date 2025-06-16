import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/stores/theme_store.dart';
import 'app/app_module.dart';

final themeStore = ThemeStore();

void main() {
  runApp(ModularApp(module: AppModule(), child: MyApp()));
}

  // Inicialização do app usando Modular, com AppModule como módulo principal
  // E MyApp é o widget raiz que define o visual e as configurações do MaterialApp
  // Adicionado temas claro e escuro com AppBar personalizada
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeStore.themeMode,
      builder: (context, mode, _) {
        return MaterialApp.router(
          title: 'Social Feed',
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white, 
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
          themeMode: mode,
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }
}
