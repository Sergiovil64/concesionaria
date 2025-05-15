import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarea3/aplicacion/api_key.dart';
import 'aplicacion/app.dart';

void main() {
  OpenAI.apiKey = ApiKey.openAIApiKey;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: App()));
}