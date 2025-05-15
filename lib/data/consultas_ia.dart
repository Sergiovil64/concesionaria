import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';

class ConsultaIA {
  
  static Future<bool> esVehiculo(String b64) async {
    final check = await OpenAI.instance.chat.create(
      model: "gpt-4o-mini",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "You are a vehicle detector. Reply with exactly JSON {\"isVehicle\":true|false}."
            )
          ],
        ),
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Is there a vehicle in this image? Data URI: data:image/jpeg;base64,$b64"
            )
          ],
        ),
      ],
    );
    final contentItems = check.choices.first.message.content;

    final fullContent = contentItems != null
      ? contentItems.map((item) => item.text).join()
      : '';
    print(fullContent);
    final data = jsonDecode(fullContent) as Map<String, dynamic>;

    return data['isVehicle'] as bool;
  }

  static Future<List<String>> obtenerModeloPrecio(String b64) async {
    
    final info = await OpenAI.instance.chat.create(
      model: "gpt-4o-mini",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "You are a car expert. Reply with exactly JSON {\"model\":\"…\",\"price\":\"…\"}."
            )
          ],
        ),
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Identify the model and approximate price of this car. Data URI: data:image/jpeg;base64,$b64"
            )
          ],
        ),
      ],
    );

    final infoItems   = info.choices.first.message.content;
    final infoContent = infoItems != null ? infoItems.map((i) => i.text).join() : '';
    final result      = jsonDecode(infoContent) as Map<String, dynamic>;
    return [result['model'] ?? '', result['price'] ?? ''];
  }
}