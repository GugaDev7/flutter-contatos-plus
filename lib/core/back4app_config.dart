import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppConfig {
  static String get applicationId =>
      dotenv.env['BACK4APP_APPLICATION_ID'] ?? '';
  static String get clientKey => dotenv.env['BACK4APP_CLIENT_KEY'] ?? '';
  static const String serverUrl = 'https://parseapi.back4app.com';
  static const String liveQueryUrl = 'wss://flutter_contatos_plus.b4a.io';
}
