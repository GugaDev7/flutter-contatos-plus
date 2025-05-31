# 📱 Agenda de Contatos Flutter

Uma aplicação moderna de agenda de contatos desenvolvida com Flutter e Back4App. Este projeto demonstra a implementação de um CRUD completo com upload de imagens e gerenciamento de estado.

## ✨ Funcionalidades

- ✅ Lista de contatos com foto de perfil
- ➕ Adicionar novo contato
- 📝 Editar contato existente
- 🗑️ Excluir contato
- 📸 Upload de foto de perfil
- 💾 Armazenamento local das imagens
- 🔄 Sincronização com Back4App
- 🌐 Suporte para Web e Mobile

## 🚀 Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) - Framework UI
- [Back4App](https://www.back4app.com/) - Backend as a Service
- [Provider](https://pub.dev/packages/provider) - Gerenciamento de Estado
- [Image Picker](https://pub.dev/packages/image_picker) - Seleção de Imagens
- [Path Provider](https://pub.dev/packages/path_provider) - Gerenciamento de Arquivos
- [Flutter dotenv](https://pub.dev/packages/flutter_dotenv) - Variáveis de Ambiente

## 📁 Estrutura do Projeto

```
lib/
  ├── core/
  │   └── back4app_config.dart    # Configurações do Back4App
  ├── models/
  │   └── contato_model.dart      # Modelo de dados
  ├── providers/
  │   └── contato_provider.dart   # Gerenciamento de estado
  ├── screens/
  │   └── home_screen.dart        # Tela principal
  └── main.dart                   # Ponto de entrada
```

## ⚙️ Configuração

1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/flutter_contatos_plus.git
cd flutter_contatos_plus
```

2. Edite o arquivo `.env` na raiz do projeto:
```env
BACK4APP_APPLICATION_ID=seu_application_id
BACK4APP_CLIENT_KEY=sua_client_key
```

3. Instale as dependências
```bash
flutter pub get
```

4. Execute o aplicativo
```bash
flutter run
```

## 📱 Como Usar

1. **Adicionar Contato**
   - Toque no botão "+" no canto inferior direito
   - Toque no ícone da câmera para adicionar uma foto
   - Preencha os dados do contato
   - Toque em "Salvar"

2. **Editar Contato**
   - Toque sobre o contato na lista
   - Modifique os dados necessários
   - Toque em "Salvar"

3. **Excluir Contato**
   - Toque no ícone da lixeira ao lado do contato

## 🔒 Variáveis de Ambiente

O projeto utiliza as seguintes variáveis de ambiente (`.env`):

- `BACK4APP_APPLICATION_ID`: ID da aplicação no Back4App
- `BACK4APP_CLIENT_KEY`: Chave do cliente no Back4App

## 🤝 Contribuindo

1. Faça um Fork do projeto
2. Crie uma Branch para sua Feature (`git checkout -b feature/AmazingFeature`)
3. Faça o Commit das suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Faça o Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📧 Contato

**Autor:** Gustavo Rodrigues

**Email:** gustavo.rodriguesrj@outlook.com

**LinkedIn:** [Meu Perfil](https://www.linkedin.com/in/gustavo-rodrigues-167264361?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)

---

Desenvolvido com ❤️ usando Flutter.
