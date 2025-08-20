# Sport Replay

Aplicativo para replay de vídeos gravados em uma quadra, desenvolvido em **Flutter** com integração ao **Firebase**.

## Funcionalidades

- Login e Cadastro de usuários (Firebase Authentication).
- Seleção de quadras e horários.
- Lista de vídeos (com download, compartilhar e salvar).
- Reprodução de vídeos com controle de tempo.
- Perfil do usuário com vídeos salvos.

## Organização do Projeto

```
lib/
├── main.dart                # Ponto de entrada da aplicação
├── routes.dart              # Definição das rotas
├── theme.dart               # Estilos e tema da aplicação
├── screens/
│   ├── login_screen.dart    # Tela de login
│   ├── register_screen.dart # Tela de cadastro
│   ├── home_screen.dart     # Tela inicial (seleção de quadra)
│   ├── schedule_screen.dart # Seleção de horários
│   ├── videos_list_screen.dart # Lista de vídeos
│   ├── video_player_screen.dart # Reprodução do vídeo
│   └── profile_screen.dart  # Perfil do usuário
└── services/
    └── firebase_service.dart # Funções auxiliares para Firebase
```