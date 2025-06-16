# 📱 social_feed_app

Aplicativo Flutter de feed social, desenvolvido como parte de um teste técnico. Ele simula uma rede social com funcionalidades como curtidas, visualizações, comentários e alternância de tema.

---


## ⚙️ Funcionalidades

- 📝 Listagem de postagens com título e conteúdo.
- ❤️ Curtir postagens.
- 👀 Contador de visualizações (simulado).
- 💬 Comentários com campo de envio e confirmação.
- 🌗 Alternância entre tema claro e escuro.
- 📲 Navegação para página de detalhes do post.
- 📦 Arquitetura modular com injeção de dependência.

---

## 🧪 Tecnologias e Bibliotecas

| Tecnologia         | Descrição                                           |
|--------------------|-----------------------------------------------------|
| **Flutter**        | Framework principal multiplataforma.                |
| **Flutter Modular**| Gerenciamento de rotas e módulos.                   |
| **MobX**           | Estado reativo e observável.                        |
| **Dio**            | Cliente HTTP moderno e flexível.                    |
| **Material Design**| Interface nativa Android/iOS.                       |

---

## 🧩 Estrutura de Pastas

lib/
├── app/
│ ├── models/ # Modelos de dados (ex: PostModel)
│ ├── services/ # Serviços para comunicação externa
│ ├── stores/ # Armazenamento de estado com MobX
│ └── modules/
│ └── home/ # Módulo Home
│ │  ├── widgets/ # Componentes reutilizáveis (ex: PostCard, Toggle)
│ │  │  └── post_post_card.dart # Tela inicial de post
│ │  │  └── post_detail_page.dart # Tela de detalhes do post
│ │  │  └── theme_toggle_button.dart # Botão de tema claro e escuro
│ │  ├── home_page.dart # Tela principal com feed
│ │  ├── home_store.dart # Store da Home com MobX
│ │  ├── home_module.dart # Configuração do módulo com rotas    
└── main.dart # Ponto de entrada da aplicação

---

## ▶️ Como Executar

### Pré-requisitos

- Flutter SDK instalado: https://flutter.dev/docs/get-started/install
- Android Studio ou VS Code
- Emulador Android ou dispositivo físico

# Instale as dependências
flutter pub get

# Rode o app
flutter run