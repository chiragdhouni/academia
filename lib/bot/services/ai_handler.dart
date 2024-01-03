import 'dart:convert';
import 'package:academia/bot/services/openai_service.dart';
import 'package:http/http.dart' as http;

class AIHandler {
  // String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  // String? generatedContent;
  Future<String> getResponse(String message) async {
    try {
      Future<String> res = openAIService.chatGPTAPI(message);
      print(res);
      return res;
    } catch (e) {
      return e.toString();
    }
  }
}
